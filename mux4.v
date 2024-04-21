// adapted from textbook, page 157
module Mux4(in3, in2, in1, in0, select, out);
  parameter n = 1; // width

	input [n-1:0] in3, in2, in1, in0;
	input [3:0] select;
	output reg [n-1:0] out;

	// combinational always block for selecting input based on select
	always @(*) begin
		case (select)
			4'b0001: out = in0;
			4'b0010: out = in1;
			4'b0100: out = in2;
			4'b1000: out = in3;
			default: out = {n{1'bx}};
		endcase
	end
endmodule


