`timescale 1ns/1ps

module tb_Snake();
    reg CLOCK_50;
    reg PS2_CLK;
    reg PS2_DAT;
    reg SW0_RESET;
    
    wire [9:0] VGA_R, VGA_G, VGA_B;
    wire VGA_HS, VGA_VS;
    wire VGA_BLANK_N, VGA_SYNC_N, VGA_CLK;
	 
	 wire [9:0] LEDR;
    wire [6:0] HEX0; 
    wire [6:0] HEX1;

    Snake_Top uut (
        .CLOCK_50(CLOCK_50),
        .PS2_CLK(PS2_CLK),
        .PS2_DAT(PS2_DAT),
        .SW0_RESET(SW0_RESET),
		  
        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B),
		  
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS),
        .VGA_CLK(VGA_CLK),
        .VGA_BLANK_N(VGA_BLANK_N),
        .VGA_SYNC_N(VGA_SYNC_N),
		  
		  .LEDR(LEDR),
        .HEX0(HEX0),
        .HEX1(HEX1)
    );

    always #10 CLOCK_50 = ~CLOCK_50;

    initial begin

        CLOCK_50 = 0;
        PS2_CLK = 1;
        PS2_DAT = 1;
        SW0_RESET = 0;

        #100;
        SW0_RESET = 1; 

        #40000000; 
        
        $stop; 
    end

endmodule