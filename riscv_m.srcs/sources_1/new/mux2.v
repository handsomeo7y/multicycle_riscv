`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/18 16:41:08
// Design Name: 
// Module Name: mux2
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


module mux2#(parameter WIDTH = 8)( 
    input   [WIDTH-1:0]     d0,
    input   [WIDTH-1:0]     d1,
    input                   s,
    output  [WIDTH-1:0]     y              



);
    assign y = s ? d1:d0;
endmodule
