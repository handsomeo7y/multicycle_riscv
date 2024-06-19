`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 11:30:33
// Design Name: 
// Module Name: datapath
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


module datapath(
    input                   clk,
    input                   reset,
    input       [2:0]       ImmSrc,
    input       [1:0]       ALUSrcA,
    input       [1:0]       ALUSrcB,
    input       [1:0]       ResultSrc,
    input                   AdrSrc,
    input                   IRWrite,
    input                   PCWrite,
    input                   RegWrite,
    input                   MemWrite,
    input       [3:0]       ALUControl,
    input                   PCTargetSrc,
    input       [31:0]      ReadData,
    input                   LoadType,
    input                   StoreType,
    output      [6:0]       op,
    output      [3:0]       Flags,
    output      [2:0]       funct3,
    output                  funct7b5,
    output      [31:0]      Adr,
    output      [31:0]      WriteData
    );
// wire define
wire [31:0] PC; 
wire [31:0] OldPC;  
wire [31:0] Instr;
wire [31:0] data;
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] Result;
wire [31:0] ImmExt; 
wire [31:0] A;
wire [31:0] SrcA;
wire [31:0] SrcB;
wire [31:0] ALUResult;
wire [31:0] ALUOut;
 
// next PC Logic
flopren#(32) pcreg(
    .clk                (clk)       ,  
    .reset              (reset)     ,
    .en                 (PCWrite)   ,   
    .d                  (Result)    ,    
    .q                  (PC)
    );
flopren#(32) oldpcreg(
    .clk                (clk)       ,  
    .reset              (reset)     ,
    .en                 (IRWrite)   ,   
    .d                  (PC)        ,    
    .q                  (OldPC)
    );

// memory logic

mux2#(32)  adrmux(
    .d0                 (PC)        ,
    .d1                 (Result)    ,
    .s                  (AdrSrc)    ,
    .y                  (Adr)    
    );

flopren#(32) instrreg(
    .clk                (clk)       ,  
    .reset              (reset)     ,
    .en                 (IRWrite)   ,   
    .d                  (ReadData)  ,    
    .q                  (Instr)
    );
flopr#(32) rdatareg(
    .clk                (clk)       ,  
    .reset              (reset)     ,   
    .d                  (ReadData)  ,    
    .q                  (data)
    );

//regiter file logic
regfile rf(
    .clk            (clk)           ,
    .A1             (Instr[19:15])  ,
    .A2             (Instr[24:20])  ,
    .A3             (Instr[11:7])   ,
    .WD3            (Result)        ,
    .WE3            (RegWrite)      ,
    .RD1            (RD1)           ,
    .RD2            (RD2)        
    );
extend  ext(
    .instr          (Instr[31:7])   , 
    .immsrc         (ImmSrc)        ,
    .immext         (ImmExt)        
    );
flopr#(32) srcareg(
    .clk                (clk)       ,  
    .reset              (reset)     ,   
    .d                  (RD1)       ,    
    .q                  (A)
    );
flopr#(32) wdreg(
    .clk                (clk)       ,  
    .reset              (reset)     ,   
    .d                  (RD2)       ,    
    .q                  (WriteData)
    );
//ALU logic
mux3#(32) srcamux(
     .d0            (PC)            ,            
     .d1            (OldPC)         ,
     .d2            (A)             ,
     .s             (ALUSrcA)       ,
     .y             (SrcA)        
     );
mux3#(32) srcbmux(
     .d0            (WriteData)     ,            
     .d1            (ImmExt)        ,
     .d2            (32'd4)         ,
     .s             (ALUSrcB)       ,
     .y             (SrcB)        
     );
alu alu_u(
     .ALUControl    (ALUControl)    ,
     .a             (SrcA)          ,      
     .b             (SrcB)          ,      
     .flags         (Flags)         ,      
     .ALUResult     (ALUResult)
     );
flopr#(32) aluoutreg(
    .clk            (clk)           ,  
    .reset          (reset)         ,   
    .d              (ALUResult)     ,    
    .q              (ALUOut)
    );
mux3#(32) resultmux(
     .d0            (ALUOut)        ,            
     .d1            (data)          ,
     .d2            (ALUResult)     ,
     .s             (ResultSrc)     ,
     .y             (Result)        
     );

 // outputs to control unit 
  assign op       = Instr[6:0]; 
  assign funct3   = Instr[14:12]; 
  assign funct7b5 = Instr[30];    
    
    
endmodule
