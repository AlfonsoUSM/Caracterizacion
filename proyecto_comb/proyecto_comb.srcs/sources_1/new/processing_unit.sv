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
    input [7:0] vectorA [(NBYTES - 1):0],
    input [7:0] vectorB [(NBYTES - 1):0],
    output [7:0] result [(NBYTES - 1):0],
    output set,
    output done
    );
    
    localparam NBYTES2 = 2;
    
    localparam READA = 2'b00;
    localparam READB = 2'b01;
    localparam SUMVEC = 2'b10;
    localparam AVGVEC = 2'b11; 
    
    enum logic {IDLE, PROCESS} state, next_state;
    logic store, ready;
    logic [7:0] vectorC [(NBYTES - 1):0];
    logic [7:0] sumVector [(NBYTES - 1):0];
    logic [7:0] avgVector [(NBYTES - 1):0];
    
    assign sumVector = '{default:8'b0};
    assign avgVector = '{default:8'b0}; 
    
    assign set = store;
    assign result = vectorC;
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
        vectorC = '{default:8'b0};
        case (state) 
            IDLE: begin
                if (start == 1'b1)
                    next_state = PROCESS;
                else
                    ready = 1'b1;
            end
            PROCESS: begin
                if(control[2] == 1) begin // vector type result operations
                    case(control[1:0])
                        READA:
                            vectorC = vectorA;
                        READB:
                            vectorC = vectorB;
                        SUMVEC:
                            vectorC = sumVector;
                        AVGVEC:
                            vectorC = avgVector;
                    endcase
                end
                else begin // Manhattan distance
                    vectorC[(NBYTES2 - 1):0] = '{default:8'b1};
                    vectorC[(NBYTES - 1):NBYTES2] = '{default:8'b0};
                end 
                next_state = IDLE; 
                store = 1'b1;
                ready = 1'b1;
            end
        endcase
    end
    
endmodule
