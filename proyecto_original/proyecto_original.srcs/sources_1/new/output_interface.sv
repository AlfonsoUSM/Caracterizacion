`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2020 17:30:14
// Design Name: 
// Module Name: output_interface
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

/* /////////////// Instance Template ////////////////////

    output_interface  #(.NBYTES (1024)) instance_name (
        .clk(),             // 1 bit Input : input clock
        .reset(),           // 1 bit Input : CPU reset
        .control(),         // 2 bits Input : 
        .read_byte(),       // 8 bits Input : bram read data
        .tx_serial(),       // 8 bits Input : serial byte to transmit
        .read_addr(),       // 10 bits Output : bram read address
        .done()             // 1 bit Input : pocessing and transmission finished
    );
    
*/ ////////////////////////////////////////////////////////

module output_interface #(parameter NBYTES = 1024)(
    input clk,
    input reset,
    input [1:0] control,
    input [7:0] read_byte,
    output tx_serial,
    output [9:0] read_addr,
    output done
    );
endmodule
