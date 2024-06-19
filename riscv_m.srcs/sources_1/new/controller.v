`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 16:08:54
// Design Name: 
// Module Name: controller
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


module controller(
    input               clk,
    input               reset,
    input       [6:0]   op,
    input       [2:0]   funct3,
    input               funct7b5,
    input       [3:0]   Flags,
    output      [2:0]   ImmSrc,
    output      [1:0]   ALUSrcA,
    output      [1:0]   ALUSrcB,
    output      [1:0]   ResultSrc,
    output              AdrSrc,
    output      [3:0]   ALUControl,
    output              IRWrite,
    output              PCWrite,
    output              RegWrite,
    output              MemWrite,
    output              LoadType,  // lbu
    output              StoreType, //sb
    output              PCTargetSrc //jalr
    );
//wire define
wire        taken;
wire        Branch;
wire        PCUpdate;
wire [1:0]  ALUOp;

// Main FSM    
mainfsm fsm(
.clk                        (clk),     
.reset                      (reset),   
.op                         (op),      
.ALUSrcA                    (ALUSrcA), 
.ALUSrcB                    (ALUSrcB), 
.ResultSrc                  (ResultSrc),
.AdrSrc                     (AdrSrc),  
.IRWrite                    (IRWrite), 
.PCUpdate                   (PCUpdate),
.RegWrite                   (RegWrite),
.MemWrite                   (MemWrite),
.ALUOp                      (ALUOp),   
.Branch                     (Branch)

);    

// ALU decoder
aludec  ad(
    .opb5                (op[5])        ,     
    .funct3              (funct3)       ,
    .funct7b5            (funct7b5)     ,
    .ALUOp               (ALUOp)        ,
    .ALUControl          (ALUControl)   
     );
// Instruction Decoder
instrdec id(
    .op                  (op),   
    .ImmSrc              (ImmSrc)

);
// branch logic
lsu lsu_u(
.funct3                 (funct3),  
.LoadType               (LoadType),
.StoreType              (StoreType)

);
bu  branchunit(
    .Branch             (Branch),
    .Flags              (Flags), 
    .funct3             (funct3),
    .taken              (taken)

);

assign PCWrite = taken | PCUpdate;     
    
endmodule
