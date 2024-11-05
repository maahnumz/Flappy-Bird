module pipeShift (clk, rst, gameover, shift, counter);	
			
			input logic clk, rst, gameover;
			output int shift;
			output int counter;
			
			int count;
			
			always_ff @ (posedge clk) begin
				if (rst) begin
					shift <= 0;
					count <= 0;
					counter <= 0;
				end
				else begin
					if (gameover) begin
						shift <= shift;
					end
					else if (shift == 16) begin
						shift <= 0;
						counter <= counter + 1;
					end
					else begin
						count <= count + 1;
						if(count % 200 == 0) begin
							shift <= shift + 1;
						end
					end
				end 
			end
endmodule 

module pipeShift_testbench();
	logic clk, rst, gameover;
	int shift, counter;
	
	pipeShift dut (.clk, .rst, .gameover);
	
		parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end
		
		initial begin
			rst <= 1;  @(posedge clk);
			rst <= 0; @(posedge clk);
			repeat (16) @(posedge clk);
			gameover <= 1; @(posedge clk);
			rst <= 1;  @(posedge clk);
			rst <= 0; @(posedge clk);
			gameover <= 0; @(posedge clk);
			repeat (16) @(posedge clk);
		$stop;
		end
endmodule