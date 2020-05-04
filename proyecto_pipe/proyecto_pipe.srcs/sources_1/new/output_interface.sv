`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2020 13:41:22
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
        .start(),           // 1 bit Input : begin transmission signal
        .size(),            // 1 bit Input : number of bytes to transmit selection
        .result_byte(),     // 8 bits Input : piso reg read byte
        .tx_serial(),       // 1 bit Output : serial transmit
        .shift(),           // 1 bit Output : shift sipo registers
        .done()             // 1 bit Input : pocessing and transmission finished
    );
    
*/ ////////////////////////////////////////////////////////

module output_interface #(parameter NBYTES = 1024)(
    input clk,
    input reset,
    input start,
    input size,
    input [7:0] result_byte,
    output tx_serial,
    output shift,
    output done
    );
    
    enum logic [1:0] {IDLE, SEND, TWAIT} state, next_state;
    
    logic tx_send, tx_flag;
    logic ready, reg_shift;
    logic [9:0] count, next_count;
    
    assign shift = reg_shift;
    assign done = ready;
    
    always_ff @ (posedge clk) begin
        if (reset == 1'b1) begin
            state <= IDLE;
            count <= 10'd0;
        end
        else begin
            state <= next_state;
            count <= next_count;
        end
    end
    
    always_comb begin
        next_state = state;
        next_count = count;
        tx_send = 1'b0;
        reg_shift = 1'b0;
        ready = 1'b0;
        case (state)
            IDLE: begin
                if (start == 1'b1)
                    next_state = SEND;
            end
            SEND: begin
                tx_send = 1'b1;
                next_state = TWAIT;
                reg_shift = 1'b1;
            end
            TWAIT: begin
                if (tx_flag == 1'b1) begin
                    if (count == (NBYTES - 1)) begin
                        next_state = IDLE;
                        next_count = 10'd0;
                        ready = 1'b1;
                    end
                    else begin
                        next_count = count + 10'd1;
                        next_state = SEND;
                    end
                end
            end
        endcase
    end
        
    uart_tx #(.CLKS_PER_BIT(100)) instance_name(
        .Clock(clk),
        .reset(reset),
        .Tx_DV(tx_send),
        .Tx_Byte(result_byte), 
        .Tx_Active(),
        .Tx_Serial(tx_serial),
        .Tx_Done(tx_flag)
    );
endmodule
