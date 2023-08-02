module UART(clkrx,     // receiver clk
            clktx,     // Transmitter clk
            tra_data,  // Transmitter Output
            tx_Done,   // Transmitter Done
            tx_Busy,   // Transmitter Busy
            rx_Done,   // Receiver Done
            rx_Busy,   // Receiver Busy
            Error,     // Receiver Error
            Received,  // Received Data
            tx_rst,    // Transmitter Reset
            tx_en,     // Transmitter Enable
            rx_en,     // Receiver Enable
            rx_rst,    // Receiver reset
            /*rx_data,*/   // Receiver Input Data
            clk,       // Board Clock
            txin_data, // Transmitter Input Data
            baud_rst,  // Baud generater Reset
            baud_sel   // Baud Selection Line
               );

input wire tx_rst,tx_en,rx_en,rx_rst,/*rx_data,*/clk,baud_rst;
input wire[1:0]baud_sel;
input wire [9:0]txin_data;
output wire tra_data,tx_Done,tx_Busy,rx_Done,rx_Busy,Error,clkrx,clktx;
output wire[7:0]Received;

UART_Tx   U1(tx_Done,tx_Busy,clktx,tx_rst,tx_en,txin_data,tra_data);
UART_Rx   U2(rx_Done,rx_Busy,Error,Received,clkrx,rx_rst,rx_en,tra_data);
UART_Baud U3(clkrx,clktx,clk,reset,sel);

endmodule
