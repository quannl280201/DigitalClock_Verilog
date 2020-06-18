module top(CLOCK_50, reset, change_mode, up, down, LED_display, normal_state, TC);
	input CLOCK_50;
	input reset;
	input change_mode;
	input up;
	input down;
	output [41:0]LED_display;
	output normal_state; // IDLE_state = 0, other state = 1;
	output TC;
	
	wire CLK;
	wire TC_to_hour;
	wire TC_to_minute;
	wire set_second;
	wire set_minute;
	wire set_hour;
	
	wire [7:0]second_display;
	wire [7:0]minute_display;
	wire [7:0]hour_display;
	
	clk_generate clk_gene(.CLOCK_50(CLOCK_50), .CLK(CLK));
	
	state_machine state(.CLK(CLK), .mode(change_mode), .reset(reset), .normal(normal_state),
					.second_setup(set_second), .minute_setup(set_minute), .hour_setup(set_hour));
	second_control SE_ctrl(.clk(CLK), .set_ena(set_second), .up(up), .down(down), 
					.BCD_out(second_display), .TC_to_minute(TC_to_minute));
	minute_control MI_ctrl(.clk(TC_to_minute), .set_ena(set_minute), .up(up), .down(down), 
					.BCD_out(minute_display), .TC_to_hour(TC_to_hour));
	hour_control   HO_ctrl(.clk(TC_to_hour), .set_ena(set_hour), .up(up), .down(down), 
					.BCD_out(hour_display), .TC(TC));
					
	BCD_to_7segmentLED last_second(.data_in(second_display[3:0]), .clk(CLK), .reset(reset), .LED_segment(LED_display[6:0]));
	BCD_to_7segmentLED first_second(.data_in(second_display[7:4]), .clk(CLK), .reset(reset), .LED_segment(LED_display[13:7]));
	BCD_to_7segmentLED last_minute(.data_in(minute_display[3:0]), .clk(CLK), .reset(reset), .LED_segment(LED_display[20:14]));
	BCD_to_7segmentLED first_minute(.data_in(minute_display[7:4]), .clk(CLK), .reset(reset), .LED_segment(LED_display[27:21]));
	BCD_to_7segmentLED last_hour(.data_in(hour_display[3:0]), .clk(CLK), .reset(reset), .LED_segment(LED_display[34:28]));
	BCD_to_7segmentLED first_hour(.data_in(hour_display[7:4]), .clk(CLK), .reset(reset), .LED_segment(LED_display[41:35]));

endmodule
