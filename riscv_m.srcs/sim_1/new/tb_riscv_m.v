`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/18 15:27:29
// Design Name: 
// Module Name: tb_riscv_m
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


module tb_riscv_m();
    reg              clk;
    reg              reset;
    reg  [511:0]     monitor_state;     
    wire [31:0]      WriteData, DataAdr;
    wire             MemWrite;
    // instantiate device to be tested
    riscv_m_top dut(
    .clk                (clk), 
    .reset              (reset), 
    .MemWrite           (MemWrite),
    .WriteData          (WriteData), 
    .DataAdr            (DataAdr) 
    );
    // 使modelsim中显示状态名
    
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
    
always@(*)begin
    case(dut.riscv_multicycle_u.contr.fsm.c_state)
        s0_Fetch:  monitor_state = "s0_Fetch ";
        s1_Decode: monitor_state = "s1_Decode";   
        s2_MemAdr:  monitor_state = "s2_MemAdr ";
        s3_MemRead: monitor_state = "s3_MemRead"; 
        s4_MemWB:  monitor_state = "s4_MemWB ";
        s5_MemWrite: monitor_state = "s5_MemWrite";
        s6_ExecuteR:  monitor_state = "s6_ExecuteR ";
        s7_ALUWB: monitor_state = "s7_ALUWB";   
        s8_ExecuteI:  monitor_state = "s8_ExecuteI ";
        s9_JAL: monitor_state = "s9_JAL"; 
        s10_BEQ:  monitor_state = "s10_BEQ ";
        s11_UNKONW: monitor_state = "s11_UNKONW";
        default:monitor_state = "s11_UNKONW";
    endcase
end
    
    // initialize test
    initial 
     begin
         reset <= 1; # 150; reset <= 0;
     end
    // generate clock to sequence tests
    always
    begin
        clk <= 1; # 5; clk <= 0; # 5;
    end
    // check results
//    always @(negedge clk)
//   begin
//        if(MemWrite) begin
//           if(DataAdr == 100 & WriteData == 25) begin
//              $display("Simulation succeeded");
//              $stop;
//           end
//        end
//   end
    always @(negedge clk)
   begin
        if(MemWrite) begin
           if(DataAdr == 216 & WriteData == 4140) begin
              $display("Simulation succeeded");
              $stop;
           end
        end
   end
 endmodule
