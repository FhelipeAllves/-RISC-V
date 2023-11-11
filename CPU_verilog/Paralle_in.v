module Parallel_in ( 
		     input [7:0] Address, MemData, DataIn,
		     output reg [7:0] RegData
);
	
	reg sel;
	always @(*) begin
		if (Address == 8'hff)
			RegData <= DataIn;
		else
			RegData <= MemData;	
	end

endmodule