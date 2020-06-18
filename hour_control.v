module hour_control(clk, set_ena, up, down, BCD_out, TC);
	input clk;
	input set_ena;
	input up;
	input down;
	output [7:0]BCD_out;
	output TC;
	
	wire TC_out;
	mod_N_counter #(.MODE_N(10)) last_digit		
		(.clk(clk), .set_ena(set_ena), .up(up), .down(down), .BCD_out(BCD_out[3:0]), .TC(TC_out));
	mod_N_counter #(.MODE_N(2)) first_digit
		(.clk(TC_out), .set_ena(set_ena), .up(up), .down(down), .BCD_out(BCD_out[7:4]), .TC(TC));
	
endmodule 