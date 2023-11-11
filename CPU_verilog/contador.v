//************************CONTADOR****************************************

module contador (input clk, reset,output reg [3:0] cont);
  
  always @(posedge clk or negedge reset)
  begin
    
    if (reset == 0)
      cont <= 4'b0000;
    else if (cont == 4'b1001)
      cont <= 4'b0000;
    else 
      cont <= cont + 4'b0001;
    
  end
  
  
endmodule
