`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 16:12:40
// Design Name: 
// Module Name: flopren
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


module flopren#(parameter WIDTH=8)(
    input                       clk,
    input                       reset,
    input                       en,
    input       [WIDTH-1:0]     d,
    output  reg [WIDTH-1:0]     q

    );
    always@(posedge clk or posedge reset)begin
        if(reset)
            q <= 32'd0;
        else if(en==1'b1)
            q <= d;
    end
           
    
endmodule
