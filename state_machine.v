module state_machine(CLK, mode, reset, normal, second_setup, minute_setup, hour_setup);
	
	parameter IDLE_STATE	= 4'b0001;
	parameter SECOND_SETUP	= 4'b0010;
	parameter MINUTE_SETUP	= 4'b0100;
	parameter HOUR_SETUP	= 4'b1000;

	input CLK;
	input mode;
	input reset;
	output normal;
	output second_setup;
	output minute_setup;
	output hour_setup;

	reg [3:0]current_state = IDLE_STATE;
	reg [3:0]next_state;
	reg [3:0]control_signal;
	
	always@(posedge CLK) begin:change_to_next_state
		if (reset == 1'b0) current_state <= IDLE_STATE;
		else current_state <= next_state;
	end
	
	always@(posedge CLK or negedge mode) begin:look_for_next_state
		case (current_state)
			IDLE_STATE: 	if (mode == 1'b0) next_state <= SECOND_SETUP;
							else next_state <= current_state;
			SECOND_SETUP:	if (mode == 1'b0) next_state <= MINUTE_SETUP;
							else next_state <= current_state;
			MINUTE_SETUP:	if (mode == 1'b0) next_state <= HOUR_SETUP;
							else next_state <= current_state;
			HOUR_SETUP:		if (mode == 1'b0) next_state <= IDLE_STATE;
							else  next_state <= current_state;
			default:	next_state <= IDLE_STATE;
		endcase
	end
	
	always@(posedge CLK) begin:control_mode
		case (current_state)
			IDLE_STATE:		control_signal <= IDLE_STATE;
			SECOND_SETUP:	control_signal <= SECOND_SETUP;
			MINUTE_SETUP:	control_signal <= MINUTE_SETUP;
			HOUR_SETUP:		control_signal <= HOUR_SETUP;
			default:		control_signal <= IDLE_STATE;
		endcase
	end
	
	assign normal = control_signal[0];
	assign second_setup = control_signal[1];
	assign minute_setup = control_signal[2];
	assign hour_setup = control_signal[3];
	
endmodule
