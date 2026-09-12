module Random_Generator (
    input  wire        VGA_clk,
    output reg [10:0]  rnd_x, 
    output reg [8:0]   rnd_y  
);

    reg [6:0] cnt_x = 10; 
    reg [5:0] cnt_y = 10; 

    always @(posedge VGA_clk) cnt_x <= cnt_x + 3;
    always @(posedge VGA_clk) cnt_y <= cnt_y + 1;

    always @(posedge VGA_clk) begin
        if (cnt_x > 78)      rnd_x <= 780; 
        else if (cnt_x < 2)  rnd_x <= 20;  
        else                 rnd_x <= (cnt_x * 10);
    end

    always @(posedge VGA_clk) begin
        if (cnt_y > 58)      rnd_y <= 580; 
        else if (cnt_y < 2)  rnd_y <= 20;  
        else                 rnd_y <= (cnt_y * 10);
    end

endmodule
