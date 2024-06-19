`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 17:43:53
// Design Name: 
// Module Name: aludec
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


module aludec(
    input                   opb5        ,
    input       [2:0]       funct3      ,
    input                   funct7b5    ,
    input       [1:0]       ALUOp       ,
    output  reg [3:0]       ALUControl   // expend to 4 bits for sra
    );
    //wire define
    wire   RtypeSub;
    assign RtypeSub = funct7b5 & opb5;  // TRUE for R-type subtract
    always@(*)begin
       case(ALUOp)
           2'b00:ALUControl = 4'b0000; // addition
           2'b01:ALUControl = 4'b0001; // subtraction
           default: case(funct3) // R-type or I-type ALU
                        3'b000:begin
                                    if (RtypeSub)
                                        ALUControl = 4'b0001; // sub
                                    else
                                        ALUControl = 4'b0000; // add, addi
                               end
                       3'b001:ALUControl = 4'b0110; // sll, slli
                       3'b010:ALUControl = 4'b0101; // slt, slti
                       3'b100:ALUControl = 4'b0100; // xor, xori
                       3'b101: begin if (funct7b5)  
                            ALUControl = 4'b1000; // sra, srai 
                          else 
                            ALUControl = 4'b0111; // srl, srli 
                       end
                       3'b110:ALUControl = 4'b0011; // or, ori 
                       3'b111:ALUControl = 4'b0010; // and, andi 
                       default: ALUControl = 4'bxxxx; // ???
            endcase
       endcase
    end

endmodule
