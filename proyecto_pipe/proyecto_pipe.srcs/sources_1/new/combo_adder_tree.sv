`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2020 20:23:48
// Design Name: 
// Module Name: adder_tree
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


module combo_adder_tree #(parameter NBYTES = 1024)(
    input [7:0] inVector [(NBYTES - 1):0],
    output [(7 + $clog2(NBYTES)):0] out
    );
    
    localparam R = $clog2(NBYTES);
    localparam N = NBYTES / 2;
    //localparam N = 2^R;
    //localparam integer NSUMS = N/2 + $ceil(NBYTES/2) - 1; 
    //localparam NBITS = 8 + R - 1;
    
    
    genvar i, j; 
    generate
        for (i = 0 ; i < R; i = i + 1) begin: tree
            logic [(8 + i):0] sums [((NBYTES>>(i+1)) - 1):0];
            for (j = 0; j < (NBYTES>>(i+1)); j = j + 1) begin 
                if (i == 0)
                    assign sums[j] = inVector[2 * j][7:0] + inVector[2 * j + 1][7:0];
                else begin
                    if (i < (R-1))
                        assign tree[i].sums[j] = tree[i-1].sums[2 * j][(7+i):0] + tree[i-1].sums[2 * j + 1][(7+i):0];
                    else
                        assign out = tree[i-1].sums[0] + tree[i-1].sums[1]; 
                end
            end
        end
//        num = N/2; //int'($ceil(NBYTES/2));
//        for (j = 0; j < $ceil(NBYTES/2); j = j + 1) begin: first_stage
//            if ((2 * j + 1) < NBYTES)
//                assign sums[j] = difVector[2 * j] + difVector[2 * j + 1];
//            else
//                assign sums[j] = difVector[2*j];
//        end
//        prev_index = 0;
//        curr_index = num;
//        for (i = 1; i < R; i = i + 1) begin: adder_tree
//            num = $ceil(num/2);
//            for (j = 0; j < num; j = j + 1) begin: nodes
//                if ((2 * j + 1) < curr_index)
//                    assign sums[curr_index + j] = sums[prev_index + j * 2] + sums[prev_index + j * 2 + 1];
//                else
//                    assign sums[curr_index + j] = sums[prev_index + j * 2];
//            end
//            prev_index = curr_index;
//            curr_index = num;
//        end 
    endgenerate
endmodule
