//************************DIVISOR DE FREQUÊNCIA****************************************
module FreqDiv(input clk_50MHz, output reg clk_2Hz);

  reg [25:0] cont = 0;

  always @(posedge clk_50MHz) 
    begin
    cont = cont + 1;
      
      if (cont == 250000) //250000
    begin
      cont = 0;
      clk_2Hz = ~clk_2Hz;
    end 

      
  end

endmodule
