module instructionDecoder(in, nsel, opcode, op, sh_op, sximm5, sximm8, readnum, writenum);
  input [15:0] in;
  input [2:0] nsel;
  output [2:0] opcode;
  output [1:0] op, sh_op;
  output [15:0] sximm5, sximm8;
  output [2:0] readnum, writenum;

  wire [2:0] Rout, Rn, Rd, Rm;

  assign opcode = in[15:13]; // extract opcode from in
  assign op = in[12:11];     // extract op from in

  assign sh_op = in[4:3]; // extract shift op from in

  assign Rn = in[10:8]; // extract Rn from in
  assign Rd = in[7:5];  // extract Rd from in
  assign Rm = in[2:0];  // extract Rm from in

  assign sximm5 = {{11{in[4]}}, in[4:0]}; // 5-bit sign extension
  assign sximm8 = {{8{in[7]}}, in[7:0]};  // 8-bit sign extension

  Mux3 #(3) REG_SEL(Rm, Rd, Rn, nsel, Rout); // mux for selecting register based on nsel

  assign readnum = Rout;  // tie readnum to output of register select mux
  assign writenum = Rout; // tie writenum to output of register select mux
endmodule
