// adapted from textbook, page 157
module Mux8(in7, in6, in5, in4, in3, in2, in1, in0, select, out);
  parameter n = 1; // width

	input [n-1:0] in7, in6, in5, in4, in3, in2, in1, in0;
	input [7:0] select;
	output reg [n-1:0] out;

	// combinational always block for selecting input based on select
	always @(*) begin
		case (select)
			8'b00000001: out = in0;
			8'b00000010: out = in1;
			8'b00000100: out = in2;
			8'b00001000: out = in3;
			8'b00010000: out = in4;
			8'b00100000: out = in5;
			8'b01000000: out = in6;
			8'b10000000: out = in7;
			default: out = {n{1'bx}};
		endcase
	end
endmodule


