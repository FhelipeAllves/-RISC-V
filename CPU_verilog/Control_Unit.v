module Control_Unit( input [6:0] op, Funct7,
                   input [2:0] Funct3,
	output reg RegWrite, ULASrc, MemWrite, Branch, jump, jr,
	output reg [1:0] ImmSrc, ResultSrc,
	output reg [3:0] ULAControl);
	
	always@(*) begin
    
	    	casex( {op,Funct3, Funct7} )
		      17'b01100110000000000: // ADD
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_xx_0_0000_0_00_0_0_0;
				
				17'b0110011_000_0000001: // MUL
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_xx_0_0110_0_00_0_0_0; //NEW
				
				17'b0110011_100_0000001: // DIV
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_xx_0_1000_0_00_0_0_0; //NEW

		      17'b01100110000100000: // SUB
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_xx_0_0001_0_00_0_0_0;

		      17'b01100111110000000: // AND
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_xx_0_0010_0_00_0_0_0;

		      17'b01100111100000000: // OR
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_xx_0_0011_0_00_0_0_0;
				
				17'b0110011_100_0000000: // XOR
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_xx_0_0100_0_00_0_0_0; //NEW

		      17'b0110011_010_0000000: // SLT
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_xx_0_0101_0_00_0_0_0;
				
				17'b0010011_010_0000000: // SLTI
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_00_1_0101_0_00_0_0_0; //NEW
				
				17'b0010011_100_0000000: // XORI
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_00_1_0100_0_00_0_0_0; //NEW
				
				17'b0010011_110_xxxxxxx: // ORI
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_00_1_0011_0_00_0_0_0; //NEW
				
				17'b0010011_111_xxxxxxx: // ANDI
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_00_1_0010_0_00_0_0_0; //NEW

		      17'b0010011000xxxxxxx: // ADDI
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_00_1_0000_0_00_0_0_0;
				
				17'b0000011_000_xxxxxxx: // LB
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_00_1_0000_0_01_0_0_0;
				
				17'b0100011_000_xxxxxxx: // SB
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b0_01_1_0000_1_xx_0_0_0;
				
				17'b1100011_000_xxxxxxx: // BEQ
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b0_10_0_0001_0_xx_1_0_0;
				
				17'b1100011_001_xxxxxxx: // BNE
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b0_10_0_0111_0_xx_1_0_0; //NEW
				
				17'b1101111_xxx_xxxxxxx: // JAL
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_11_x_xxxx_0_10_x_1_0; //NEW
				
				17'b1100111_000_xxxxxxx: // JALR
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b1_00_1_0000_0_10_x_1_1; //NEW

		      default: 	
		      {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch, jump, jr} = 'b0_00_0_0000_0_00_0_0_0;
		      
	    	endcase	
    
    	end

endmodule
