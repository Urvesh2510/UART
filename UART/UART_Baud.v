module UART_Baud(clkrx,clktx,clk,reset,sel);
 input [1:0]sel;
 input clk,reset;
 output reg clkrx=0;
 output reg clktx=0;
 reg[13:0]mr=14'd0;
 reg[13:0]mt=14'd0;
 reg[13:0]countrx=0;
 reg[13:0]counttx=0;

 always@(sel)
 begin
 case(sel)
 2'b00:begin
        mr=14'd82;
        mt=14'd2624;
       end   //38400Hz
 2'b01:begin
        mr=14'd325;
        mt=14'd10400;
       end  //9600Hz
 2'b10:begin
        mr=14'd162;
        mt=14'd5184;
       end  //19200Hz
 2'b11:begin
        mr=14'd64;
        mt=14'd2048;
       end  //48828Hz
 default:begin 
          mr=12'd325;
          mt=12'd10400;
         end
 endcase
 end

 always@(posedge clk)
 begin
  if (!reset)
  begin
  clkrx<=0;
  end
  else if(countrx==mr)
  begin
  countrx=0;
  clkrx<=~clkrx;
  end
  else
  begin
  countrx=countrx+1;
  clkrx<=clkrx;
  end
 end
 
 always@(posedge clk)
 begin
  if (!reset)
  begin
  clktx<=0;
  end
  else if(counttx==mt)
  begin
  counttx=0;
  clktx<=~clktx;
  end
  else
  begin
  counttx=counttx+1;
  clktx<=clktx;
  end
 end
 endmodule