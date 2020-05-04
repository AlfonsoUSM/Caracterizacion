`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2020 13:41:22
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

/* /////////////// Instance Template ////////////////////

    processing_unit  #(.NBYTES (1024)) instance_name (
        .clk(),             // 1 bit Input : input clock
        .reset(),           // 1 bit Input : CPU reset
        .start(),           // 1 bit Input : start
        .control(),         // 3 bits Input : command
        .vectorA(),         // NBYTES Bytes Input : bram A read data
        .vectorB(),         // NBYTES Bytes Input : bram B read data
        .result(),          // NBYTES Bytes Output : result bram write data 
        .set(),             // 1 bit Output : set result registers
        .done()
    );
    
*/ ////////////////////////////////////////////////////////

module processing_unit #(parameter NBYTES = 1024)(
    input clk,
    input reset,
    input start,
    input [2:0] control,
    input [(NBYTES - 1):0][7:0] vectorA,
    input [(NBYTES - 1):0][7:0] vectorB,
    output [(NBYTES - 1):0][7:0] result,
    output set,
    output done
    );
    
    
    enum logic {IDLE, PROCESS} state, next_state;
    logic store, ready;
    
    assign set = store;
    assign result = vectorB;
    assign done = ready;
    
    always_ff @ (posedge clk) begin
        if (reset == 1'b1) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        next_state = state;
        store = 1'b0;
        ready = 1'b0;
        case (state) 
            IDLE: begin
                if (start == 1'b1)
                    next_state = PROCESS;
                else
                    ready = 1'b1;
            end
            PROCESS: begin
                next_state = IDLE; 
                store = 1'b1;
                ready = 1'b1;
            end
        endcase
    end
    
endmodule
