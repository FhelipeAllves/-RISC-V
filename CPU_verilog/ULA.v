module ULA(input [7:0] SrcA, SrcB,
	   input [3:0]	ULAControl,
	   output reg [7:0] ULAResult,
	   output reg  z);

	always@(*) begin
	   case (ULAControl)
	   4'b0000 : ULAResult =  SrcA + SrcB;
	   4'b0001 : ULAResult =  SrcA + (~SrcB + 1);
	   4'b0010 : ULAResult =  SrcA & SrcB;
	   4'b0011 : ULAResult =  SrcA | SrcB;
	   4'b0101 : ULAResult =  (SrcA < SrcB)? 1 : 0;
		4'b0100 : ULAResult =  (SrcA ^ SrcB); //XOR
		4'b0111 : ULAResult =  SrcA + (~SrcB + 1); //BNE
		4'b0110 : ULAResult =  SrcA * SrcB; //MUL
		4'b1000 : ULAResult =  SrcA / SrcB; //DIV
	   default: ULAResult  = 8'b0;	   
	   endcase 			
		
	   z = (ULAResult == 8'b0)? 1 : 0;
		if (ULAControl == 3'b111)
			z = !z;
	end
	
endmodule
