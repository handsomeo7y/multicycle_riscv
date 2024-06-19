`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/17 17:44:45
// Design Name: 
// Module Name: mainfsm
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


module mainfsm(
    input                   clk,
    input                   reset,
    input       [6:0]       op,
    output      [1:0]       ALUSrcA,
    output      [1:0]       ALUSrcB,
    output      [1:0]       ResultSrc,
    output                  AdrSrc,
    output                  IRWrite,
    output                  PCUpdate,
    output                  RegWrite,
    output                  MemWrite,
    output      [1:0]       ALUOp,
    output                  Branch
    );
parameter s0_Fetch      = 12'b000000000001;
parameter s1_Decode     = 12'b000000000010; 
parameter s2_MemAdr     = 12'b000000000100; 
parameter s3_MemRead    = 12'b000000001000; 
parameter s4_MemWB      = 12'b000000010000; 
parameter s5_MemWrite   = 12'b000000100000; 
parameter s6_ExecuteR   = 12'b000001000000; 
parameter s7_ALUWB      = 12'b000010000000; 
parameter s8_ExecuteI   = 12'b000100000000; 
parameter s9_JAL        = 12'b001000000000; 
parameter s10_BEQ       = 12'b010000000000; 
parameter s11_UNKONW    = 12'b100000000000; 
   
//reg define
reg [10:0] n_state;
reg [10:0] c_state;
reg [15:0] controls;


// state register
always@(posedge clk or posedge reset)begin  
    if(reset)
        c_state <=  s0_Fetch;
    else
        c_state <=  n_state;
end
// next state logic
always@(*)begin
    case(c_state)
        s0_Fetch:n_state    <=  s1_Decode;
        s1_Decode:begin
            case(op)
                7'b0000011:n_state  <=  s2_MemAdr;
                7'b0100011:n_state  <=  s2_MemAdr;
                7'b0110011:n_state  <=  s6_ExecuteR;
                7'b0010011:n_state  <=  s8_ExecuteI;  
                7'b1101111:n_state  <=  s9_JAL;
                7'b1100011:n_state  <=  s10_BEQ; 
                default: n_state    <=  s11_UNKONW;
            endcase
        end
        s2_MemAdr:begin
            if(op[5]==1)
                n_state <=  s5_MemWrite;
            else
                n_state <=  s3_MemRead;    
         end
         s3_MemRead:n_state <=  s4_MemWB;
         s4_MemWB:n_state   <=  s0_Fetch;
         s5_MemWrite:n_state<=  s0_Fetch;
         s6_ExecuteR:n_state<=  s7_ALUWB;
         s7_ALUWB:n_state   <=  s0_Fetch;
         s8_ExecuteI:n_state<=  s7_ALUWB;
         s9_JAL:n_state     <=  s7_ALUWB;
         s10_BEQ:n_state    <=  s0_Fetch;
         default:n_state    <=  s11_UNKONW;
     endcase
 end
 
 //state-dependent output logic
 always@(*)begin
    case(c_state)
        s0_Fetch:controls = 15'b00_10_10_0_1100_00_0;
        s1_Decode:controls = 15'b01_01_00_0_0000_00_0;
        s2_MemAdr:controls = 15'b10_01_00_0_0000_00_0;
        s3_MemRead:controls = 15'b00_00_00_1_0000_00_0; 
        s4_MemWB:controls = 15'b00_00_01_0_0010_00_0;
        s5_MemWrite:controls = 15'b00_00_00_1_0001_00_0;
        s6_ExecuteR:controls = 15'b10_00_00_0_0000_10_0;
        s7_ALUWB:controls = 15'b00_00_00_0_0010_00_0;
        s8_ExecuteI:controls = 15'b10_01_00_0_0000_10_0;
        s9_JAL:controls = 15'b01_10_00_0_0100_00_0;
        s10_BEQ:controls = 15'b10_00_00_0_0000_01_1;
        default:controls = 15'bxx_xx_xx_x_xxxx_xx_x; 
    endcase     
end

assign {ALUSrcA, ALUSrcB, ResultSrc, AdrSrc, IRWrite, 
PCUpdate,RegWrite, MemWrite, ALUOp, Branch}=controls;             
                 
endmodule
