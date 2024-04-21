`define SW     5
`define RST    5'd0   // Reset state 
`define IF1    5'd1   // First half of instruction fetch, send read signal
`define IF2    5'd2   // Second half of instruction fetch, hold read signal and load instruction
`define UPDPC  5'd3   // Update program counter
`define DECODE 5'd4   // Decode instruction state
`define ITORN  5'd5   // Move immediate Sximm8 to Rn
`define RMTOB  5'd6   // Move value of register to datapath register b
`define BTOC   5'd7   // Move value of datapath register b to register c through ALU
`define CTORD  5'd8   // Save value of datapath out result register C to Rd
`define RNTOA  5'd9   // Save value of datapath register to datapath register a
`define ABTOC  5'd10  // Update result register c based on register a,b in datapath
`define ABTOS  5'd11  // Update status register based on values in reg a, b in datapath
`define AITOC  5'd12  // Add register A and sximm5 and store in register C
`define CTOADR 5'd13  // Move register C to address register
`define READ   5'd14  // Send read signal to memory
`define MEMRD  5'd15  // Hold read signal and store contents of memory to Rd
`define AICRDB 5'd16  // Add register A and sximm5 and store in register C, and then move Rd to register B
`define BCADR  5'd17  // Move register C to address register, and then move register B to register C
`define WRITE  5'd18  // Send write signal to memory
`define STOP   5'd19  // Stop state, after halt

`define MOVI   5'b11010
`define MOV    5'b11000
`define ADD    5'b10100
`define CMP    5'b10101
`define AND    5'b10110
`define MVN    5'b10111
`define LDR    5'b01100
`define STR    5'b10000
`define HALT   5'b11100

