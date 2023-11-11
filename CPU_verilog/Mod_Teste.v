`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);
//---------- modifique a partir daqui --------

wire w_RegWrite, w_ULASrc, w_MemWrite, w_Branch, w_Zero, w_PCSrc, w_clk, w_jump, w_PCSrc2, w_jr;
wire [1:0] w_ImmSrc, w_ResultSrc;
wire [3:0] w_ULAControl;
wire [7:0] w_PCp4, w_PC, w_PCn, w_ImmPC, w_RegData, w_PCn_02;
wire [7:0] w_rd1SrcA, w_rd2, w_SrcB, w_ULAResult, w_RData, w_Wd3;
wire [11:0] w_Imm;
wire [31:0] w_inst;


assign w_d0x4 = w_PC;
assign w_d1x4 = SW[7:0];


Dec_7Segmentos teste_decod7(.in(w_inst[31:28]), .out(HEX7[0:6]));
Dec_7Segmentos teste_decod6(.in(w_inst[27:24]), .out(HEX6[0:6]));
Dec_7Segmentos teste_decod5(.in(w_inst[23:20]), .out(HEX5[0:6]));
Dec_7Segmentos teste_decod4(.in(w_inst[19:16]), .out(HEX4[0:6]));
Dec_7Segmentos teste_decod3(.in(w_inst[15:12]), .out(HEX3[0:6]));
Dec_7Segmentos teste_decod2(.in(w_inst[11:8]), .out(HEX2[0:6]));
Dec_7Segmentos teste_decod1(.in(w_inst[7:4]), .out(HEX1[0:6]));
Dec_7Segmentos teste_decod0(.in(w_inst[3:0]), .out(HEX0[0:6]));

//FreqDiv teste_freqDiv(.clk_50MHz(CLOCK_50), .clk_2Hz(w_clk));
assign w_clk = KEY[1];

Control_Unit Control_Unit_test(.op(w_inst[6:0]), .Funct7(w_inst[31:25]),
									.Funct3(w_inst[14:12]),
									.RegWrite(w_RegWrite), .ImmSrc(w_ImmSrc), .ULASrc(w_ULASrc),
									.MemWrite(w_MemWrite), .ResultSrc(w_ResultSrc),
									.ULAControl(w_ULAControl), .Branch(w_Branch), .jump(w_jump), .jr(w_jr)
);

//AND and_tb(.in0(w_Branch), .in1(w_Zero), .out(w_PCSrc));

//and e or
assign w_PCSrc = (w_Branch&&w_Zero)||w_jump;
 
Program_Counter pc_test(.clk(w_clk), .rst(KEY[2]), 
			.Pcin(w_PCn_02),
			.PC(w_PC));
			
ULA ULA_test2(.SrcA(w_PC), .SrcB(3'b100), //SOMADO +4
	   .ULAControl(3'b000),
	   .ULAResult(w_PCp4),
);

mux2_1 MuxPCSrc(.in0(w_PCp4), .in1(w_ImmPC),
               .sel(w_PCSrc), 
               .out(w_PCn)
);	

mux2_1 MuxPCSrc_02(.in0(w_PCn), .in1(w_ULAResult),
               .sel(w_jr), 
               .out(w_PCn_02)
);
	
			
ROM rom_test(.A(w_PC),
	   .RD(w_inst));	

		
	
bank_register bank_teste(.wd3(w_Wd3),
                     .we3(w_RegWrite),
                     .wa3(w_inst[11:7]), //rd
                     .clk(w_clk),
                     .rst(KEY[2]),
                     .ra1(w_inst[19:15]), //rs1
                     .ra2(w_inst[24:20]), //rs2
                     .rd1(w_rd1SrcA), 
                     .rd2(w_rd2),
							.x0(w_d0x0), .x1(w_d0x1),
							.x2(w_d0x2), .x3(w_d0x3),
							.x4(w_d1x0), .x5(w_d1x1),
							.x6(w_d1x2), .x7(w_d1x3)
						
);	


mux4_1 MuxImmSrc(.in0(w_inst[31:20]), .in1({w_inst[31:25], w_inst[11:7]}), 
						 .in2({w_inst[7], w_inst[30:25], w_inst[11:8], 1'b0}),
						 .in3({w_inst[31], w_inst[19:12], w_inst[20], w_inst[30:21], 1'b0}),
                   .sel(w_ImmSrc), 
                   .out(w_Imm)
);


mux2_1 MuxULA(.in0(w_rd2), .in1(w_Imm),
               .sel(w_ULASrc), 
               .out(w_SrcB)
);

ULA ULA_test3(.SrcA(w_Imm), .SrcB(w_PC), //SOMADOR
	   .ULAControl(3'b000),
	   .ULAResult(w_ImmPC),
);

ULA ULA_test(.SrcA(w_rd1SrcA), .SrcB(w_SrcB),
	   .ULAControl(w_ULAControl),
	   .ULAResult(w_ULAResult), .z(w_Zero)
);

RAM Data_Mem(.WE(w_MemWrite), .rst(KEY[2]), .clk(w_clk),
        .A(w_ULAResult), .WD(w_rd2), 
        .RD(w_RData));
  
mux4_1 MuxResSrc(.in0(w_ULAResult), .in1(w_RegData), .in2(w_PCp4),
               .sel(w_ResultSrc), 
               .out(w_Wd3)
);

Parallel_out Parallel_out_tb(.EN(w_MemWrite), .clk(w_clk), .rst(KEY[2]), 
		     .Address(w_ULAResult), .RegData(w_rd2),
		     .DataOut(LEDG[7:0])
);

Parallel_in Parallel_in_tb( 
		     .Address(w_ULAResult), .MemData(w_RData), .DataIn(SW[7:0]),
		     .RegData(w_RegData)
);

endmodule