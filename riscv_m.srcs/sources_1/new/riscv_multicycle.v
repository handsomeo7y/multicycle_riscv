`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 10:09:13
// Design Name: 
// Module Name: riscv_multicycle
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


module riscv_multicycle(
    input                   clk         ,      
    input                   reset       ,
    input       [31:0]      ReadData    ,
    output                  MemWrite    ,
    output      [31:0]      WriteData   ,
    output      [31:0]      Adr
);

// wire define
wire    [2:0]   ImmSrc;
wire    [1:0]   ALUSrcA;
wire    [1:0]   ALUSrcB;
wire    [1:0]   ResultSrc;
wire            AdrSrc;
wire            IRWrite;
wire            PCWrite;
wire            RegWrite;
wire    [3:0]   ALUControl; 
wire            PCTargetSrc;  
wire            LoadType;
wire            StoreType;
wire    [6:0]   op;
wire    [3:0]   Flags;
wire    [2:0]   funct3;
wire            funct7b5;

datapath dp(
    .clk                    (clk)           ,       
    .reset                  (reset)         ,     
    .ImmSrc                 (ImmSrc)        ,    
    .ALUSrcA                (ALUSrcA)       ,   
    .ALUSrcB                (ALUSrcB)       ,   
    .ResultSrc              (ResultSrc)     , 
    .AdrSrc                 (AdrSrc)        ,    
    .IRWrite                (IRWrite)       ,   
    .PCWrite                (PCWrite)       ,   
    .RegWrite               (RegWrite)      ,  
    .MemWrite               (MemWrite)      ,  
    .ALUControl             (ALUControl)    ,
    .PCTargetSrc            (PCTargetSrc)   ,
    .ReadData               (ReadData)      ,  
    .LoadType               (LoadType)      ,  
    .StoreType              (StoreType)     , 
    .op                     (op)            ,        
    .Flags                  (Flags)         ,     
    .funct3                 (funct3)        ,    
    .funct7b5               (funct7b5)      ,  
    .Adr                    (Adr)           ,       
    .WriteData              (WriteData)
);

controller contr(
    .clk                    (clk)           ,       
    .reset                  (reset)         ,     
    .op                     (op)            ,        
    .funct3                 (funct3)        ,    
    .funct7b5               (funct7b5)      ,  
    .Flags                  (Flags)         ,     
    .ImmSrc                 (ImmSrc)        ,    
    .ALUSrcA                (ALUSrcA)       ,   
    .ALUSrcB                (ALUSrcB)       ,   
    .ResultSrc              (ResultSrc)     , 
    .AdrSrc                 (AdrSrc)        ,    
    .ALUControl             (ALUControl)    ,
    .IRWrite                (IRWrite)       ,   
    .PCWrite                (PCWrite)       ,   
    .RegWrite               (RegWrite)      ,  
    .MemWrite               (MemWrite)      ,  
    .LoadType               (LoadType)      ,  
    .StoreType              (StoreType)     , 
    .PCTargetSrc            (PCTargetSrc)


);




endmodule
