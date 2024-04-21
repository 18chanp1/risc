module Mux2b(a1, a0, s, b);
  parameter n = 1; // width

  input [n-1:0] a1, a0;
  input s;
  output reg [n-1:0] b;

  // always block for choosing output based on select
  always @(*) begin
    case (s)
      1'b0: b = a0;
      1'b1: b = a1;
      default: b = {n{1'bx}};
    endcase
  end
endmodule