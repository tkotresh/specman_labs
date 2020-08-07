// Code your design here
module tb(); 
  bit clk; 
  
  initial
    begin 
      forever
  		#30 clk = ~clk;     
    end
   
endmodule 