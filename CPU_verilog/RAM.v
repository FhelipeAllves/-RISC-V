module RAM(input WE, rst, clk,
        input [7:0] A, WD, 
        output reg [7:0] RD);
  
  integer i;
  reg [7:0] mem [255:0];
  
  always @(posedge clk, negedge rst) begin
    if(!rst)
      for (i = 0; i < 256; i = i + 1)
        mem[i] <= 0;
    
    else if(WE == 1)
      mem[A] <= WD;	
  end
  
  always @(*) 
	RD = mem[A];
  
endmodule
