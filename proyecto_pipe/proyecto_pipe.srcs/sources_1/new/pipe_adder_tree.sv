`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2020 13:58:07
// Design Name: 
// Module Name: pipe_adder_tree
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


module pipe_adder_tree #(parameter NBYTES = 1024)(
    input clk,
    input reset,
    input [7:0] inVector [(NBYTES - 1):0],
    output logic [(7 + $clog2(NBYTES)):0] out
    );
    
    localparam R = $clog2(NBYTES);
    
    genvar i, j; 
    generate
        for (i = 0 ; i < R; i = i + 1) begin: tree
            logic [(8 + i):0] sums [((NBYTES>>(i+1)) - 1):0];
            logic [(8 + i):0] next_sums [((NBYTES>>(i+1)) - 1):0];
            always_ff @ (posedge clk) begin
                if (reset == 1'b1) begin
                    sums <= '{default : 0};
                end
                else begin
                    sums <= next_sums;
                end
            end
            for (j = 0; j < (NBYTES>>(i+1)); j = j + 1) begin 
                if (i == 0) begin
                    always_comb
                        next_sums[j] = inVector[2 * j][7:0] + inVector[2 * j + 1][7:0];
                end
                else begin
                    always_comb
                        next_sums[j] = tree[i-1].sums[2 * j][(7+i):0] + tree[i-1].sums[2 * j + 1][(7+i):0];
                    if (i == (R-1))
                        assign out = sums[0]; 
                end
            end
        end 
    endgenerate
endmodule
