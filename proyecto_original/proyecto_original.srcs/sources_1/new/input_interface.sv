`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2020 17:30:14
// Design Name: 
// Module Name: input_interface
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

/* ////////////// INSTANCE TEMPLATE ////////////////

    input_interface #(.NBYTES (1024)) instance_name (
        .clk(),             // 1 bit Input : clock signal
        .reset(),           // 1 bit Input : cpu reset
        .rx_serial(),       // 1 bit Input : serial receive
        .wenA(),            // 1 bit Output : enable BRAM_A write
        .wenB(),            // 1 bit Output : enable BRAM_B write
        .control(),         // 3 bits Output : 
        .write_byte(),      // 8 bits Output : BRAM byte of data to write
        .write_addr(),      // 10 bits Output : BRAM writing address
        .vec_ready()        // 2 bits Output : vectors A and B loaded flags
    );   
    
*/ //////////////////////////////////////////////////

module input_interface #(parameter NBYTES = 1024) (
    input clk,
    input reset,
    input rx_serial,
    output wenA,
    output wenB,
    output [2:0] control,
    output [7:0] write_byte,
    output [9:0] write_addr,
    output [1:0] vec_ready
    );
    
    logic rx_flag;
    logic [7:0] rx_byte;
    
    uart_rx #(.CLKS_PER_BIT(100)) serial_rx (
        .clock(clk),
        .reset(reset),
        .Rx_Serial(rx_serial),
        .Rx_DV(rx_flag),
        .Rx_Byte(rx_byte)
    );
    
endmodule
