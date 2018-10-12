`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:13:05 10/12/2018 
// Design Name: 
// Module Name:    Four_Bit_Adder_Dataflow 
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
module Four_Bit_Adder_Dataflow(
    input [3:0] A,
    input [3:0] B,
    output [3:0] Result,
    output Carry
    );
	 
	// wire n0, n1, n2;
	// wire Result[0], Result[1], Result[2], Result[3], Carry;
	 
	 assign {Carry, Result} = A + B;
	 
	// assign {n0, Result[0]} = A[0] + B[0] + 1'b0;
	// assign {n1, Result[1]} = A[1] + B[1] + n0;
	// assign {n2, Result[2]} = A[2] + B[2] + n1;
	// assign {Carry, Result[3]} = A[3] + B[3] + n2;
	 
	 


endmodule
