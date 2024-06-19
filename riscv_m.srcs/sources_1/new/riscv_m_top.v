`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 10:04:57
// Design Name: 
// Module Name: riscv_m_top
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


module riscv_m_top(
    input                   clk,
    input                   reset,
    output      [31:0]      DataAdr,
    output      [31:0]      WriteData,
    output                  MemWrite
    );
    
//wire define
wire [31:0]  ReadData;  
    
riscv_multicycle riscv_multicycle_u(
    .clk                   (clk)       , 
    .reset                 (reset)     ,  
    .MemWrite              (MemWrite)  ,
    .Adr                   (DataAdr) ,  
    .WriteData             (WriteData) , 
    .ReadData              (ReadData)
    );
mem mem_u(
    . clk                  (clk)       , 
    . we                   (MemWrite)  , 
    . a                    (DataAdr)   , 
    . wd                   (WriteData) , 
    . rd                   (ReadData)
    ); 
    
    
    
    
endmodule
