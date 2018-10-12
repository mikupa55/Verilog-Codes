`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:28:31 10/12/2018 
// Design Name: 
// Module Name:    Seven_Segment_DataFlow 
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
module Seven_Segment_DataFlow(
    input [3:0] S,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG
    );
	 
	 assign CA = !((S == 4'h0) | (S == 4'h2) | (S == 4'h3) | (S == 4'h5) | (S == 4'h6) | (S == 4'h7) | (S == 4'h8) | (S == 4'h9) | (S == 4'hA) | (S == 4'hC) | (S == 4'hE) | (S == 4'hF));
	 assign CB = !((S == 4'h0) | (S == 4'h1) | (S == 4'h2) | (S == 4'h3) | (S == 4'h4) | (S == 4'h7) | (S == 4'h8) | (S == 4'h9) | (S == 4'hA) | (S == 4'hD));
	 assign CC = !((S == 4'h0) | (S == 4'h1) | (S == 4'h3) | (S == 4'h4) | (S == 4'h5) | (S == 4'h6) | (S == 4'h7) | (S == 4'h8) | (S == 4'h9) | (S == 4'hA) | (S == 4'hB) | (S == 4'hD));
	 assign CD = !((S == 4'h0) | (S == 4'h2) | (S == 4'h3) | (S == 4'h5) | (S == 4'h6) | (S == 4'h8) | (S == 4'h9) | (S == 4'hB) | (S == 4'hC) | (S == 4'hD) | (S == 4'hE));
	 assign CE = !((S == 4'h0) | (S == 4'h2) | (S == 4'h6) | (S == 4'h8) | (S == 4'hA) | (S == 4'hB) | (S == 4'hC) | (S == 4'hD) | (S == 4'hE) | (S == 4'hF));
	 assign CF = !((S == 4'h0) | (S == 4'h4) | (S == 4'h5) | (S == 4'h6) | (S == 4'h8) | (S == 4'h9) | (S == 4'hA) | (S == 4'hB) | (S == 4'hC) | (S == 4'hE) | (S == 4'hF));
	 assign CG = !((S == 4'h2) | (S == 4'h3) | (S == 4'h4) | (S == 4'h5) | (S == 4'h6) | (S == 4'h8) | (S == 4'h9) | (S == 4'hA) | (S == 4'hB) | (S == 4'hD) | (S == 4'hE) | (S == 4'hF));

endmodule
