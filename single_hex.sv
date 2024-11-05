module single_hex(clk, reset, dv, increment, display, cycle);
	input clk, reset, increment;
	input [6:0] dv;
	output cycle;
	output [6:0] display;
	
	parameter	zero	= 7'b1000000,
					one	= 7'b1111001,
					two	= 7'b0100100,
					three	= 7'b0110000,
					four	= 7'b0011001,
					five	= 7'b0010010,
					six	= 7'b0000010,
					seven	= 7'b1111000,
					eight	= 7'b0000000,
					nine	= 7'b0010000;
	
	reg [6:0] ps, ns;
	
	always @(*)
		if(increment)
			case(ps)
				zero:		ns = one;
				one:		ns = two;
				two:		ns = three;
				three:	ns = four;
				four:		ns = five;
				five:		ns = six;
				six:		ns = seven;
				seven:	ns = eight;
				eight:	ns = nine;
				nine:		ns = zero;
				default:	ns = one;
			endcase
		else
			ns = ps;
	
	assign display[6:0] = ps[6:0];
	assign cycle = (ps[6:0] == nine) & (increment);
	
	always @(posedge clk)
		if(reset)
			ps <= dv;
		else
			ps <= ns;
endmodule

module single_hex_testbench();
	reg clk, reset, increment;
	reg [6:0] dv;
	wire [6:0] display;
	wire cycle;

	single_hex dut(clk, reset, dv, increment, display, cycle);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	initial begin
		
		reset <= 1;	
				dv <= 7'b1111111;	increment <= 1;	@(posedge clk);
				dv <= 7'b0000000;					@(posedge clk);
		reset <= 0;									@(posedge clk);
														@(posedge clk);
										increment <= 0;	@(posedge clk);
										increment <= 1;	@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
										increment <= 0;	@(posedge clk);
										increment <= 1;	@(posedge clk);
														@(posedge clk);
		$stop;
	end
endmodule