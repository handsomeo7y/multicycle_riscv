`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 17:43:33
// Design Name: 
// Module Name: instrdec
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


 module instrdec (
    input       [6:0]       op,  
    output  reg [2:0]       ImmSrc
    ); 
  always@(*) 
    case(op) 
      7'b0110011: ImmSrc = 3'b000; // R-type  这里其实是ImmSrc = 3'bxxx 不过case里面最好不用x，这里改成0不影响
      7'b0010011: ImmSrc = 3'b000; // I-type ALU 
      7'b0000011: ImmSrc = 3'b000; // lw / lbu 
      7'b0100011: ImmSrc = 3'b001; // sw / sb 
      7'b1100011: ImmSrc = 3'b010; // branches 
      7'b1101111: ImmSrc = 3'b011; // jal 
      7'b0110111: ImmSrc = 3'b100; // lui 
      7'b1100111: ImmSrc = 3'b000; // jalr 
      7'b0010111: ImmSrc = 3'b100; // auipc 
      default:    ImmSrc = 3'b000; // ???  同上，也改成了0
    endcase 
endmodule 
