module regfile(data_in, writenum, write, readnum, clk, data_out);
  input [15:0] data_in;
  input [2:0] writenum, readnum;
  input write, clk;
  output [15:0] data_out; 

  wire [7:0] write_onehot, read_onehot;
  wire [7:0] enable;
  
  wire [15:0] R7, R6, R5, R4, R3, R2, R1, R0;
  
  // enable should equal decoded writenum when write is 1, and all 0's when write is 0
  assign enable = {8{write}} & write_onehot; 

  Dec #(3,8) DEC_WRITE(writenum, write_onehot); // decoder for writenum
  Dec #(3,8) DEC_READ(readnum, read_onehot);    // decoder for readnum

  vDFFE #(16) REG0(clk, enable[0], data_in, R0);  //Flip flop for r0
  vDFFE #(16) REG1(clk, enable[1], data_in, R1);  //Flip flop for r1
  vDFFE #(16) REG2(clk, enable[2], data_in, R2);  //Flip flop for r2
  vDFFE #(16) REG3(clk, enable[3], data_in, R3);  //Flip flop for r3
  vDFFE #(16) REG4(clk, enable[4], data_in, R4);  //Flip flop for r4
  vDFFE #(16) REG5(clk, enable[5], data_in, R5);  //Flip flop for r5
  vDFFE #(16) REG6(clk, enable[6], data_in, R6);  //Flip flop for r6
  vDFFE #(16) REG7(clk, enable[7], data_in, R7);  //Flip flop for r7

  Mux8 #(16) MUX_DATA(R7, R6, R5, R4, R3, R2, R1, R0, read_onehot, data_out);   //Mux to select output/read from read_onehot
endmodule
