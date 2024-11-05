// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1; 
    input logic CLOCK_50;

    assign HEX2 = '1;
    assign HEX3 = '1;
    assign HEX4 = '1;
    assign HEX5 = '1;
	 
	 logic U;
	 int position;
	 int shift;
	 int shift2;
	 int counter;
	 logic rst;	 
	 assign rst = SW[9];
	 wire addPoint;
	 logic gameover;
	 logic lp0, lp1;
	 
	 logic [31:0] div_clk;
	 clock_divider cdiv (.clk(CLOCK_50),
								.rst,
								.divided_clocks(div_clk));

	 logic clkSelect;
		
	 assign clkSelect = div_clk[14]; 
	 	
	 
	 logic [15:0][15:0]RedPixels; 
    logic [15:0][15:0]GrnPixels; 
	 
	
	 LEDDriver Driver (.clk(clkSelect), .rst, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	
	 Press UP(.clk(clkSelect), .reset(rst), .inputButton(KEY[0]), .out(U));
	 collision col(.clk(clkSelect), .gA(GrnPixels), .rA(RedPixels), .gameover, .reset(rst), .addPoint);
	 bird flap(.clk(clkSelect), .rst, .button(U), .gameover, .position);
	 pipeShift move(.clk(clkSelect), .rst, .gameover, .shift, .counter);
	 single_hex d0(.clk(clkSelect), .reset(rst), .dv(7'b1000000), .increment(addPoint), .display(HEX0), .cycle(lp0));
	 single_hex d1(.clk(clkSelect), .reset(rst), .dv(7'b1000000), .increment(lp0), .display(HEX1), .cycle(lp1));

	
	always_comb begin
		RedPixels = '0;
		RedPixels[position][13] = 1'b1;
		RedPixels[position + 1][13] = 1'b1;
		RedPixels[position][12] = 1'b1;
		RedPixels[position + 1][12] = 1'b1;
	end
	
	always_comb begin
		GrnPixels = '0;
		for(int i = 0; i < 16; i++) begin
			if(counter % 17 == 0) begin
				GrnPixels[15][shift] = 1'b1;
				GrnPixels[14][shift] = 1'b1;
				GrnPixels[13][shift] = 1'b1;
				GrnPixels[12][shift] = 1'b1;
				GrnPixels[11][shift] = 1'b1;
				GrnPixels[10][shift] = 1'b1;
				GrnPixels[9][shift] = 1'b1;
				GrnPixels[0][shift] = 1'b1;
			end 
			else if(counter % 13 == 0) begin
				GrnPixels[15][shift] = 1'b1;
				GrnPixels[14][shift] = 1'b1;
				GrnPixels[13][shift] = 1'b1;
				GrnPixels[12][shift] = 1'b1;
				GrnPixels[11][shift] = 1'b1;
				GrnPixels[10][shift] = 1'b1;
				GrnPixels[1][shift] = 1'b1;
				GrnPixels[0][shift] = 1'b1;
			end
			else if(counter % 11 == 0) begin
				GrnPixels[13][shift] = 1'b1;
				GrnPixels[14][shift] = 1'b1;
				GrnPixels[15][shift] = 1'b1;
				GrnPixels[0][shift] = 1'b1;
				GrnPixels[1][shift] = 1'b1;
				GrnPixels[2][shift] = 1'b1;
				GrnPixels[12][shift] = 1'b1;
				GrnPixels[11][shift] = 1'b1;
				
			end
			else if(counter % 7 == 0) begin
				GrnPixels[0][shift] = 1'b1;
				GrnPixels[1][shift] = 1'b1;
				GrnPixels[2][shift] = 1'b1;
				GrnPixels[3][shift] = 1'b1;
				GrnPixels[4][shift] = 1'b1;
				GrnPixels[5][shift] = 1'b1;
				GrnPixels[6][shift] = 1'b1;
				GrnPixels[7][shift] = 1'b1;
			end
			else if(counter % 5 == 0) begin
				GrnPixels[15][shift] = 1'b1;
				GrnPixels[0][shift] = 1'b1;
				GrnPixels[1][shift] = 1'b1;
				GrnPixels[2][shift] = 1'b1;
				GrnPixels[3][shift] = 1'b1;
				GrnPixels[4][shift] = 1'b1;
				GrnPixels[5][shift] = 1'b1;
				GrnPixels[6][shift] = 1'b1;
				
			end
			else if(counter % 3 == 0) begin
				GrnPixels[14][shift] = 1'b1;
				GrnPixels[15][shift] = 1'b1;
				GrnPixels[0][shift] = 1'b1;
				GrnPixels[1][shift] = 1'b1;
				GrnPixels[2][shift] = 1'b1;
				GrnPixels[3][shift] = 1'b1;
				GrnPixels[4][shift] = 1'b1;
				GrnPixels[5][shift] = 1'b1;
				
			end
			else if(counter % 2 == 0) begin
				GrnPixels[13][shift] = 1'b1;
				GrnPixels[14][shift] = 1'b1;
				GrnPixels[15][shift] = 1'b1;
				GrnPixels[0][shift] = 1'b1;
				GrnPixels[1][shift] = 1'b1;
				GrnPixels[2][shift] = 1'b1;
				GrnPixels[3][shift] = 1'b1;
				GrnPixels[4][shift] = 1'b1;

			end
			else begin
				GrnPixels[12][shift] = 1'b1;
				GrnPixels[13][shift] = 1'b1;
				GrnPixels[14][shift] = 1'b1;
				GrnPixels[15][shift] = 1'b1;
				GrnPixels[0][shift] = 1'b1;
				GrnPixels[1][shift] = 1'b1;
				GrnPixels[2][shift] = 1'b1;
				GrnPixels[3][shift] = 1'b1;
			end
			if(shift > 7) begin
					GrnPixels[15][shift-8] = 1'b1;
					GrnPixels[14][shift-8] = 1'b1;
					GrnPixels[13][shift-8] = 1'b1;
					GrnPixels[12][shift-8] = 1'b1;
					GrnPixels[11][shift-8] = 1'b1;
					GrnPixels[10][shift-8] = 1'b1;
					GrnPixels[9][shift-8] = 1'b1;
					GrnPixels[0][shift-8] = 1'b1;
				end
			if(shift < 8 & counter > 1) begin
					GrnPixels[15][shift+8] = 1'b1;
					GrnPixels[14][shift+8] = 1'b1;
					GrnPixels[13][shift+8] = 1'b1;
					GrnPixels[12][shift+8] = 1'b1;
					GrnPixels[11][shift+8] = 1'b1;
					GrnPixels[10][shift+8] = 1'b1;
					GrnPixels[9][shift+8] = 1'b1;
					GrnPixels[0][shift+8] = 1'b1;
			end
		end
	end
	 
endmodule 

module DE1_SoC_testbench ();
	logic CLOCK_50;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic [9:0] LEDR;
	logic [6:0] HEX0;
	logic [6:0] HEX1;
	logic [35:0] GPIO_1;

	DE1_SoC dut (CLOCK_50, GPIO_1, HEX0, HEX1, LEDR, KEY, SW);

	// Set up the clock
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	// Set up the inputs to the design (each line is a clock cycle)
	initial begin
		SW[9] <= 1; SW[8:0] <= 9'b100000000; @(posedge CLOCK_50); 
		SW[9] <= 0;				         @(posedge CLOCK_50); 
												@(posedge CLOCK_50);
		KEY[0] <= 1;					   @(posedge CLOCK_50);
		KEY[0]<= 0;				 			@(posedge CLOCK_50); 
		KEY[0] <= 1;						@(posedge CLOCK_50);								
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		SW[9] <= 1;							@(posedge CLOCK_50);
		SW[9] <= 0;							@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);  
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		KEY[0] <= 1;						@(posedge CLOCK_50);
		KEY[0] <= 0;						@(posedge CLOCK_50);
		SW[9] <= 1;						@(posedge CLOCK_50);
	 $stop; 
	end
endmodule
