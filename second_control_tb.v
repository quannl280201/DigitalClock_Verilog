`timescale 1ns/1ns
module second_control_tb;
	reg clk = 0;
	reg set_ena;
	reg up;
	reg down;
	wire [7:0]BCD_out;
	wire TC_to_minute;
	
	second_control uut(.clk(clk), .set_ena(set_ena), .reset(1'b0), .up(up), .down(down), .BCD_out(BCD_out), .TC_to_minute(TC_to_minute));
	
	initial begin
		set_ena = 1'b0;
		up = 1'b1;
		down = 1'b1;
		#10;
		//set_ena = 1'b0;
		#310;
		set_ena = 1'b1;
		down = 1'b0;
		#20;
		down = 1'b1;
		up = 1'b0;
		#20;
		set_ena = 1'b0;
		#40;
	end
	
	always #5 clk = ~clk;
	
endmodule
