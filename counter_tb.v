
`timescale 1ns/1ns
module counter_tb;
	reg clk = 0;
	reg set_ena;
	reg up, down;
	wire[3:0]BCD_out;
	wire TC;
	
	mod_N_counter_2 uut(.clk(clk), .set_ena(set_ena), .up(up), .down(down), .BCD_out(BCD_out), .TC(TC));
	
	initial begin
		set_ena = 1'b0;
		up = 1'b1;
		down = 1'b1;
		#10
		#50;
		set_ena = 1'b1;
		down = 1'b0;
		#20;
		down = 1'b1;
		up = 1'b0;
		#20;
		set_ena = 1'b0;
		#20;
		
		
	end
	
	always #5 clk = ~clk;
endmodule

	