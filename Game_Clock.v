module Game_Clock (
    input  wire       CLOCK_50,
    input  wire [7:0] score,        
    output reg        game_tick     
);

    reg [23:0] counter;
    reg [23:0] speed_limit; 

    always @(*) begin
        if      (score < 5)  speed_limit = 2000000; 
        else if (score < 10) speed_limit = 1500000; 
        else if (score < 20) speed_limit = 1000000; 
        else if (score < 30) speed_limit = 500000; 
        else                 speed_limit = 300000; 
    end

    always @(posedge CLOCK_50) begin
        counter <= counter + 1;
        if (counter >= speed_limit) begin
            game_tick <= ~game_tick;
            counter   <= 0;
        end
    end

endmodule