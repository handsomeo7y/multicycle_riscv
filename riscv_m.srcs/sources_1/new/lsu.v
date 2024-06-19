`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/18 15:15:59
// Design Name: 
// Module Name: lsu
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


// Load/store Unit (lsu) added for lbu 
module lsu(
    input       [2:0]       funct3,  
    output  reg             LoadType, 
    output  reg             StoreType
    ); 
always@(*)begin
    case(funct3) 
      3'b000:     {LoadType, StoreType} = 2'b01; 
      3'b010:     {LoadType, StoreType} = 2'b00; 
      3'b100:     {LoadType, StoreType} = 2'b10; // ����Ӧ����2'b1x ��Ϊcase������ò�����x �ĳ�10
      default:    {LoadType, StoreType} = 2'b00; // ����Ӧ����2'bxx
    endcase
end 
endmodule 
