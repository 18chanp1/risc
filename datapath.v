module datapath(clk, readnum, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, writenum, write, mdata, PC, sximm5, sximm8, datapath_out, N_out, V_out, Z_out);
  input clk, loada, loadb, asel, bsel, loadc, loads, write;
  input [3:0] vsel;
  input [2:0] readnum, writenum;
  input [1:0] shift, ALUop;
  input [15:0] mdata, sximm5, sximm8;
  input [7:0] PC;
  output [15:0] datapath_out;
  output N_out, V_out, Z_out;

  wire [15:0] data_in, data_out, aout, bout, sout, Ain, Bin, out;
  wire N, V, Z;
  
  Mux4 #(16) MUX_V(mdata, sximm8, {8'b0, PC}, datapath_out, vsel, data_in); // writeback mux
  regfile REGFILE(data_in, writenum, write, readnum, clk, data_out); // register file

  vDFFE #(16) A(clk, loada, data_out, aout); // register A
  vDFFE #(16) B(clk, loadb, data_out, bout); // register B
  
  shifter SHIFTER(bout, shift, sout); // shifter unit

  Mux2b #(16) MUX_A(16'b0, aout, asel, Ain); // A select mux
  Mux2b #(16) MUX_B(sximm5, sout, bsel, Bin); // B select mux

  ALU U(Ain, Bin, ALUop, out, N, V, Z); // ALU

  vDFFE #(16) C(clk, loadc, out, datapath_out);  // register C
  vDFFE #(3) STATUS(clk, loads, {N, V, Z}, {N_out, V_out, Z_out}); // status register
endmodule
