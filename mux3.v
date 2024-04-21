// adapted from textbook, page 157
module Mux3(in2, in1, in0, select, out);
  parameter n = 1; // width

	input [n-1:0] in2, in1, in0;
	input [2:0] select;
	output reg [n-1:0] out;

	// combinational always block for selecting input based on select
	always @(*) begin
		case (select)
			3'b001: out = in0;
			3'b010: out = in1;
			3'b100: out = in2;
			default: out = {n{1'bx}};
		endcase
	end
endmodule

