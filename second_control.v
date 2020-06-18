module second_control(clk, set_ena, up, down, BCD_out, TC_to_minute);
	input clk;
	input set_ena;
	input up;
	input down;
	output [7:0]BCD_out;
	output TC_to_minute;
	
	wire TC_out;
	mod_N_counter_2 #(.MODE_N(10)) last_digit		
		(.clk(clk), .set_ena(set_ena), .up(up), .down(down), .BCD_out(BCD_out[3:0]), .TC(TC_out));
	mod_N_counter_2 #(.MODE_N(6)) first_digit
		(.clk(TC_out), .set_ena(set_ena), .up(up), .down(down), .BCD_out(BCD_out[7:4]), .TC(TC_to_minute));
	
endmodule 