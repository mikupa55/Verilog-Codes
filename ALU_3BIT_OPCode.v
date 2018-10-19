`timescale 1ns / 1ps
// Simple ALU using Verilog
/*
Opcode includes:
000:  A + B
001:	A * B
010:	A << B
011:	B << A
100:	A >> B
101:	B >> A
110:	3 * A + B
111:	Grey code for A
*/
module ALU_3BIT_OPCode(
    input [3:0] A,
    input [3:0] B,
    input [2:0] OPCode,
    output [5:0] Out,
    output Overflow,
    output Z1
    );


reg [5:0] Out;
reg Overflow;
reg Z1;
integer i;


always @ (A, B, OPCode) begin
	case (OPCode)
	0: begin
			Out = A + B; 
			Overflow = 1'b0; 
			if (Out == 1'b0) Z1 = 1'b1;
			else Z1 = 1'b0;
		end
	1: begin 
			Out = A * B;
			
			if (Out > 63) Overflow = 1'b1;
			else Overflow = 1'b0;
			
			if (Out == 1'b0) Z1 = 1'b1;
			else Z1 = 1'b0;
		end
	2: begin
			Out = A << B;
			if (A << B > 63) Overflow = 1'b1;
			else Overflow = 1'b0;
			
			if (Out == 1'b0) Z1 = 1'b1;
			else Z1 = 1'b0;
	
		end
	3: begin
			Out = B << A;
			if (B << A > 63) Overflow = 1'b1;
			else Overflow = 1'b0;
			
			if (Out == 1'b0) Z1 = 1'b1;
			else Z1 = 1'b0;
	
		end
	4: begin
			Out = A >> B;
			Overflow = 0;
			if (Out == 1'b0) Z1 = 1'b1;
			else Z1 = 1'b0;
		end
	5: begin
			Out = B << A;
			Overflow = 0;
			if (Out == 1'b0) Z1 = 1'b1;
			else Z1 = 1'b0;
		end
	6: begin
			{Overflow, Out} = 3 * A + B;
			
			
			if (Out == 1'b0) Z1 = 1'b1;
			else Z1 = 1'b0;
		end
	7: begin
			for (i = 0; i < 3; i = i + 1)
				Out[i] = A[i] ^ A[i + 1];
			Out[3] = A[3];
			Out[4] = 0;
			Out[5] = 0;
			Overflow = 0;
			Z1 = 0;
		end
	
	default: begin
			Z1 = 0;
			Overflow = 0;
			Out = 0;
		end
	endcase
end

endmodule
