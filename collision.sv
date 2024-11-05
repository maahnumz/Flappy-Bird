module collision (clk, reset, gA, rA, gameover, addPoint);
	input logic clk, reset;
	input logic [15:0][15:0] gA, rA;
	output logic gameover, addPoint;
	
	reg psc, nsc;
	reg [15:0] psp, nsp;

	always @(*) begin
		nsc =  (((gA[0] & rA[0])  != 16'b0000000000000000) | ((gA[1] & rA[1]) != 16'b0000000000000000)  | ((gA[2] & rA[2]) != 16'b0000000000000000)
			|((gA[3] & rA[3])  != 16'b0000000000000000) | ((gA[4] & rA[4]) != 16'b0000000000000000)  | ((gA[5] & rA[5]) != 16'b0000000000000000) 
			|((gA[6] & rA[6])  != 16'b0000000000000000) | ((gA[7] & rA[7]) != 16'b0000000000000000)  | ((gA[8] & rA[8]) != 16'b0000000000000000)
			|((gA[9] & rA[9])  != 16'b0000000000000000) | ((gA[10] & rA[10]) != 16'b0000000000000000)| ((gA[11] & rA[11]) != 16'b0000000000000000)
			|((gA[12] & rA[12]) != 16'b0000000000000000)| ((gA[13] & rA[13]) != 16'b0000000000000000)| ((gA[14] & rA[14]) != 16'b0000000000000000)
			|((gA[15] & rA[15]) != 16'b0000000000000000) | rA[15] != 16'b0000000000000000);
			nsp = gA[0][14]; 
	end
	assign gameover = psc;
	assign addPoint = ~(psp == 1'b0) & (gA[0][14] != 1'b1);
			
	always @(posedge clk)
		if(reset) begin
			psc <= 1'b0;
			psp <= 1'b0;
		end
		else begin
			psc <= nsc;
			psp <= nsp;
		end
endmodule


module collision_testbench ();
	logic clk, reset;
	logic [15:0][15:0] gA, rA;
	logic resetgame, addPoint;
	
	collision dut (clk, reset, gA, rA, resetgame, addPoint);
	
	
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		rA <= {     {16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000}};
		gA <= {     {16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000},
						{16'b0000000000000000}};
		reset <= 1; @(posedge clk);
						@(posedge clk);
		reset <= 0; @(posedge clk);
		rA[0] <= 16'b0100000001010101; gA[0] <= 16'b0100000000000000;   @(posedge clk);  
		rA[0] <= 16'b0100000010110101; gA[0] <= 16'b0010000000000000;   @(posedge clk);
		rA[1] <= 16'b1000000011111111; gA[1] <= 16'b1000000000000000;   @(posedge clk);  
		rA[1] <= 16'b0100000010100011; gA[1] <= 16'b0000010000000000;   @(posedge clk);
		rA[2] <= 16'b0010000011010101; gA[2] <= 16'b0010000000000000;   @(posedge clk);  
		rA[2] <= 16'b0100000010101111; gA[2] <= 16'b1000000000000000;   @(posedge clk);
		rA[3] <= 16'b0001000010101111; gA[3] <= 16'b0001000000000000;   @(posedge clk); 
		rA[3] <= 16'b0100000011010101; gA[3] <= 16'b1000000000000000;   @(posedge clk);
		rA[4] <= 16'b0000100011010101; gA[4] <= 16'b0000100000000000;   @(posedge clk);  
		rA[4] <= 16'b0100000010101010; gA[4] <= 16'b1000000000000000;   @(posedge clk);
		rA[5] <= 16'b0000010010101011; gA[5] <= 16'b0000010000000000;   @(posedge clk); 
		rA[5] <= 16'b0100000010110101; gA[5] <= 16'b1000000000000000;   @(posedge clk);
		rA[6] <= 16'b0000001010110101; gA[6] <= 16'b0000001000000000;   @(posedge clk); 
		rA[6] <= 16'b0100000000000000; gA[6] <= 16'b1000000000000000;   @(posedge clk);
		rA[7] <= 16'b0000000100000000; gA[7] <= 16'b0000000100000000;   @(posedge clk); 
		rA[7] <= 16'b0100000000000000; gA[2] <= 16'b1000000000000000;   @(posedge clk);
		repeat (16) begin
				; @(posedge clk);
				rA[5][12] <= 1'b1; @(posedge clk);
				rA[5][13] <= 1'b1; @(posedge clk);
				rA[6][12] <= 1'b1; @(posedge clk);
				rA[6][13] <= 1'b1; @(posedge clk);
				gA[0] <= 16'b1010110101100010; @(posedge clk); 
			end
	$stop; // End the simulation
	end
	 
endmodule 