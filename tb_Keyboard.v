`timescale 1ns/1ps

module tb_Keyboard();

    reg clk_50;      
    reg ps2_clk;     
    reg ps2_data;    
    
    wire [4:0] direction; 
    wire reset_cmd;       

    Keyboard_Controller uut (
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .direction(direction),
        .reset_cmd(reset_cmd)
    );

    always #10 clk_50 = ~clk_50; 

    task send_byte_ps2;
        input [7:0] byte_data;
        integer i;
        reg parity;
        begin
            parity = ~(^byte_data); 

            ps2_data = 0;
            #20000 ps2_clk = 0; #20000 ps2_clk = 1; 

            for (i=0; i<8; i=i+1) begin
                ps2_data = byte_data[i];
                #20000 ps2_clk = 0; #20000 ps2_clk = 1;
            end

            ps2_data = parity;
            #20000 ps2_clk = 0; #20000 ps2_clk = 1;

            ps2_data = 1;
            #20000 ps2_clk = 0; #20000 ps2_clk = 1;
            

            #50000; 
        end
    endtask

    initial begin

        clk_50 = 0;
        ps2_clk = 1; 
        ps2_data = 1;

        $display("=== BAT DAU TEST BAN PHIM PS/2 ===");
        #1000; 
		  
        $display("Time: %t - Nhan phim W (1D)", $realtime);
        send_byte_ps2(8'h1D); 
        
        #100000; 
        if (direction == 5'b00010) $display("--> PASS: Da nhan dien huong LEN");
        else $display("--> FAIL: Loi huong LEN. Nhan duoc: %b", direction);
		  
        $display("Time: %t - Nha phim W (F0, 1D)", $realtime);
        send_byte_ps2(8'hF0); 
        send_byte_ps2(8'h1D); 
        
        #100000;
        if (direction == 5'b00010) $display("--> PASS: Huong van giu nguyen khi nha phim");
        
        $display("Time: %t - Nhan phim A (1C)", $realtime);
        send_byte_ps2(8'h1C);
        
        #100000;
        if (direction == 5'b00100) $display("--> PASS: Da nhan dien huong TRAI");
        else $display("--> FAIL: Loi huong TRAI. Nhan duoc: %b", direction);

        $display("Time: %t - Nhan phim Enter (5A)", $realtime);
        send_byte_ps2(8'h5A);
        
        #100000;
        if (reset_cmd == 1) $display("--> PASS: Da nhan dien lenh RESET");
        else $display("--> FAIL: Loi RESET");

        $display("=== KET THUC TEST ===");
        $stop;
    end

endmodule