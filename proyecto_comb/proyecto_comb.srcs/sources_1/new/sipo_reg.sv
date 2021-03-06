`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2020 13:44:15
// Design Name: 
// Module Name: sipo_reg
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

    sipo_reg #(.NBYTES (1024)) instance_name(
        .clk(),     // 1 bit Input : clock signal
        .reset(),   // 1 bit Input : cpu reset signal
        .shift(),   // 1 bit Input : register shifting signal
        .in(),      // 8 bits Input : input byte
        .out()      // NBYTES bytes Output : parallel output
    );
    
*/ //////////////////////////////////////////////////

module sipo_reg #(parameter NBYTES = 1024)(
    input clk,
    input reset,
    input shift,
    input [7:0] in,
    output [7:0] out [(NBYTES - 1):0]
    );
    
    
    logic [7:0] preg [(NBYTES - 1):0];
    logic [7:0] next_preg [(NBYTES - 1):0];
    assign out = preg;
    
    always_ff @ (posedge clk) begin
        if (reset == 1'b1)
            preg <= '{default:8'b0};
        else
            preg <= next_preg;
    end
    
    always_comb begin
        if (shift == 1'b1) begin
            next_preg[(NBYTES - 1)] = in;
            next_preg[(NBYTES - 2):0] = preg[(NBYTES - 1):1];
        end
        else
            next_preg = preg;
    end
    
endmodule
