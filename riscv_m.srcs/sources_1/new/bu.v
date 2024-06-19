`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/18 15:02:10
// Design Name: 
// Module Name: bu
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


module bu(
    input                   Branch,
    input       [3:0]       Flags,
    input       [2:0]       funct3,
    output                  taken       
    );
//wire define
wire v,c,n,z;       //flags
//ref define
reg cond;           //cond =1 when condition for branch met
assign {v,c,n,z}=Flags;
assign taken = cond & Branch;
always@(*)begin
    case(funct3)
        3'b000:cond = z;        // beq   
        3'b001:cond = ~z;       // bne
        3'b100:cond = n^z;      // blt
        3'b101:cond = ~(n^z);   // bge
        3'b110:cond = ~c;       //bltu
        3'b110:cond = c;        //bgeu
        default: cond = 1'b0;
    endcase
end
   
endmodule
