module hour_control(clk, set_ena, up, down, BCD_out, TC);
	input clk;
	input set_ena;
	input up;
	input down;
	output [7:0]BCD_out;
	output TC;
	
	wire TC_out;
	reg reset;
	
	always@(posedge clk) begin
		if(BCD_out == 8'b00100010) reset = 1'b1;
		else reset = 1'b0;
	end
			
	mod_N_counter_2 #(.MODE_N(10)) last_digit		
		(.clk(clk), .set_ena(set_ena), .reset(reset),.up(up), .down(down), .BCD_out(BCD_out[3:0]), .TC(TC_out));
	mod_N_counter_2 #(.MODE_N(3)) first_digit
		(.clk(TC_out), .set_ena(set_ena),.reset(reset), .up(up), .down(down), .BCD_out(BCD_out[7:4]), .TC(TC));
	
endmodule 