/*module Snake_Top (
    input  wire       CLOCK_50,   
    input  wire       PS2_CLK,     
    input  wire       PS2_DAT,
    input  wire       SW0_RESET,   
    
    output reg  [9:0] VGA_R, VGA_G, VGA_B,
    output wire       VGA_HS, VGA_VS,
    output wire       VGA_BLANK_N, VGA_SYNC_N, VGA_CLK, 
    
    output wire [9:0] LEDR,        
    output wire [6:0] HEX0, HEX1   
);

    wire [10:0] px_x;
    wire [9:0]  px_y;
    wire video_on;
    wire game_tick;
    wire [4:0] key_dir;
    reg  [4:0] cur_dir;
    wire reset_kb;
    wire [10:0] rnd_x;
    wire [8:0]  rnd_y;
	 wire text_pixel;
    
	 
    reg [10:0] apple_x;
    reg [8:0]  apple_y;
    reg [10:0] snake_x [0:127];
    reg [9:0]  snake_y [0:127];
    reg [6:0]  snake_len;
    reg [7:0]  score;
    reg game_over;
    

    reg is_border, is_obstacle, is_apple, is_head, is_body;
    integer i;

	 
    assign VGA_CLK    = CLOCK_50;
    assign VGA_SYNC_N = 1'b1;
    assign LEDR[4:0]  = cur_dir;

    VGA_Controller vga (
        .VGA_clk(VGA_CLK), 
		  .pixel_x(px_x), 
		  .pixel_y(px_y), 
        .video_on(video_on), 
		  .h_sync(VGA_HS), 
		  .v_sync(VGA_VS), 
        .blank_n(VGA_BLANK_N)
    );

    Game_Clock clk_gen (
        .CLOCK_50(CLOCK_50), 
		  .score(score), 
		  .game_tick(game_tick)
    );

    Keyboard_Controller kb (
        .ps2_clk(PS2_CLK), 
		  .ps2_data(PS2_DAT), 
        .direction(key_dir), 
		  .reset_cmd(reset_kb)
    );

    Random_Generator rng (
        .VGA_clk(VGA_CLK), 
		  .rnd_x(rnd_x), 
		  .rnd_y(rnd_y)
    );
	 
	 GameOver_Display text_gen(
		  .px_x(px_x),
		  .px_y(px_y),
		  .is_text(text_pixel)
	 );

    Hex_Decoder h0 (score % 10, HEX0);
    Hex_Decoder h1 ((score / 10) % 10, HEX1);

    always @(posedge VGA_CLK) begin
        is_border <= (px_x < 10 || px_x >= 790 || px_y < 10 || px_y >= 590);
        
        is_obstacle <= ((px_x >= 200 && px_x < 300) && (px_y >= 140 && px_y < 160)) ||
                       ((px_x >= 500 && px_x < 600) && (px_y >= 440 && px_y < 460)) ||
                       ((px_x >= 580 && px_x < 600) && (px_y >= 150  && px_y < 250)) ||
                       ((px_x >= 200 && px_x < 220) && (px_y >= 350 && px_y < 450));

        is_apple <= (px_x >= apple_x && px_x < apple_x + 10 && 
                     px_y >= apple_y && px_y < apple_y + 10);

        is_head <= (px_x >= snake_x[0] && px_x < snake_x[0] + 10 && 
                    px_y >= snake_y[0] && px_y < snake_y[0] + 10);
			
		  is_body = 0;
        for (i = 1; i < snake_len && i < 64; i = i + 1) begin
            if (px_x >= snake_x[i] && px_x < snake_x[i] + 10 && 
                px_y >= snake_y[i] && px_y < snake_y[i] + 10)
                is_body = 1;
		  end
    end
	 
    wire r_on, g_on, b_on;
    assign r_on = video_on && ((is_apple && ~(is_head || is_body)) || game_over );
    assign g_on = video_on && (((is_head || is_body) && ~game_over) || (text_pixel&&game_over));
    assign b_on = video_on && ((is_border || is_obstacle) && ~game_over);

    always @(posedge VGA_CLK) begin
        VGA_R <= {10{r_on}};
        VGA_G <= {10{g_on}};
        VGA_B <= {10{b_on}};
    end

    always @(posedge game_tick) begin
        if (~SW0_RESET || reset_kb) begin 
            snake_x[0] <= 400; snake_y[0] <= 300;
            apple_x <= 420;    apple_y <= 300;
            snake_len <= 1;    score <= 0;
            game_over <= 0;    cur_dir <= 5'b10000;
        end
        else if (!game_over) begin 
            case (key_dir)
                5'b00010: if (cur_dir != 5'b01000) cur_dir <= 5'b00010;
                5'b00100: if (cur_dir != 5'b10000) cur_dir <= 5'b00100; 
                5'b01000: if (cur_dir != 5'b00010) cur_dir <= 5'b01000; 
                5'b10000: if (cur_dir != 5'b00100) cur_dir <= 5'b10000; 
            endcase


            for (i = 127; i > 0; i = i - 1) begin
                snake_x[i] <= snake_x[i-1];
                snake_y[i] <= snake_y[i-1];
            end


            case (cur_dir)
                5'b00010: snake_y[0] <= snake_y[0] - 10;
                5'b00100: snake_x[0] <= snake_x[0] - 10;
                5'b01000: snake_y[0] <= snake_y[0] + 10;
                5'b10000: snake_x[0] <= snake_x[0] + 10;
            endcase


            if ((snake_x[0] < 10 || snake_x[0] >= 790 || snake_y[0] < 10 || snake_y[0] >= 590) ||
                ((snake_x[0] >= 200 && snake_x[0] < 300) && (snake_y[0] >= 140 && snake_y[0] < 160)) ||
                ((snake_x[0] >= 500 && snake_x[0] < 600) && (snake_y[0] >= 440 && snake_y[0] < 460)) ||
                ((snake_x[0] >= 580 && snake_x[0] < 600) && (snake_y[0] >= 150  && snake_y[0] < 250)) ||
                ((snake_x[0] >= 200 && snake_x[0] < 220) && (snake_y[0] >= 350 && snake_y[0] < 450)))
				begin
                game_over <= 1;
				end


            if (snake_len > 4) begin
                for (i = 4; i < snake_len; i = i + 1)
                    if (snake_x[0] == snake_x[i] && snake_y[0] == snake_y[i])
                        game_over <= 1;
            end


            if ((snake_x[0] >= apple_x && snake_x[0] < apple_x + 10) && 
                (snake_y[0] >= apple_y && snake_y[0] < apple_y + 10)) 
            begin
                snake_len <= snake_len + 1;
                score <= score + 1;
                apple_x <= ((rnd_x < 20 || rnd_x > 770)||(rnd_x >= 200 && rnd_x < 300)||(rnd_x >= 500 && rnd_x < 600)||(rnd_x >= 580 && rnd_x < 600)||(rnd_x >= 200 && rnd_x < 220)) ? 100 : rnd_x;
                apple_y <= ((rnd_y < 20 || rnd_y > 570)||(rnd_y >= 140 && rnd_y < 160)||(rnd_y >= 440 && rnd_y < 460)||(rnd_y >= 150 && rnd_y < 250)||(rnd_y >= 350 && rnd_y < 450)) ? 100 : rnd_y;
            end
        end
    end

endmodule*/

