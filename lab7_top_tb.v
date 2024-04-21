`define check(actual, expected) \
  if (expected !== actual) begin \
    $display("ERROR ** %s = %b, expected %b", `"actual`", actual, expected); \
    err = 1'b1; \
  end

`define MNONE  2'd0
`define MREAD  2'd1
`define MWRITE 2'd2

module lab7_top_tb;
  reg [3:0] KEY;
  reg [9:0] SW;
  wire [9:0] LEDR;
  wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

  reg err;

  //initialize lab7_top

  lab7_top DUT(KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

  initial forever begin
    KEY[0] = 1'b1; #5;
    KEY[0] = 1'b0; #5;
  end

  initial begin
    //initialize inputs 
    SW = 10'b0;
    err = 1'b0;

    //reset for one cycle
    KEY[1] = 1'b0;
    #10;
    KEY[1] = 1'b1;
    #10;

    //this is the program to be exeDUTed
    /*
    MOV R0, X
    MOV R1, Y
    MOV R2, Z
    LDR R3, [R0]
    LDR R4, [R1]
    ADD R5, R3, R4
    STR R5, [R2]
    HALT
    X: 
    .word 0x0200
    Y: 
    .word 0x0400
    Z:
    .word 0x0000

    */

    //check program counter is initially 0
    `check(DUT.CPU.PC, 9'b0)
    
    //check that PC advances to 1
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
    `check(DUT.CPU.PC, 9'h1)

    //check that PC advances to 2 and address of X(8) is saved to R0
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
    `check(DUT.CPU.PC, 9'h2)
    `check(DUT.CPU.DP.REGFILE.R0, 16'h8)

    //check that PC advances to 3 and address Y (9) is saved to R1
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
    `check(DUT.CPU.PC, 9'h3)
    `check(DUT.CPU.DP.REGFILE.R1, 16'h9)

    //check that PC advances to 4 and address Z (10) is saved 10 R2
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
    `check(DUT.CPU.PC, 9'h4)
    `check(DUT.CPU.DP.REGFILE.R2, 16'hA)

    //check that PC advances to 5 R3 contains value 0x0200
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
    `check(DUT.CPU.PC, 9'h5)
    `check(DUT.CPU.DP.REGFILE.R3, 16'h200)

    //check that PC advances to 6, R4 contains value 0x0400
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
    `check(DUT.CPU.PC, 9'h6)
    `check(DUT.CPU.DP.REGFILE.R4, 16'h400)

    //check that PC advances to 7, R5 contains 0x600 = 0x400 + 0x200
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
    `check(DUT.CPU.PC, 9'h7)
    `check(DUT.CPU.DP.REGFILE.R5, 16'h600)

    //check that PC advances to 8, value of R5 (600) is stored to address 10 in memory.
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
    `check(DUT.CPU.PC, 9'h8)
    `check(DUT.MEM.mem[10], 16'h600)

    //check that PC does not advance
    #100;
    `check(DUT.CPU.PC, 9'h8)

    if(~err) $display("PASSED");
    else $display("FAILED");
    $stop;
  end
endmodule
