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
    
    localparam NBYTES2 = 3;
    
    localparam READA = 2'b00;
    localparam READB = 2'b01;
    localparam SUMVEC = 2'b10;
    localparam AVGVEC = 2'b11; 

    localparam COUNTER_MAX = $clog2(NBYTES);
    localparam COUNTER_SIZE = $clog2(COUNTER_MAX);
    
    enum logic {IDLE, PROCESS} state, next_state;
    logic store, ready;
    logic [7:0] vectorC [(NBYTES - 1):0];
    logic [7:0] sumVector [(NBYTES - 1):0];
    logic [7:0] avgVector [(NBYTES - 1):0];
    logic [7:0] difVector [(NBYTES - 1):0];
    
<<<<<<< HEAD
    logic [COUNTER_SIZE-1:0] counter = 'd0;
    logic counter_rst;

=======
>>>>>>> origin/alfonso
    //assign sumVector = '{default:8'b0};
    //assign avgVector = '{default:8'b0}; 
    
    assign set = store;
    assign result = vectorC;
    assign done = ready;
    
    //FSM FF
    always_ff @ (posedge clk) begin
        if (reset == 1'b1) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    //Counter FF
    logic
    always_ff @ (posedge clk) begin
        if ((reset == 1'b1)||(counter_rst)) begin
            counter <= 1'd0;
        end
        else begin
            counter <= counter + 1'd1;
        end
    end

    genvar k;
    generate
        for ( k = 0; k < NBYTES; k = k + 1) begin: sum_loop
            assign sumVector[k] = vectorA[k] + vectorB[k];
            assign avgVector[k] = sumVector[k] >> 1;
            assign difVector[k] = (vectorA[k] > vectorB[k]) ? vectorA[k] - vectorB[k] : vectorB[k] - vectorA[k];
        end
    endgenerate
    
    logic [(7 + $clog2(NBYTES)):0] manDist;
    logic [(7 + $clog2(NBYTES)):0] manDist2;
    
    pipe_adder_tree #(.NBYTES(NBYTES)) pipe_adder (
        .clk(clk),
        .reset(reset),
        .inVector(difVector),
        .out(manDist2)
        );
        
    combo_adder_tree #(.NBYTES(NBYTES)) combo_adder (
        .inVector(difVector),
        .out(manDist)
        );
    
    genvar k;
    generate
        for ( k = 0; k < NBYTES; k = k + 1) begin: sum_loop
            assign sumVector[k] = vectorA[k] + vectorB[k];
            assign avgVector[k] = sumVector[k] >> 1;
            assign difVector[k] = (vectorA[k] > vectorB[k]) ? vectorA[k] - vectorB[k] : vectorB[k] - vectorA[k];
        end
    endgenerate
    
    logic [(7 + $clog2(NBYTES)):0] manDist;
    logic [(7 + $clog2(NBYTES)):0] manDist2;
    
    pipe_adder_tree #(.NBYTES(NBYTES)) pipe_adder (
        .clk(clk),
        .reset(reset),
        .inVector(difVector),
        .out(manDist2)
        );
        
    combo_adder_tree #(.NBYTES(NBYTES)) combo_adder (
        .inVector(difVector),
        .out(manDist)
        );
    
    always_comb begin
        next_state = state;
        store = 1'b0;
        ready = 1'b0;
        vectorC = '{default:8'b0};
        counter_rst = 1'd1;
        case (state) 
            IDLE: begin
                if (start == 1'b1)
                    next_state = PROCESS;
                else
                    ready = 1'b1;
            end
            PROCESS: begin
                counter_rst = 1'd0;
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
                    next_state = IDLE; 
                    store = 1'b1;
                    ready = 1'b1;
                end
                else begin // Manhattan distance
<<<<<<< HEAD
                    if (counter == (COUNTER_MAX-1)) begin
                        vectorC[0] = manDist[7:0];
                        vectorC[(NBYTES2 - 1):1] = '{default:8'b1}; //manDist[(NBYTES2 - 1):0];
                        vectorC[(NBYTES - 1):NBYTES2] = '{default:8'b0};
                        next_state = IDLE; 
                        store = 1'b1;
                        ready = 1'b1;
                    end
=======
                    vectorC[0] = manDist[7:0];
                    vectorC[(NBYTES2 - 1):1] = '{default:8'b1}; //manDist[(NBYTES2 - 1):0];
                    vectorC[(NBYTES - 1):NBYTES2] = '{default:8'b0};
>>>>>>> origin/alfonso
                end 
                // next_state = IDLE; 
                // store = 1'b1;
                // ready = 1'b1;
            end
        endcase
    end
    
endmodule
