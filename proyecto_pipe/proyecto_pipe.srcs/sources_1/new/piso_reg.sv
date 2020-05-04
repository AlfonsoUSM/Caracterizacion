`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2020 13:44:15
// Design Name: 
// Module Name: piso_reg
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

    piso_reg #(.NBYTES (1024)) instance_name(
        .clk(),     // 1 bit Input : clock signal
        .reset(),   // 1 bit Input : cpu reset signal
        .set(),     // 1 bit Input : set parallel register
        .shift(),   // 1 bit Input : register shifting signal
        .in(),      // NBYTES bytes Input : parallel input
        .out()      // 8 bits Output : output byte
    );
    
*/ //////////////////////////////////////////////////

module piso_reg #(parameter NBYTES = 1024)(
    input clk,
    input reset,
    input set,
    input shift,
    input [7:0] in [(NBYTES - 1):0],
    output [7:0] out
    );
    
    logic [7:0] preg[(NBYTES - 1):0];
    logic [7:0] next_preg[(NBYTES - 1):0];
    
    assign out = preg[0][7:0];
    
    always_ff @ (posedge clk) begin
        if (reset == 1'b1) begin
            preg <= '{default:8'b0};
        end
        else begin
            preg <= next_preg;
        end
    end
    
    always_comb begin
        if (set == 1'b1)
            next_preg = in;
        else begin
            if (shift == 1'b1) begin
                next_preg[(NBYTES - 1)] = preg[0];
                next_preg[(NBYTES - 2):0] = preg[(NBYTES - 1):1];
            end
            else
                next_preg = preg;
        end 
    end
    
endmodule
