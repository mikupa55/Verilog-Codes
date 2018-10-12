`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:46:23 10/12/2018 
// Design Name: 
// Module Name:    Four_Bit_Adder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Four_Bit_Adder(
    input [3:0] A,
    input [3:0] B,
    output [3:0] Result,
    output C
    );
	 
	 
	 wire n0, n1, n2;
	 Gate_Level_One_Bit_Adder fa0(A[0], B[0], 1'b0, n0, Result[0]);
	 Gate_Level_One_Bit_Adder fa1(A[1], B[1], n0, n1, Result[1]);
	 Gate_Level_One_Bit_Adder fa2(A[2], B[2], n1, n2, Result[2]);
	 Gate_Level_One_Bit_Adder fa3(A[3], B[3], n2, C, Result[3]);


endmodule