module Snake_Top (
    input  wire        CLOCK_50,   
    input  wire        PS2_CLK,     
    input  wire        PS2_DAT,
    input  wire        SW0_RESET,   
    
    output reg  [9:0]  VGA_R, VGA_G, VGA_B,
    output wire        VGA_HS, VGA_VS,
    output wire        VGA_BLANK_N, VGA_SYNC_N, VGA_CLK, 
    
    output wire [9:0]  LEDR,        
    output wire [6:0]  HEX0, HEX1   
);

    // Dây tín hiệu kết nối nội bộ
    wire [10:0] px_x;
    wire [9:0]  px_y;
    wire        video_on;
    wire        game_tick;
    wire [4:0]  key_dir;
    wire [4:0]  cur_dir;
    wire        reset_kb;
    wire [10:0] rnd_x;
    wire [8:0]  rnd_y;
    wire        text_pixel;
    wire [7:0]  score;
    wire        game_over;
    
    // Cờ trạng thái hiển thị
    wire is_border, is_obstacle, is_apple, is_head, is_body;
    
    // Gán tín hiệu cơ bản
    assign VGA_CLK    = CLOCK_50;
    assign VGA_SYNC_N = 1'b1;
    assign LEDR[4:0]  = cur_dir;

    // =======================================================
    // 1. KHỞI TẠO CÁC MODULE NGOẠI VI
    // =======================================================
    VGA_Controller vga (
        .VGA_clk(VGA_CLK), 
        .pixel_x(px_x), 
        .pixel_y(px_y), 
        .video_on(video_on), 
        .h_sync(VGA_HS), 
        .v_sync(VGA_VS), 
        .blank_n(VGA_BLANK_N)
    );

    Game_Clock clk_gen (
        .CLOCK_50(CLOCK_50), 
        .score(score), 
        .game_tick(game_tick)
    );

    Keyboard_Controller kb (
        .ps2_clk(PS2_CLK), 
        .ps2_data(PS2_DAT), 
        .direction(key_dir), 
        .reset_cmd(reset_kb)
    );

    Random_Generator rng (
        .VGA_clk(VGA_CLK), 
        .rnd_x(rnd_x), 
        .rnd_y(rnd_y)
    );
    
    GameOver_Display text_gen(
        .px_x(px_x),
        .px_y(px_y),
        .is_text(text_pixel)
    );

    Hex_Decoder h0 (score % 10, HEX0);
    Hex_Decoder h1 ((score / 10) % 10, HEX1);

    // =======================================================
    // 2. KHỞI TẠO MODULE XỬ LÝ TRUNG TÂM (GAME LOGIC)
    // =======================================================
    Game_Logic logic_core (
        .VGA_CLK(VGA_CLK),
        .game_tick(game_tick),
        .SW0_RESET(SW0_RESET),
        .reset_kb(reset_kb),
        .key_dir(key_dir),
        .px_x(px_x),
        .px_y(px_y),
        .rnd_x(rnd_x),
        .rnd_y(rnd_y),
        .score(score),
        .game_over(game_over),
        .cur_dir(cur_dir),
        .is_border(is_border),
        .is_obstacle(is_obstacle),
        .is_apple(is_apple),
        .is_head(is_head),
        .is_body(is_body)
    );

    // =======================================================
    // 3. LOGIC HIỂN THỊ ĐỒ HỌA (MULTIPLEXER MÀU SẮC)
    // =======================================================
    always @(posedge VGA_CLK) begin
        if (~VGA_BLANK_N) begin
            VGA_R <= 10'd0; VGA_G <= 10'd0; VGA_B <= 10'd0;
        end 
        else if (game_over) begin
            if (text_pixel) begin
                VGA_R <= 10'h3FF; VGA_G <= 10'h3FF; VGA_B <= 10'h000;
            end else begin
                VGA_R <= 10'h155; VGA_G <= 10'h000; VGA_B <= 10'h000;
            end
        end 
        else begin
            if (is_head) begin
                VGA_R <= 10'h3FF; VGA_G <= 10'h2AA; VGA_B <= 10'h000;
            end 
            else if (is_body) begin
                VGA_R <= 10'h000; VGA_G <= 10'h3FF; VGA_B <= 10'h000;
            end 
            else if (is_apple) begin
                VGA_R <= 10'h3FF; VGA_G <= 10'h000; VGA_B <= 10'h000;
            end 
            else if (is_border || is_obstacle) begin
                VGA_R <= 10'h1AA; VGA_G <= 10'h2AA; VGA_B <= 10'h3FF;
            end 
            else begin
                if (px_x % 10 == 0 || px_y % 10 == 0) begin
                    VGA_R <= 10'h044; VGA_G <= 10'h044; VGA_B <= 10'h044;
                end 
                else begin
                    VGA_R <= 10'h000;
                    VGA_G <= {px_y[9:2], 2'b00};
                    VGA_B <= {px_y[8:0], 1'b0};
                end
            end
        end
    end

endmodule