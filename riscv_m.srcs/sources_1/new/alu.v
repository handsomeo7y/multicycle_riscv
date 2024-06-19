`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 16:53:56
// Design Name: 
// Module Name: alu
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


module alu(
    input       [3:0]       ALUControl,
    input       [31:0]      a,
    input       [31:0]      b,
    output      [3:0]       flags,
    output  reg [31:0]      ALUResult
    );
    // wire define
  wire [31:0] condinvb, sum; 
  wire        cout;           // carry out of adder 
  wire v,c,n,z;
  wire isAddSub;                // true if is an add or Sub operation
  
  assign flags={v,c,n,z}; 
  assign condinvb = ALUControl[0] ? ~b : b; 
  assign {cout, sum} = a + condinvb + ALUControl[0]; 
  assign isAddSub = (~ALUControl[3] & ~ALUControl[2]& ~ALUControl[1])|
  (~ALUControl[3] & ~ALUControl[1]& ALUControl[0]); // add sub slt
   
  always@(*)begin 
    case (ALUControl) 
      4'b0000:   ALUResult <= sum;                    // add 
      4'b0001:   ALUResult <= sum;                    // subtract 
      4'b0010:   ALUResult <= a & b;                 // and 
      4'b0011:   ALUResult <= a | b;                 // or 
      4'b0100:   ALUResult <= a ^ b;                 // xor
      4'b0101:   ALUResult <= sum[31]^v;             // slt 
      4'b0110:   ALUResult <= a<<b[4:0];             //sll
      4'b0111:   ALUResult <= a>>b[4:0];             //srl
      4'b1000:   ALUResult <= $signed(a)>>b[4:0];    //sra    
      default:  ALUResult = 32'd0; 
    endcase
  end
  // 为分支语句提供标志位     // added for blt and other branches 
  assign z = (ALUResult == 32'b0); 
  assign n = ALUResult[31]; 
  assign c = cout & isAddSub; 
  assign v = ~(ALUControl[0] ^ a[31] ^ b[31]) & (a[31] ^ sum[31]) & isAddSub;  
endmodule
