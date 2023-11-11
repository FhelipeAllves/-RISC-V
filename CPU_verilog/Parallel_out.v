module Parallel_out (input EN, clk, rst, 
		     input  [7:0] Address, RegData,
		     output reg [7:0] DataOut
);


	always @(posedge clk, negedge rst) begin
		if (rst == 0)
			DataOut = 0;
		else if (EN && (Address == 8'hff))
			DataOut <= RegData;
	end 

endmodule