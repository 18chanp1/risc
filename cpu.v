module cpu(clk, reset, in, N, V, Z, mem_cmd, mem_addr, read_data, write_data);
  input clk, reset;
  input [15:0] in;
  input [15:0] read_data;
  output [15:0] write_data;
  output [1:0] mem_cmd;
  output [8:0] mem_addr;
  output N, V, Z;

  wire [15:0] regToDec;

  wire [2:0] nsel;
  wire [2:0] opcode;
  wire [1:0] op;
  wire [15:0] sximm5, sximm8;
  wire [2:0] readnum, writenum;
  wire [1:0] sh_op;

  wire loada, loadb, asel, bsel, loadc, loads, write;
  wire [3:0] vsel;
  wire [1:0] shift, ALUop;

  wire [15:0] mdata;

  wire load_pc, reset_pc, addr_sel, load_addr, load_ir;
  wire [8:0] next_pc, PC, zero, pc_plusOne, addressRegisterOut;

  assign mdata = read_data;
  
  assign zero = {9{1'b0}};
  assign pc_plusOne = PC + 9'd1;

  //Lab 7 IOs
  
  

  //instantiate instruction register
  vDFFE #(16) instructionReg(clk, load_ir, read_data, regToDec);
  //instantiate instruction decoder
  instructionDecoder theDecoder(regToDec, nsel, opcode, op, sh_op, sximm5, sximm8, readnum, writenum);
  //instantiate instruction state machine
  stateMachine theStateMachine(opcode, op, sh_op, reset, clk, nsel, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, write, reset_pc, load_pc, mem_cmd, addr_sel, load_addr, load_ir);
  //instantiate datapath
  datapath DP(clk, readnum, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, writenum, write, mdata, PC[7:0], sximm5, sximm8, write_data, N, V, Z);

  //PC input logic
  Mux2b #(9) PCinput (zero, pc_plusOne, reset_pc, next_pc);
  
  //Program Counter Logic
  vDFFE #(9) PC_REG(clk, load_pc, next_pc, PC);

  //Next Memory address logic;
  Mux2b #(9) addressSelector (PC, addressRegisterOut, addr_sel, mem_addr);

  //Data Address register
  vDFFE #(9) dataAddress(clk, load_addr, write_data[8:0], addressRegisterOut);


endmodule