module 	Program_Counter(input clk, rst, 
			input [7:0] Pcin,
			output reg [7:0] PC);
	
	always @(posedge clk, negedge rst) begin
		if(!rst)
			PC <= 0;	
		else 
			PC <= Pcin;
	end
	

endmodule
