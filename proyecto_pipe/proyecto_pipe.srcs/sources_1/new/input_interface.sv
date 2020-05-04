`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2020 13:41:22
// Design Name: 
// Module Name: input_interface
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

    input_interface #(.NBYTES (1024)) instance_name (
        .clk(),             // 1 bit Input : clock signal
        .reset(),           // 1 bit Input : cpu reset
        .rx_serial(),       // 1 bit Input : serial receive
        .pro_done(),        // 1 bit Input : result ready
        .t_done(),          // 1 bit Input : result trsnmission done
        .shiftA(),            // 1 bit Output : enable BRAM_A write
        .shiftB(),            // 1 bit Output : enable BRAM_B write
        .t_ctrl(),          // 2 bits Output : transmission control signals
        .pro_ctrl(),        // 4 bits Output : processor control combo signal 
        .write_byte(),      // 8 bits Output : BRAM byte of data to write
        .vec_ready()        // 2 bits Output : vectors A and B loaded flags
    );   
    
*/ //////////////////////////////////////////////////

module input_interface #(parameter NBYTES = 1024)(
    input clk,
    input reset,
    input rx_serial,
    input pro_done,
    input t_done,
    output shiftA,
    output shiftB,
    output [1:0] t_ctrl,
    output [3:0] pro_ctrl,
    output [7:0] write_byte,
    output [1:0] vec_ready
    );
    
    enum logic [1:0] {IDLE, STORE, PROCESS, SEND} state, next_state;
    
    logic rx_flag;
    logic shift, shift_A, shift_B;
    logic AorB, next_AorB;
    logic [1:0] t_control, next_t_control;
    logic [3:0] pro_control, next_pro_control;
    logic [7:0] rx_byte;
    logic [9:0] count, next_count;
    logic [1:0] ready, next_ready;
    
    assign shiftA = shift_A;
    assign shiftB = shift_B;
    assign pro_ctrl = pro_control;
    assign t_ctrl = t_control;
    assign write_byte = rx_byte;
    assign vec_ready = ready;
    
    always_ff @ (posedge clk) begin
        if (reset == 1'b1) begin
            state <= IDLE;
            count <= 10'd0;
            AorB <= 1'b0;
            t_control <= 2'b0;
            pro_control <= 4'b0;
            ready <= 2'b0;
        end
        else begin
            state <= next_state;
            count <= next_count;
            AorB <= next_AorB;
            t_control <= next_t_control;
            pro_control <= next_pro_control;
            ready <= next_ready;
        end
    end
    
    always_comb begin
        next_state = state; 
        next_count = count;
        next_AorB = AorB;
        next_t_control = {1'b0, t_control[0]};
        next_pro_control = pro_control;
        shift = 1'b0;
        next_ready = ready;
        case (state)
            IDLE: begin
                if (rx_flag == 1'b1) begin
                    if (rx_byte[7:1] == 7'b0) begin
                        next_state = STORE;
                        next_AorB = rx_byte[0];
                        if (rx_byte[0] == 1'b0)     // reset vector ready flag
                            next_ready[0] = 1'b0;
                        else
                            next_ready[1] = 1'b0;
                    end
                    else begin
                        next_state = PROCESS;
                        next_pro_control = {1'b1, rx_byte[2:0]};
                    end
                end
            end
            STORE: begin
                if (rx_flag == 1'b1) begin
                    shift = 1'b1;
                    if (count == (NBYTES - 1)) begin
                        next_count = 10'b0;
                        //next_state = IDLE;
                        next_state = PROCESS;          // quitar
                        next_pro_control = {1'b1, rx_byte[2:0]};   // quitar
                        if (AorB == 1'b0)
                            next_ready[0] = 1'b1;
                        else
                            next_ready[1] = 1'b0;
                    end
                    else
                        next_count = count + 10'd1;
                end
            end
            PROCESS: begin
                if (pro_done == 1'b1) begin
                    next_state = SEND;         
                    next_t_control[1] = 1'b1;  
                    next_pro_control = 4'd0;
                end
            end
            SEND: begin
                if (t_done == 1'b1)
                    next_state = IDLE;
            end
        endcase
        if (AorB == 1'b0) begin
            shift_A = shift;
            shift_B = 1'b0;
        end
        else begin
            shift_A = 1'b0;
            shift_B = shift;
        end
    end
    uart_rx #(.CLKS_PER_BIT(100)) instance_name(
        .clock(clk),
        .reset(reset),
        .Rx_Serial(rx_serial),
        .Rx_DV(rx_flag),
        .Rx_Byte(rx_byte)
    );
    
endmodule
