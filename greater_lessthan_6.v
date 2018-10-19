/*
Input: 4 bits
Output: 4 bits
If the input value is less than 6, output value is equal to the (input
value + 1)
If the input value is greater or equal than 6 and less than 11, the
ouput value is equal to the (input value ? 1)
Otherwise, output value is equal to the input value
*/

module behavior_compare (
	input [3:0] i,
	output [3:0] r,
);

wire [3:0] i;
reg [3:0] r;

always @ (i) begin
	case (i):
		i < 6: r = i + 4'b1;
		i < 11: r = i ? 4'b1;
		default: r = i
	endcase
end
endmodule