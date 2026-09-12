module GameOver_Display (
    input wire [10:0] px_x, 
    input wire [9:0]  px_y,
    output wire       is_text 
);

    wire char_G, char_A, char_M, char_E1; 
    wire char_O, char_V, char_E2, char_R; 
	 
    assign char_G = 
        ((px_x >= 260 && px_x < 290) && (px_y >= 250 && px_y < 260)) || 
        ((px_x >= 260 && px_x < 270) && (px_y >= 250 && px_y < 300)) || 
        ((px_x >= 260 && px_x < 290) && (px_y >= 290 && px_y < 300)) || 
        ((px_x >= 280 && px_x < 290) && (px_y >= 270 && px_y < 300)) || 
        ((px_x >= 270 && px_x < 290) && (px_y >= 270 && px_y < 280));   

    assign char_A = 
        ((px_x >= 300 && px_x < 310) && (px_y >= 250 && px_y < 300)) || 
        ((px_x >= 320 && px_x < 330) && (px_y >= 250 && px_y < 300)) || 
        ((px_x >= 300 && px_x < 330) && (px_y >= 250 && px_y < 260)) || 
        ((px_x >= 300 && px_x < 330) && (px_y >= 270 && px_y < 280));   

    assign char_M = 
        ((px_x >= 340 && px_x < 350) && (px_y >= 250 && px_y < 300)) || 
        ((px_x >= 360 && px_x < 370) && (px_y >= 250 && px_y < 300)) ||
        ((px_x >= 340 && px_x < 370) && (px_y >= 250 && px_y < 260)) || 
        ((px_x >= 350 && px_x < 360) && (px_y >= 250 && px_y < 280));   

    assign char_E1 = 
        ((px_x >= 380 && px_x < 390) && (px_y >= 250 && px_y < 300)) || 
        ((px_x >= 380 && px_x < 410) && (px_y >= 250 && px_y < 260)) || 
        ((px_x >= 380 && px_x < 400) && (px_y >= 270 && px_y < 280)) || 
        ((px_x >= 380 && px_x < 410) && (px_y >= 290 && px_y < 300));   

    assign char_O = 
        ((px_x >= 440 && px_x < 450) && (px_y >= 250 && px_y < 300)) || 
        ((px_x >= 460 && px_x < 470) && (px_y >= 250 && px_y < 300)) || 
        ((px_x >= 440 && px_x < 470) && (px_y >= 250 && px_y < 260)) || 
        ((px_x >= 440 && px_x < 470) && (px_y >= 290 && px_y < 300));   

    assign char_V = 
        ((px_x >= 480 && px_x < 490) && (px_y >= 250 && px_y < 290)) || 
        ((px_x >= 500 && px_x < 510) && (px_y >= 250 && px_y < 290)) || 
        ((px_x >= 480 && px_x < 510) && (px_y >= 290 && px_y < 300));   

    assign char_E2 = 
        ((px_x >= 520 && px_x < 530) && (px_y >= 250 && px_y < 300)) || 
        ((px_x >= 520 && px_x < 550) && (px_y >= 250 && px_y < 260)) || 
        ((px_x >= 520 && px_x < 540) && (px_y >= 270 && px_y < 280)) || 
        ((px_x >= 520 && px_x < 550) && (px_y >= 290 && px_y < 300)); 

    assign char_R = 
        ((px_x >= 560 && px_x < 570) && (px_y >= 250 && px_y < 300)) || 
        ((px_x >= 560 && px_x < 590) && (px_y >= 250 && px_y < 260)) || 
        ((px_x >= 560 && px_x < 590) && (px_y >= 270 && px_y < 280)) || 
        ((px_x >= 580 && px_x < 590) && (px_y >= 250 && px_y < 280)) || 
        ((px_x >= 570 && px_x < 580) && (px_y >= 280 && px_y < 290)) ||
		  ((px_x >= 580 && px_x < 590) && (px_y >= 290 && px_y < 300));   

    assign is_text = char_G || char_A || char_M || char_E1 || char_O || char_V || char_E2 || char_R;

endmodule