`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 10:09:26
// Design Name: 
// Module Name: mem
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


module mem(
    input                   clk, 
    input                   we, 
    input       [31:0]      a, 
    input       [31:0]      wd, 
    output      [31:0]      rd
    ); 
    //reg define
reg [31:0] RAM[127:0];          // increased size of memory 
initial 
$readmemh("D:/eda/riscv/multicycle_processor/riscv_m/riscvtest2.txt",RAM); 
assign rd = RAM[a[31:2]]; // word aligned 

always@(posedge clk) 
if (we) RAM[a[31:2]] <= wd; 
endmodule 