`define MNONE  2'd0
`define MREAD  2'd1
`define MWRITE 2'd2

module stateMachine(opcode, op, sh_op, reset, clk, nsel, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, write, reset_pc, load_pc, mem_cmd, addr_sel, load_addr, load_ir);
  input [2:0] opcode;
  input [1:0] op, sh_op;
  input reset, clk;

  output loada, loadb, asel, bsel, loadc, loads, write, reset_pc, load_pc, addr_sel, load_addr, load_ir;
  output [2:0] nsel;
  output [3:0] vsel;
  output [1:0] shift, ALUop, mem_cmd;

  reg [`SW-1:0] next;
  reg [24:0] out;
  wire [`SW-1:0] state, next_reset;

  assign next_reset = reset ? `RST : next; // return to reset state if reset is asserted
  assign {nsel, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, write, reset_pc, load_pc, mem_cmd, addr_sel, load_addr, load_ir} = out; // tie outputs together

  vDFF #(`SW) STATE(clk, next_reset, state); // vDFF for next state

  // combinational always block for states and outputs
  always @(*) begin
    // casex for next state based on current state, opcode, and op
    casex({state, opcode, op})
      {`RST, {5{1'bx}}},
      {`ITORN, {5{1'bx}}},
      {`CTORD, {5{1'bx}}},
      {`ABTOS, {5{1'bx}}},
      {`MEMRD, {5{1'bx}}},
      {`WRITE, {5{1'bx}}}:  next = `IF1;    //Return to instruction fetch after instruction is done or after reset
      {`IF1, {5{1'bx}}}:    next = `IF2;    //Move to second half of instruction fetch after first half
      {`IF2, {5{1'bx}}}:    next = `UPDPC;  //After fetching instructions, update PC
      {`UPDPC, {5{1'bx}}}:  next = `DECODE; //After updating PC, decode
      {`DECODE, `MOVI}:     next = `ITORN;  //After decoding, move to Immediate to Rn state if instruction is MOV immediate.
      {`DECODE, `MOV},
      {`DECODE, `ADD},
      {`DECODE, `CMP},
      {`DECODE, `AND},
      {`DECODE, `MVN}:      next = `RMTOB;  //After decoding, move to load Register value to register b if instruction is
                                            //MOV, ADD, CMP, AND, or MVN.
      {`RMTOB, `MOV},
      {`RMTOB, `MVN}:       next = `BTOC;   //After moving Rm to register B, move register B through ALU to register C
      {`BTOC, {5{1'bx}}},
      {`ABTOC, {5{1'bx}}}:  next = `CTORD;  //After storing to register C, move register C to Rd
      {`RMTOB, `ADD},
      {`RMTOB, `CMP},
      {`RMTOB, `AND},
      {`DECODE, `LDR},
      {`DECODE, `STR}:      next = `RNTOA;  //For LDR and STR, move Rn to register A after decode
      {`RNTOA, `ADD},
      {`RNTOA, `AND}:       next = `ABTOC;  //For binary operations ADD and AND, after storing to registers A and B, calculate
                                            //and store in register C.
      {`RNTOA, `CMP}:       next = `ABTOS;  //For CMP, after storing to registers A and B, subtract and store flags in status register
      {`RNTOA, `LDR}:       next = `AITOC;  //For LDR, after storing to register A, calculate address and store in register C
      {`AITOC, {5{1'bx}}}:  next = `CTOADR; //After new address is stored in register C, move to address register
      {`CTOADR, {5{1'bx}}}: next = `READ;   //After moving to address register, send read signal
      {`READ, {5{1'bx}}}:   next = `MEMRD;  //Read memory after sending read signal
      {`RNTOA, `STR}:       next = `AICRDB; //For STR, after storing to register A, calculate and store address in register C while
                                            //moving Rd to register B
      {`AICRDB, {5{1'bx}}}: next = `BCADR;  //Then move register C to address register while moving register B to register C
      {`BCADR, {5{1'bx}}}:  next = `WRITE;  //Send write signal afterwards
      {`DECODE, `HALT},
      {`STOP, {5{1'bx}}}:   next = `STOP;   //Move to STOP state if HALT is received, or stay in STOP state if already there
      default:              next = `STOP;
    endcase

    // case for output based on state
    // description for each action is in define section above
    case(state)
      `RST:    out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, `MNONE,  1'b0, 1'b0, 1'b0};
      `IF1:    out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MREAD,  1'b1, 1'b0, 1'b0};
      `IF2:    out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MREAD,  1'b1, 1'b0, 1'b1};
      `UPDPC:  out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, `MNONE,  1'b0, 1'b0, 1'b0};
      `DECODE: out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      `ITORN:  out = {3'b001, 4'b0100, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      `RMTOB:  out = {3'b100, 4'b0001, 1'b0, 1'b1, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      `RNTOA:  out = {3'b001, 4'b0001, 1'b1, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      `BTOC:   out = {3'b001, 4'b0001, 1'b0, 1'b0, sh_op, 1'b1, 1'b0, op,    1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      `ABTOC:  out = {3'b001, 4'b0001, 1'b0, 1'b0, sh_op, 1'b0, 1'b0, op,    1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      `ABTOS:  out = {3'b001, 4'b0001, 1'b0, 1'b0, sh_op, 1'b0, 1'b0, op,    1'b0, 1'b1, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      `CTORD:  out = {3'b010, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      `AITOC:  out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b1, 2'b00, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      `CTOADR: out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b1, 1'b0};
      `READ:   out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MREAD,  1'b0, 1'b0, 1'b0};
      `MEMRD:  out = {3'b010, 4'b1000, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, `MREAD,  1'b0, 1'b0, 1'b0};
      `AICRDB: out = {3'b010, 4'b0001, 1'b0, 1'b1, 2'b00, 1'b0, 1'b1, 2'b00, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      `BCADR:  out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b1, 1'b0, 2'b00, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b1, 1'b0};
      `WRITE:  out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MWRITE, 1'b0, 1'b0, 1'b0};
      `STOP:   out = {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0};
      default: out = {19{1'bx}};
    endcase
  end
endmodule
