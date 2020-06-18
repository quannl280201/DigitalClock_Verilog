module top_inst(
		input [17:0]SW,
		input [3:0]KEY,
		input CLOCK_50,
		output [17:0]LEDR,
		output [6:0]HEX0,
		output [6:0]HEX1,
		output [6:0]HEX2,
		output [6:0]HEX3,
		output [6:0]HEX4,
		output [6:0]HEX5
	);
	
	/*top my(.CLOCK_50(CLOCK_50), .reset(KEY[3]), .change_mode(KEY[2]), 
		.up(KEY[1]), .down(KEY[0]), 
		.LED_display({HEX5, HEX4,HEX3,HEX2,HEX1,HEX0}), .normal_state(LEDR[0]), .TC(LEDR[1])
	);*/
	
	wire [3:0]BCD_out;
	wire CLK;
	
	clk_generate clk_ges(
		.CLOCK_50(CLOCK_50),
		.CLK(CLK)
	);
	mod_N_counter  uuu(.clk(CLK),.set_ena(SW[0]), .up(KEY[1]), .down(KEY[2]), 
		.BCD_out_next(BCD_out), .TC(LEDR[0])
	);
	
	BCD_to_7segmentLED uut(
		.data_in(BCD_out),
		.clk(CLOCK_50), .reset(KEY[3]),
		.LED_segment(HEX0)
	);
	
	assign LEDR[5] = CLK;
	
endmodule
