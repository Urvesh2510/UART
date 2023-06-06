 module UART_Baud(clockout,clk,reset,sel);
 input [1:0]sel;
 input clk,reset;
 output reg clockout=0;
 reg[11:0]modulus=12'd0;
 reg[11:0]count=0;

 always@(sel)
 begin
 case(sel)
 2'b00:modulus=12'd82;   //38400Hz
 2'b01:modulus=12'd325;  //9600Hz
 2'b10:modulus=12'd162;  //19200Hz
 2'b11:modulus=12'd64;   //48828Hz
 default:modulus=12'd325;
 endcase
 end

 always@(posedge clk)
 begin
  if (!reset)
  begin
  clockout<=0;
  end
  else if(count==modulus)
  begin
  count=0;
  clockout<=~clockout;
  end
  else
  begin
  count=count+1;
  clockout<=clockout;
  end
 end
 endmodule