`timescale 1ps/1ps
module clock_generate_tb;
	reg CLOCK_50 = 0;
	wire CLK;
	
	clk_generate uut(
		.CLOCK_50(CLOCK_50),
		.CLK(CLK)
	);
	
	always #10 CLOCK_50 = !CLOCK_50;

endmodule
