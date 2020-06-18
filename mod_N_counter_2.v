module mod_N_counter_2(clk, set_ena, reset, up, down, BCD_out, TC);
	
	parameter MODE_N = 10;
	parameter TOP_VALUE = MODE_N - 1;
	
	input clk;
	input reset;
	input set_ena;
	input up, down;
	output [3:0]BCD_out;
	output reg TC;
	
	reg [3:0]counter = 0;
	
	always@(posedge clk or posedge reset or negedge set_ena or negedge up or negedge down) begin
		if (reset == 1'b1) counter <= 0;	
		else begin
			if (set_ena == 1'b0) begin
				if (counter == TOP_VALUE) counter <= 0;
				else counter <= counter + 1'b1;
			end
			else begin
				if (up == 1'b0) begin
					if (counter == TOP_VALUE) counter <= 0;
					else counter <= counter + 1'b1;
				end
				else if (down == 1'b0) begin
					if (counter == 0) counter <= TOP_VALUE;
					else counter <= counter - 1'b1;
				end
				else counter <= counter + 1'b1;
			end
		end
	end
	
	always@(posedge clk) begin
		//if (set_ena == 1'b1) TC <= 1'b0; 
		//else begin 
			if (counter == TOP_VALUE) TC <= 1'b1;
			else TC <= 1'b0;
		//end
	end
	
	assign BCD_out = counter;
	
endmodule
