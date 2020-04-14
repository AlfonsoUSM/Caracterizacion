`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2020 17:14:03
// Design Name: 
// Module Name: topmodule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module topmodule(
    input CLK100MHZ,
    input CPU_RESETN,
    input UART_TXD_IN,
    output UART_RXD_OUT,
    output LED16_B,
    output LED17_B
    );
    
    localparam NBYTES = 8;
    
    logic serCLK;   // serial clock
    logic proCLK;   // processing clock
    
    assign serCLK = CLK100MHZ;
    assign proCLK = CLK100MHZ;
    
    logic wenA, wenB;
    logic [7:0] write_byte;
    logic [9:0] write_addr;
    
    input_interface #(.NBYTES (NBYTES)) input_instance (
        .clk(serCLK),             // 1 bit Input : clock signal
        .reset(~CPU_RESETN),           // 1 bit Input : cpu reset
        .rx_serial(UART_TXD_IN),       // 1 bit Input : serial receive
        .wenA(wenA),            // 1 bit Output : enable BRAM_A write
        .wenB(wenB),            // 1 bit Output : enable BRAM_B write
        .control(),          // 3 bits Output : 
        .write_byte(write_byte),      // 8 bits Output : BRAM byte of data to write
        .write_addr(write_addr),      // 10 bits Output : BRAM writing address
        .vec_ready()        // 2 bits Output : vectors A and B loaded flags
    ); 
    
    logic tx_done;
    logic [7:0] readC_byte;
    logic [9:0] readC_addr;
    
    output_interface  #(.NBYTES (NBYTES)) output_instance (
        .clk(serCLK),             // 1 bit Input : input clock
        .reset(~CPU_RESETN),           // 1 bit Input : CPU reset
        .control(),         // 2 bits Input : 
        .read_byte(readC_byte),       // 8 bits Input : bram read data
        .tx_serial(UART_RXD_OUT),       // 8 bits Input : serial byte to transmit
        .read_addr(readC_addr),       // 10 bits Output : bram read address
        .done(tx_done)             // 1 bit Input : pocessing and transmission finished
    );
    
endmodule
