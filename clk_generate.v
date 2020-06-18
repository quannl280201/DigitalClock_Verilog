module clk_generate(
		input CLOCK_50,
		output CLK
	);
	
	parameter top_value = 25000000;
	
	reg [27:0]counter = 0;
	reg clk_o = 1'b0;
	always@(posedge CLOCK_50) begin
		if (counter == top_value) begin
			counter <= 0;
			clk_o <= ~clk_o;
			end
		else counter <= counter + 1'b1;
	end
	
	assign CLK = clk_o;
		
endmodule
