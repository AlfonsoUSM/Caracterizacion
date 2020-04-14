`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2020 17:30:14
// Design Name: 
// Module Name: processing_unit
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


module processing_unit(
    input clk,
    input reset,
    input [1:0] control,
    input [7:0] bramA_byte,
    input [7:0] bramB_byte,
    output [7:0] write_byte,
    output [9:0] read_addr,
    output [9:0] write_addr
    );
endmodule
