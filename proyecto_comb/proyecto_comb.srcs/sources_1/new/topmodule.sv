`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2020 13:18:40
// Design Name: 
// Module Name: topmodule
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


module topmodule(
    input CLK100MHZ,
    input CPU_RESETN,
    input UART_TXD_IN,
    output UART_RXD_OUT,
    output LED16_B,
    output LED17_B,
    output JA1,
    output JA2
    );
    
    localparam NBYTES = 1024;
    logic [1:0] vec_ready;
    
    assign JA1 = UART_TXD_IN;
    assign JA2 = UART_RXD_OUT;
    assign LED16_B = vec_ready[0];
    assign LED17_B = vec_ready[1];
    
    clk_wiz_0 main_clk(
        // Clock out ports
        .clk_out1(clk),    // output clk_out1
        // Status and control signals
        .reset(reset),          // input reset
        .locked(locked),        // output locked
        // Clock in ports
        .clk_in1(CLK100MHZ)       // input clk_in1
    );      


    /*
    // simulacion
    logic CLK, RESET, uart_rx;
    
    always #5 CLK = ~CLK;
    
    initial begin
        CLK = 1'b1;
        RESET = 1'b0;
        uart_rx = 1'b1;
        #6;
        RESET = 1'b1;
        #6;
        RESET = 1'b0;
        #16;
        
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;
        
        #2000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;
        
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;
        
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #100;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;
        
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0; //stop
        #1000;
        
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0; //stop
        #1000;
        
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;
        
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;
        
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;
            
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;       
        
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;
            
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;       
        
        #1000;
        uart_rx = 1'b0; //start bit
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b0;
        #1000;
        uart_rx = 1'b1;
        #1000;
        uart_rx = 1'b1; //stop
        #1000;
    end
    */
    
    logic serCLK, proCLK, reset;
    assign proCLK = clk; //CLK;
    assign serCLK = clk; //CLK;
    assign reset = ~CPU_RESETN; //RESET;
    
    logic shiftA, shiftB;
    logic pro_done, t_done;
    logic [1:0] t_ctrl;
    logic [3:0] pro_ctrl;
    logic [7:0] write_byte, read_byte;
    logic [7:0] vectorA [(NBYTES - 1):0];
    logic [7:0] vectorB [(NBYTES - 1):0];
    
    input_interface #(.NBYTES (NBYTES)) input_instance (
        .clk(serCLK),             // 1 bit Input : clock signal
        .reset(reset),           // 1 bit Input : cpu reset
        .rx_serial(UART_TXD_IN),       // 1 bit Input : serial receive
        .pro_done(pro_done),        // 1 bit Input : result ready
        .t_done(t_done),          // 1 bit Input : result trsnmission done
        .shiftA(shiftA),            // 1 bit Output : enable BRAM_A write
        .shiftB(shiftB),            // 1 bit Output : enable BRAM_B write
        .t_ctrl(t_ctrl),          // 2 bits Output : transmission control signals
        .pro_ctrl(pro_ctrl),        // 4 bits Output : processor control combo signal 
        .write_byte(write_byte),      // 8 bits Output : BRAM byte of data to write
        .vec_ready(vec_ready)        // 2 bits Output : vectors A and B loaded flags
    );   
    
    sipo_reg #(.NBYTES (NBYTES)) vectA_sipo(
        .clk(serCLK),     // 1 bit Input : clock signal
        .reset(reset),   // 1 bit Input : cpu reset signal
        .shift(shiftA),   // 1 bit Input : register shifting signal
        .in(write_byte),      // 8 bits Input : input byte
        .out(vectorA)      // NBYTES bytes Output : parallel output
    );
    
    sipo_reg #(.NBYTES (NBYTES)) vectB_sipo(
        .clk(serCLK),     // 1 bit Input : clock signal
        .reset(reset),   // 1 bit Input : cpu reset signal
        .shift(shiftB),   // 1 bit Input : register shifting signal
        .in(write_byte),      // 8 bits Input : input byte
        .out(vectorB)      // NBYTES bytes Output : parallel output
    );
        
    logic set;
    logic [7:0] result [(NBYTES - 1):0];
    
    processing_unit  #(.NBYTES (NBYTES)) coprocessor (
        .clk(proCLK),             // 1 bit Input : input clock
        .reset(reset),           // 1 bit Input : CPU reset
        .start(pro_ctrl[3]),           // 1 bit Input : start
        .control(pro_ctrl[2:0]),         // 3 bits Input : command
        .vectorA(vectorA),         // NBYTES Bytes Input : bram A read data
        .vectorB(vectorB),         // NBYTES Bytes Input : bram B read data
        .result(result),          // NBYTES Bytes Output : result bram write data 
        .set(set),             // 1 bit Output : set result registers
        .done(pro_done)
    );
    
    logic shiftC;
    
    piso_reg #(.NBYTES (NBYTES)) vectC_piso(
        .clk(serCLK),     // 1 bit Input : clock signal
        .reset(reset),   // 1 bit Input : cpu reset signal
        .set(set),     // 1 bit Input : set parallel register
        .shift(shiftC),   // 1 bit Input : register shifting signal
        .in(result),      // NBYTES bytes Input : parallel input
        .out(read_byte)      // 8 bits Output : output byte
    );
    
    output_interface  #(.NBYTES (NBYTES)) output_instance (
        .clk(serCLK),             // 1 bit Input : input clock
        .reset(reset),           // 1 bit Input : CPU reset
        .start(t_ctrl[1]),           // 1 bit Input : begin transmission signal
        .size(t_ctrl[0]),            // 1 bit Input : number of bytes to transmit selection
        .result_byte(read_byte),     // 8 bits Input : piso reg read byte
        .tx_serial(UART_RXD_OUT),       // 1 bit Output : serial transmit
        .shift(shiftC),           // 1 bit Output : shift sipo registers
        .done(t_done)             // 1 bit Input : pocessing and transmission finished
    );
    
endmodule
