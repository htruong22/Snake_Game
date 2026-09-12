module Keyboard_Controller (
    input  wire       ps2_clk,
    input  wire       ps2_data,
    output reg  [4:0] direction,   
    output reg        reset_cmd   
);

    reg [10:0] shift_reg;
    reg [3:0]  bit_count = 0;
    reg        key_break = 0; 

    // Khởi tạo trạng thái ban đầu
    initial begin
        direction = 5'b10000;
        reset_cmd = 0;
    end

    always @(negedge ps2_clk) begin
        // 1. Dịch bit vào thanh ghi
        shift_reg[bit_count] <= ps2_data;
        bit_count <= bit_count + 1;

        // 2. Khi đã nhận đủ 11 bit (1 khung truyền PS/2)
        if (bit_count == 10) begin 
            bit_count <= 0; // Reset đếm bit
            
            // Xử lý mã nhả phím (Break Code)
            if (shift_reg[8:1] == 8'hF0) begin
                key_break <= 1;    // Đánh dấu bắt đầu nhả phím
                reset_cmd <= 0;    // Tắt ngay lệnh Reset
            end
            
            // Xử lý mã nhấn phím (Make Code)
            else if (key_break == 0) begin
                case (shift_reg[8:1])
                    8'h1D: direction <= 5'b00010; // W (Lên)
                    8'h1C: direction <= 5'b00100; // A (Trái)
                    8'h1B: direction <= 5'b01000; // S (Xuống)
                    8'h23: direction <= 5'b10000; // D (Phải)
                    8'h5A: reset_cmd <= 1;        // Enter (Kích hoạt Reset)
                endcase
            end
            
            // Kết thúc quá trình nhả phím (Bỏ qua byte thứ 2 sau F0)
            else begin
                key_break <= 0; 
                reset_cmd <= 0; // Đảm bảo Reset được tắt hoàn toàn
            end
        end
    end

endmodule