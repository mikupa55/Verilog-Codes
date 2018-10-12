`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:26:06 10/12/2018 
// Design Name: 
// Module Name:    Gate_Level_One_Bit_Adder 
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
module Gate_Level_One_Bit_Adder(
    input A,
    input B,
    input Cin,
    output Cout,
    output Result
    );
	 
	 // Computing result digit
	 xor xor0(Result, A, B, Cin);
	 
	 
	 // Computing Carry digit out
	 wire n0, n1, n2;
	 and and0(n0, B, Cin);
	 and and1(n1, A, Cin);
	 and and2(n2, A, B);
	 
	 or or0(Cout, n0, n1, n2);




endmodule
