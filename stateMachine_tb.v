`define SW     5
`define RST    5'd0
`define IF1    5'd1
`define IF2    5'd2
`define UPDPC  5'd3
`define DECODE 5'd4
`define ITORN  5'd5
`define RMTOB  5'd6
`define BTOC   5'd7
`define CTORD  5'd8
`define RNTOA  5'd9
`define ABTOC  5'd10
`define ABTOS  5'd11
`define AITOC  5'd12
`define CTOADR 5'd13
`define READ   5'd14
`define MEMRD  5'd15
`define AICRDB 5'd16
`define BCADR  5'd17
`define WRITE  5'd18
`define STOP   5'd19

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

`define RST_OUT    {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, `MNONE,  1'b0, 1'b0, 1'b0}
`define IF1_OUT    {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MREAD,  1'b1, 1'b0, 1'b0}
`define IF2_OUT    {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MREAD,  1'b1, 1'b0, 1'b1}
`define UPDPC_OUT  {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, `MNONE,  1'b0, 1'b0, 1'b0}
`define DECODE_OUT {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}
`define ITORN_OUT  {3'b001, 4'b0100, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}
`define RMTOB_OUT  {3'b100, 4'b0001, 1'b0, 1'b1, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}
`define RNTOA_OUT  {3'b001, 4'b0001, 1'b1, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}
`define BTOC_OUT   {3'b001, 4'b0001, 1'b0, 1'b0, sh_op, 1'b1, 1'b0, op,    1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}
`define ABTOC_OUT  {3'b001, 4'b0001, 1'b0, 1'b0, sh_op, 1'b0, 1'b0, op,    1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}
`define ABTOS_OUT  {3'b001, 4'b0001, 1'b0, 1'b0, sh_op, 1'b0, 1'b0, op,    1'b0, 1'b1, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}
`define CTORD_OUT  {3'b010, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}
`define AITOC_OUT  {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b1, 2'b00, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}
`define CTOADR_OUT {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b1, 1'b0}
`define READ_OUT   {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MREAD,  1'b0, 1'b0, 1'b0}
`define MEMRD_OUT  {3'b010, 4'b1000, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, `MREAD,  1'b0, 1'b0, 1'b0}
`define AICRDB_OUT {3'b010, 4'b0001, 1'b0, 1'b1, 2'b00, 1'b0, 1'b1, 2'b00, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}
`define BCADR_OUT  {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b1, 1'b0, 2'b00, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b1, 1'b0}
`define WRITE_OUT  {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MWRITE, 1'b0, 1'b0, 1'b0}
`define STOP_OUT   {3'b001, 4'b0001, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `MNONE,  1'b0, 1'b0, 1'b0}

module stateMachine_tb;
  reg [1:0] sh_op;
  reg reset, clk, err, start_clk;
  reg [4:0] in;

  wire loada, loadb, asel, bsel, loadc, loads, write, reset_pc, load_pc, addr_sel, load_addr, load_ir;
  wire [2:0] nsel, opcode;
  wire [3:0] vsel;
  wire [1:0] op, shift, ALUop, mem_cmd;

  assign {opcode, op} = in; // tie opcode and op together as one input

  stateMachine DUT(opcode, op, sh_op, reset, clk, nsel, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, write, reset_pc, load_pc, mem_cmd, addr_sel, load_addr, load_ir); // instantiate state machine

  // task for checking outputs
  task check;
    input [`SW-1:0] expected_state;
    input [24:0] expected_out;
    begin
      if (expected_state !== DUT.state) begin
        $display("ERROR ** expected state = %b", expected_state);
        err = 1'b1;
      end
      if (expected_out !== {nsel, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, write, reset_pc, load_pc, mem_cmd, addr_sel, load_addr, load_ir}) begin
        $display("ERROR ** expected nsel = %b, vsel = %b, loada = %b, loadb = %b, shift = %b, asel = %b, bsel = %b, ALUop = %b, loadc = %b, loads = %b, write = %b, reset_pc = %b, load_pc = %b, mem_cmd = %b, addr_sel = %b, load_addr = %b, load_ir = %b", expected_out[24:22], expected_out[21:18], expected_out[17], expected_out[16], expected_out[15:14], expected_out[13], expected_out[12], expected_out[11:10], expected_out[9], expected_out[8], expected_out[7], expected_out[6], expected_out[4], expected_out[4:3], expected_out[2], expected_out[1], expected_out[0]);
        err = 1'b1;
      end
      if (err) begin
        $stop;
      end
    end
  endtask

  // show outputs whenever they change
  always @(*) begin
    $display("opcode = %b, op = %b, sh_op = %b, reset = %b, clk = %b, err = %b, nsel = %b, vsel = %b, loada = %b, loadb = %b, shift = %b, asel = %b, bsel = %b, ALUop = %b, loadc = %b, loads = %b, write = %b, reset_pc = %b, load_pc = %b, mem_cmd = %b, addr_sel = %b, load_addr = %b, load_ir = %b, state = %b", opcode, op, sh_op, reset, clk, err, nsel, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, write, reset_pc, load_pc, mem_cmd, addr_sel, load_addr, load_ir, DUT.state);
  end

  // 10-tick clock cycle, triggered by start_clk
  always @(start_clk) begin
    while (start_clk) begin
      clk = 1'b0; #5;
      clk = 1'b1; #5;
    end
  end

  // expected outputs given by call to check()
  // only testing valid opcodes and ops
  // only holding same opcode and op until returning to wait state
  initial begin
    // initialize values
    in = 5'b0;
    sh_op = 2'b0;
    clk = 1'b0;
    err = 1'b0;

    // start clock
    start_clk = 1'b1;

    // reset for one cycle
    $display("try reset");
    $display("RST");
    reset = 1'b1;
    #10;
    reset = 1'b0;
    check(`RST, `RST_OUT);

    // wait one cycle, move to IF1
    $display("IF1");
    #10;
    check(`IF1, `IF1_OUT);

    // try MOV immediate, expect IF1->IF2->UPDPC->DECODE->ITORN->IF1
    $display("try MOV immediate");
    in = `MOVI;
    #10;
    $display("IF2");
    check(`IF2, `IF2_OUT);
    #10;
    $display("UPDPC");
    check(`UPDPC, `UPDPC_OUT);
    #10;
    $display("DECODE");
    check(`DECODE, `DECODE_OUT);
    #10;
    $display("ITORN");
    check(`ITORN, `ITORN_OUT);
    #10;
    $display("IF1");
    check(`IF1, `IF1_OUT);

    // try MOV, expect IF1->IF2->UPDPC->DECODE->RMTOB->BTOC->CTORD->IF1
    $display("try MOV");
    in = `MOV;
    #10;
    $display("IF2");
    check(`IF2, `IF2_OUT);
    #10;
    $display("UPDPC");
    check(`UPDPC, `UPDPC_OUT);
    #10;
    $display("DECODE");
    check(`DECODE, `DECODE_OUT);
    #10;
    $display("RMTOB");
    check(`RMTOB, `RMTOB_OUT);
    #10;
    $display("BTOC, try shift ops");
    // stop clock, try all shift ops
    start_clk = 1'b0;
    sh_op = 2'b00;
    #10;
    check(`BTOC, `BTOC_OUT);
    sh_op = 2'b01;
    #10;
    check(`BTOC, `BTOC_OUT);
    sh_op = 2'b10;
    #10;
    check(`BTOC, `BTOC_OUT);
    sh_op = 2'b11;
    #10;
    check(`BTOC, `BTOC_OUT);
    // start clock again
    start_clk = 1'b1;
    #10;
    $display("CTORD");
    check(`CTORD, `CTORD_OUT);
    #10;
    $display("IF1");
    check(`IF1, `IF1_OUT);

    // try ADD, expect IF1->IF2->UPDPC->DECODE->RMTOB->RNTOA->ABTOC->CTORD->IF1
    $display("try ADD");
    in = `ADD;
    #10;
    $display("IF2");
    check(`IF2, `IF2_OUT);
    #10;
    $display("UPDPC");
    check(`UPDPC, `UPDPC_OUT);
    #10;
    $display("DECODE");
    check(`DECODE, `DECODE_OUT);
    #10;
    $display("RMTOB");
    check(`RMTOB, `RMTOB_OUT);
    #10;
    $display("RNTOA");
    check(`RNTOA, `RNTOA_OUT);
    #10;
    $display("ABTOC, try shift ops");
    // stop clock, try all shift ops
    start_clk = 1'b0;
    sh_op = 2'b00;
    #10;
    check(`ABTOC, `ABTOC_OUT);
    sh_op = 2'b01;
    #10;
    check(`ABTOC, `ABTOC_OUT);
    sh_op = 2'b10;
    #10;
    check(`ABTOC, `ABTOC_OUT);
    sh_op = 2'b11;
    #10;
    check(`ABTOC, `ABTOC_OUT);
    // start clock again
    start_clk = 1'b1;
    #10;
    $display("CTORD");
    check(`CTORD, `CTORD_OUT);
    #10;
    $display("IF1");
    check(`IF1, `IF1_OUT);

    // try CMP, expect IF1->IF2->UPDPC->DECODE->RMTOB->RNTOA->ABTOS->IF1
    $display("try CMP");
    in = `CMP;
    #10;
    $display("IF2");
    check(`IF2, `IF2_OUT);
    #10;
    $display("UPDPC");
    check(`UPDPC, `UPDPC_OUT);
    #10;
    $display("DECODE");
    check(`DECODE, `DECODE_OUT);
    #10;
    $display("RMTOB");
    check(`RMTOB, `RMTOB_OUT);
    #10;
    $display("RNTOA");
    check(`RNTOA, `RNTOA_OUT);
    #10;
    $display("ABTOS, try shift ops");
    // stop clock, try all shift ops
    start_clk = 1'b0;
    sh_op = 2'b00;
    #10;
    check(`ABTOS, `ABTOS_OUT);
    sh_op = 2'b01;
    #10;
    check(`ABTOS, `ABTOS_OUT);
    sh_op = 2'b10;
    #10;
    check(`ABTOS, `ABTOS_OUT);
    sh_op = 2'b11;
    #10;
    check(`ABTOS, `ABTOS_OUT);
    // start clock again
    start_clk = 1'b1;
    #10;
    $display("IF1");
    check(`IF1, `IF1_OUT);

    // try AND, expect IF1->IF2->UPDPC->DECODE->RMTOB->RNTOA->ABTOC->CTORD->IF1
    $display("try AND");
    in = `AND;
    #10;
    $display("IF2");
    check(`IF2, `IF2_OUT);
    #10;
    $display("UPDPC");
    check(`UPDPC, `UPDPC_OUT);
    #10;
    $display("DECODE");
    check(`DECODE, `DECODE_OUT);
    #10;
    $display("RMTOB");
    check(`RMTOB, `RMTOB_OUT);
    #10;
    $display("RNTOA");
    check(`RNTOA, `RNTOA_OUT);
    #10;
    $display("ABTOC, try shift ops");
    // stop clock, try all shift ops
    start_clk = 1'b0;
    sh_op = 2'b00;
    #10;
    check(`ABTOC, `ABTOC_OUT);
    sh_op = 2'b01;
    #10;
    check(`ABTOC, `ABTOC_OUT);
    sh_op = 2'b10;
    #10;
    check(`ABTOC, `ABTOC_OUT);
    sh_op = 2'b11;
    #10;
    check(`ABTOC, `ABTOC_OUT);
    // start clock again
    start_clk = 1'b1;
    #10;
    $display("CTORD");
    check(`CTORD, `CTORD_OUT);
    #10;
    $display("IF1");
    check(`IF1, `IF1_OUT);

    // try MVN, expect IF1->IF2->UPDPC->DECODE->RMTOB->BTOC->CTORD->IF1
    $display("try MVN");
    in = `MVN;
    #10;
    $display("IF2");
    check(`IF2, `IF2_OUT);
    #10;
    $display("UPDPC");
    check(`UPDPC, `UPDPC_OUT);
    #10;
    $display("DECODE");
    check(`DECODE, `DECODE_OUT);
    #10;
    $display("RMTOB");
    check(`RMTOB, `RMTOB_OUT);
    #10;
    $display("BTOC, try shift ops");
    // stop clock, try all shift ops
    start_clk = 1'b0;
    sh_op = 2'b00;
    #10;
    check(`BTOC, `BTOC_OUT);
    sh_op = 2'b01;
    #10;
    check(`BTOC, `BTOC_OUT);
    sh_op = 2'b10;
    #10;
    check(`BTOC, `BTOC_OUT);
    sh_op = 2'b11;
    #10;
    check(`BTOC, `BTOC_OUT);
    // start clock again
    start_clk = 1'b1;
    #10;
    $display("CTORD");
    check(`CTORD, `CTORD_OUT);
    #10;
    $display("IF1");
    check(`IF1, `IF1_OUT);

    // try LDR, expect IF1->IF2->UPDPC->DECODE->RNTOA->AITOC->CTOADR->READ->MEMRD->IF1
    $display("try LDR");
    in = `LDR;
    #10;
    $display("IF2");
    check(`IF2, `IF2_OUT);
    #10;
    $display("UPDPC");
    check(`UPDPC, `UPDPC_OUT);
    #10;
    $display("DECODE");
    check(`DECODE, `DECODE_OUT);
    #10;
    $display("RNTOA");
    check(`RNTOA, `RNTOA_OUT);
    #10;
    $display("AITOC");
    check(`AITOC, `AITOC_OUT);
    #10;
    $display("CTOADR");
    check(`CTOADR, `CTOADR_OUT);
    #10;
    $display("READ");
    check(`READ, `READ_OUT);
    #10;
    $display("MEMRD");
    check(`MEMRD, `MEMRD_OUT);
    #10;
    $display("IF1");
    check(`IF1, `IF1_OUT);

    // try STR, expect IF1->IF2->UPDPC->DECODE->RNTOA->AICRDB->BCADR->WRITE->IF1
    $display("try STR");
    in = `STR;
    #10;
    $display("IF2");
    check(`IF2, `IF2_OUT);
    #10;
    $display("UPDPC");
    check(`UPDPC, `UPDPC_OUT);
    #10;
    $display("DECODE");
    check(`DECODE, `DECODE_OUT);
    #10;
    $display("RNTOA");
    check(`RNTOA, `RNTOA_OUT);
    #10;
    $display("AICRDB");
    check(`AICRDB, `AICRDB_OUT);
    #10;
    $display("BCADR");
    check(`BCADR, `BCADR_OUT);
    #10;
    $display("WRITE");
    check(`WRITE, `WRITE_OUT);
    #10;
    $display("IF1");
    check(`IF1, `IF1_OUT);

    // try HALT, expect IF1->IF2->UPDPC->DECODE->STOP->STOP->...
    $display("try HALT");
    in = `HALT;
    #10;
    $display("IF2");
    check(`IF2, `IF2_OUT);
    #10;
    $display("UPDPC");
    check(`UPDPC, `UPDPC_OUT);
    #10;
    $display("DECODE");
    check(`DECODE, `DECODE_OUT);
    #10;
    $display("STOP");
    check(`STOP, `STOP_OUT);
    #10;
    $display("STOP");
    check(`STOP, `STOP_OUT);
    #10;
    $display("STOP");
    check(`STOP, `STOP_OUT);
    #10;

    // try resetting from HALT
    $display("try reset");
    $display("RST");
    reset = 1'b1;
    #10;
    reset = 1'b0;
    check(`RST, `RST_OUT);


    // print pass/fail
    if (~err) $display("PASSED");
    else $display("FAILED");
    $stop;
  end
endmodule
