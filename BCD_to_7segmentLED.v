module BCD_to_7segmentLED(
		input 	[3:0]data_in,
		input 	clk, reset,
		output reg	[6:0]LED_segment
	);
	
	parameter ZERO_bcd 			= 4'b0000,
				 ONE_bcd 			= 4'b0001,
				 TWO_bcd 			= 4'b0010,
				 THREE_bcd			= 4'b0011,
				 FOUR_bcd 			= 4'b0100,
				 FIVE_bcd 			= 4'b0101,
				 SIX_bcd 			= 4'b0110,
				 SEVEN_bcd 			= 4'b0111,
				 EIGHT_bcd 			= 4'b1000,
				 NINE_bcd 			= 4'b1001;
				
	//Default design is used for common anode
	parameter ZERO_display 			= 7'b1000000,
				 ONE_display  		= 7'b1111001,
				 TWO_display  		= 7'b0100100,
				 THREE_display 		= 7'b0110000,
				 FOUR_display  		= 7'b0011001,
				 FIVE_display		= 7'b0010010,
				 SIX_display 		= 7'b0000010,
				 SEVEN_display 		= 7'b1111000,
				 EIGHT_display  	= 7'b0000000,
				 NINE_display 		= 7'b0010000,
				 UNKNOWN_display 	= 7'b0111111,
				 off_display		= 7'b1111111;
				 
				 
		always@(posedge clk or negedge reset) begin
				if (reset == 1'b0) LED_segment <= ZERO_display;
				else begin
					case(data_in)
							ZERO_bcd 	: LED_segment <= ZERO_display;
							ONE_bcd  	: LED_segment <= ONE_display;
							TWO_bcd		: LED_segment <= TWO_display;
							THREE_bcd	: LED_segment <= THREE_display;
							FOUR_bcd	: LED_segment <= FOUR_display;
							FIVE_bcd	: LED_segment <= FIVE_display;
							SIX_bcd		: LED_segment <= SIX_display;
							SEVEN_bcd 	: LED_segment <= SEVEN_display;
							EIGHT_bcd 	: LED_segment <= EIGHT_display;
							NINE_bcd 	: LED_segment <= NINE_display;
							default 	: LED_segment <= UNKNOWN_display;
					endcase
				end
			end
				 
endmodule 