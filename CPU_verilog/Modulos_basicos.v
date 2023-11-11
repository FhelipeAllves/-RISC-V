module registrador(input [7:0] wd3, input we, clk, rst, output reg [7:0] out);


	always@( posedge clk or negedge rst) begin
	    if (rst == 0)
	    	out = 0;
	    else if(we == 1)
	      out = wd3;
	end

endmodule

module decoder(input [2:0] in, output reg [7:0] out);
  
  always@(*)
    case(in)
      0 : out = 1;
      1 : out = 2;
      2 : out = 4;
      3 : out = 8;
      4 : out = 16;
      5 : out = 32;
      6 : out = 64;
      7 : out = 128;
      default: out = 0;
    endcase
  
endmodule

module mux_8_1(input [7:0] in0, 
                           in1,
                           in2,
                           in3,
                           in4,
                           in5,
                           in6,
                           in7,
               input [2:0] sel, 
               output reg [7:0] out
);
  
  always@(*)  
    case(sel)
      0 : out = in0;
      1 : out = in1;
      2 : out = in2;
      3 : out = in3;
      4 : out = in4;
      5 : out = in5;
      6 : out = in6;
      7 : out = in7;
      default: out = 0;
    endcase
  
endmodule


module mux2_1(input [7:0] in0, in1,
               input sel, 
               output reg [7:0] out
);
  
  always@(*)  
    case(sel)
      0 : out = in0;
      1 : out = in1;
      default: out = 0;
    endcase
  
endmodule

module AND(input in0, in1, output out);

		assign out = in0 && in1;
		
endmodule

module mux4_1(input [7:0] in0, in1, in2, in3,
       input [1:0] sel, 
       output reg [7:0] out
);

 always@(*)  
    case(sel)
      0 : out <= in0;
      1 : out <= in1;
		2 : out <= in2;
		3 : out <= in3;
      default: out = 0;
    endcase
	
endmodule
