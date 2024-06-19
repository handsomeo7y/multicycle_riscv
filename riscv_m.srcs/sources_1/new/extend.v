`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 16:34:01
// Design Name: 
// Module Name: extend
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

module extend(
    input           [31:7]         instr  ,
    input           [2:0]          immsrc ,
    output  reg     [31:0]         immext
    );
    always@(*)begin
       case(immsrc)
       // I-type
           3'b00:     immext <= {{20{instr[31]}}, instr[31:20]};
       // S-type (stores)
            3'b001:     immext <= {{20{instr[31]}}, instr[31:25],instr[11:7]};
       // B-type (branches)
           3'b010:      immext <= {{20{instr[31]}}, instr[7],instr[30:25], instr[11:8], 1'b0};                                        
      // J-type (jal)
           3'b011:      immext <= {{12{instr[31]}}, instr[19:12],instr[20], instr[30:21], 1'b0};
      // U-type(lui auipc)
           3'b100:   immext = {instr[31:12], 12'b0}; 
           default: immext = 32'bx; // undefined
        endcase
   end
 endmodule
