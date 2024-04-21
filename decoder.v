// from textbook, page 152
module Dec(a, b);
  parameter n = 2; // width of input
  parameter m = 4; // width of output

  input  [n-1:0] a; //input
  output [m-1:0] b; //output

  assign b = 1'b1 << a; // assign output
endmodule