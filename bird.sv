module bird (clk, rst, button, gameover, position);
				
			input logic clk, rst, button, gameover;
			output int position;
			
			int gravity;
			
			always_ff @ (posedge clk) begin
				if (rst) begin
					position <= 5;
					gravity <= 0;
				end
				else begin
					if (gameover) begin
						position <= position;
					end
					else if (position == 14 & ~button) begin
						position <= 14;
					end
					else if (position == 0 & button) begin
						position <= 0;
					end
					else if (button) begin
						position <=  position - 1;
					end
					else if (~button) begin
						gravity <= gravity + 1;
						if(gravity % 500 == 0) begin
							position <= position + 1;
						end
					end
				end 
			end
endmodule 

module bird_testbench();
	logic clk, rst, button, gameover;
	int position;
	
	bird dut (.clk, .rst, .button, .position, .gameover);
	
		parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end
		
		initial begin
			rst <= 1;  @(posedge clk);
			rst <= 0; @(posedge clk);
			repeat (16) begin
				button <= 1; @(posedge clk);
				button<= 0; @(posedge clk);
				button<= 0; @(posedge clk);
				button<= 0; @(posedge clk);
				button <= 1; @(posedge clk);
				button<= 0; @(posedge clk);
				button <= 1; @(posedge clk);
			end
			gameover <= 1; @(posedge clk);
			button <= 1; @(posedge clk);
			button<= 0; @(posedge clk);
			button <= 1; @(posedge clk);
			button <= 0;  @(posedge clk);
			rst <= 1;  @(posedge clk);
			rst <= 0; @(posedge clk);
			gameover <= 0; @(posedge clk);
		$stop;
		end
endmodule