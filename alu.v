module ALU(Ain, Bin, ALUop, out, N, V, Z);
  input [15:0] Ain, Bin;
  input [1:0] ALUop;
  output reg [15:0] out;
  output N, Z;
  output reg V;

  assign N = out[15];    // assignment for negative flag
  assign Z = (out == 0); // assignment for zero flag
  
  // combinational always block for setting out and overflow flag
  always @(*) begin
    // case for out based on Ain, Bin, and ALUop
    case (ALUop)
      2'b00: out = Ain + Bin; 
      2'b01: out = Ain - Bin;
      2'b10: out = Ain & Bin;
      2'b11: out = ~Bin;
      default: out = {16{1'bx}};
    endcase

    // case for overflow flag based on Ain and Bin
    case (ALUop)
      2'b00: V = (Ain[15] == Bin[15]) & (out[15] != Ain[15]);
      2'b01: V = (Ain[15] != Bin[15]) & (out[15] != Ain[15]);
      2'b10: V = 1'b0;
      2'b11: V = 1'b0;
      default: V = 1'bx;
    endcase
  end
endmodule
