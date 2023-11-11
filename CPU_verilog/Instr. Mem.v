//INSTRUCOESDE MEMORIA UTILIZANDO .TXT
							
module ROM(input [7:0] A,
	   output reg [31:0] RD);
		
	reg [31:0] inst_mem[0:256];
	initial
	begin
	$readmemh("grav.txt", inst_mem);
	end
	
	always @(*) 
		RD <= inst_mem[(A/4)]; 
		 
endmodule
