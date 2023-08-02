 module UART_Tx (Done,
                Busy,
                clk,      
                rst,    
                tx_en,  
                data,   
                tra_data     
                  );
  input clk,rst,tx_en;   
  input [9:0] data;   
  output reg tra_data;
  output reg Done,Busy;
  reg [3:0] count;
  reg [10:0] shift;
  reg [3:0] bit_counter;
  reg [3:0]state=0;
  
  parameter START=0,TRANSMISSION=2,IDLE=1,PASS=3,PASS1=4;

  always @(posedge clk) begin
    if (!rst) begin
     shift<= 0;
     bit_counter <= 0;
     tra_data <= 1;
    end 
    else if (tx_en) begin
     case(state)
     START: begin
            Done<=0;
            Busy<=1;
            bit_counter<=0;
            tra_data<=0;
            shift<={1'b1,data};
            state<=TRANSMISSION;
            end
   TRANSMISSION: begin
                 tra_data<=shift[bit_counter];
                 if(bit_counter<10) begin
                 bit_counter<=bit_counter+1;
                 end
                 else begin
                 bit_counter<=0;
                 Done<=1'b1;
                 Busy<=1'b0;
                 state<=PASS;
                 end
                 end
    PASS:begin
         Done<=0;
         Busy<=1;
         tra_data<=1;
         state<=PASS1;
         end
    PASS1:begin
         Done<=0;
         Busy<=1;
         tra_data<=1;
         state<=START;
         end
   
    IDLE:begin
         Done<=1'b0;
         Busy<=1'b0;
         shift<=0;
         end
   default:state<=IDLE; 
   endcase  
  end  
 end                   
 endmodule
