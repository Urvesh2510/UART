 module UART_Rx(Done,
               Busy,
               Error,
               Received,
               clk,
               rst,
               rx_en,
               rx_data
               );
              
 input rx_en,rst,clk,rx_data;
 output reg Done,Busy,Error;
 output reg[7:0]Received;

 reg[9:0]shift=0;
 reg parity;
 reg[3:0]count=0;
 reg[2:0]ps=1;
 
parameter IDLE=0,START=1,CHECK=2,DATA=3;


 always@(posedge clk)
  begin
   if(!rst) begin
   shift<=0;
  end
  else if(rx_en)begin
  case(ps)
   IDLE: begin
          Done<=0;
          Busy<=0;
          Error<=0;
          shift<=0;
          ps<=START;
         end
   START: begin
           Done<=0;
           Error<=0;
           Busy<=1;
           count<=0;
           if(rx_data==0)
           begin
           ps<=DATA;
           end
          end
   DATA: begin    
          shift[count]<=rx_data;
          if(count>9)begin
           if(shift[0]==1)begin    /*CHECK*/
            parity<=^(shift[9:2]);
            case({shift[1],parity})
             0,3: begin
                  Error<=1;
                  Received<=shift[9:2];
                  Done<=1;
                  Busy<=0;
                  ps<=START;
                  end
             1,2: begin
                  Error<=0;  
                  Received<=shift[9:2];
                  Done<=1;
                  Busy<=0;
                  ps<=START;  
                  end
             endcase
           end
           else 
           begin  /*END*/
           Received<=shift[9:2];
           Done<=1;
           Busy<=0; 
           Error<=0; 
           ps<=START;
           end
          end
          else
          begin 
          count<=count+1;
          ps<=DATA;
          end 
          end
  default:begin
          ps<=IDLE;
         end
  endcase
  end
  end
 endmodule      
           
         