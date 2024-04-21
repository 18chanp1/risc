module datapath_tb;
  reg clk, loada, loadb, asel, bsel, loadc, loads, write, err;
  reg [2:0] readnum, writenum;
  reg [3:0] vsel;
  reg [1:0] shift, ALUop;
  reg [15:0] mdata, sximm5, sximm8;
  reg [7:0] PC;
  wire [15:0] datapath_out;
  wire N_out, V_out, Z_out;

  // initialize datapath
  datapath DUT(.clk(clk), 
               .readnum(readnum), 
               .vsel(vsel), 
               .loada(loada), 
               .loadb(loadb), 
               .shift(shift), 
               .asel(asel), 
               .bsel(bsel), 
               .ALUop(ALUop), 
               .loadc(loadc), 
               .loads(loads), 
               .writenum(writenum), 
               .write(write), 
               .mdata(mdata),
               .PC(PC),
               .sximm5(sximm5),
               .sximm8(sximm8),
               .datapath_out(datapath_out),
               .N_out(N_out),
               .V_out(V_out),
               .Z_out(Z_out));

  // task for checking datapath_out and Z_out
  task check;
    input [15:0] expected_out;
    input [2:0] expected_NVZ;
    begin
      if (expected_out !== datapath_out) begin
        $display("ERROR ** expected_out = %b", expected_out);
        err = 1'b1;
      end
      if (expected_NVZ !== {N_out, V_out, Z_out}) begin
        $display("ERROR ** expected_NVZ = %b", expected_NVZ);
        err = 1'b1;
      end
    end
  endtask

  // always block for printing signals when they change
  always @(*) begin
    $display("clk = %b, readnum = %b, vsel = %b, loada = %b, loadb = %b, shift = %b, asel = %b, bsel = %b, ALUop = %b, loadc = %b, loads = %b, writenum = %b, write = %b, ", clk, readnum, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, writenum, write);
    $display("mdata = %b, PC = %b, sximm5 = %b, sximm8 = %b, datapath_out = %b, N_out = %b, V_out = %b, Z_out = %b", mdata, PC, sximm5, sximm8, datapath_out, N_out, V_out, Z_out);
  end

  // one clock cycle every 10 ticks
  initial forever begin
    clk = 1'b0; #5;
    clk = 1'b1; #5;
  end

  // expected values of datapath_out and Z_out are given by each call to check()
  initial begin
    //initialize values
    err = 1'b0;
    readnum = 3'd0;
    vsel = 4'b0001;
    loada = 1'b0;
    loadb = 1'b0;
    shift = 2'b00;
    asel = 1'b0;
    bsel = 1'b0;
    ALUop = 2'b00;
    loadc = 1'b0;
    loads = 1'b0;
    writenum = 3'd0;
    write = 1'b0;
    mdata = 16'd0;
    PC = 8'd0;
    sximm5 = 5'd0;
    sximm8 = 8'd0;

    // Test 1

    //Assign value 7 to R0
    $display("MOV R0, #7");
    sximm8 = 16'd7;
    writenum = 3'd0;
    vsel = 4'b0100;
    write = 1'b1;
    #10;
    write = 1'b0;

    //Assign value 2 to R1
    $display("MOV R1, #2");
    sximm8 = 16'd2;
    writenum = 3'd1;
    vsel = 4'b0100;
    write = 1'b1;
    #10;
    write = 1'b0;

    //ADD R1 and R0 * 2 and place in R2
    $display("ADDS R2, R1, R0, LSL #2");
    //load A
    readnum = 3'd1;
    loada = 1'b1;
    #10;
    loada = 1'b0;

    //load B
    readnum = 3'b0;
    loadb = 1'b1;
    #10;
    loadb = 1'b0;

    //ALU, write to C and S
    shift = 2'b01;
    asel = 1'b0;
    bsel = 1'b0;
    ALUop = 2'b00;
    loadc = 1'b1;  
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    //write back
    vsel = 4'b0001;
    writenum = 3'd2;
    write = 1'b1;
    #10;
    write = 1'b0;

    check(16'd16, 3'b000);  //expected output 7*2 + 2 = 16

    //Test 2

    //Assign value 69 to R3
    $display("MOV R3, #69");
    sximm8 = 16'd69;
    writenum = 3'd3;
    vsel = 4'b0100;
    write = 1'b1;
    #10;
    write = 1'b0;


    //Assign value 420 to R4
    $display("MOV R4, 420");
    sximm8 = 16'd420;
    writenum = 3'd4;
    vsel = 4'b0100;
    write = 1'b1;
    #10;
    write = 1'b0;

    //SUB R3 and R4 and place in R5
    $display("SUBS R5, R3, R4");
    //load A
    readnum = 3'd3;
    loada = 1'b1;
    #10;
    loada = 1'b0;

    //load B
    readnum = 3'd4;
    loadb = 1'b1;
    #10;
    loadb = 1'b0;

    //Extra check: make sure registers A and B are not always being written to
    readnum = 3'd0;
    #10;

    //ALU, write to C and S
    shift = 2'b00;
    asel = 1'b0;
    bsel = 1'b0;
    ALUop = 2'b01;

    //Extra check: make sure register C and S are not always being written to
    $display("check that registers C and S hold previous value when not written to");
    #10;
    check(16'd16, 3'b000); //from previous check

    loadc = 1'b1; 
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    check(-16'd351, 3'b100); //expected output 69-420=-351

    //write back
    vsel = 4'b0001;
    writenum = 3'd5;
    write = 1'b1;
    #10;
    write = 1'b0;

    //Test 3
    $display("Try ANDing R5 and #31 using sximm5");

    //load A
    readnum = 3'd5;
    loada = 1'b1;
    #10;
    loada = 1'b0;

    //set sximm5 to #31
    sximm5 = 16'd31;

    //enable selects for immd operand
    asel = 1'b0;
    bsel = 1'b1;

    //ALU, write to C and S
    ALUop = 2'b10;
    loadc = 1'b1;
    loads = 1'b1;

    #10;

    loadc = 1'b0;
    loads = 1'b0;

    //check that out is 16'd1
    check(16'd1, 3'b000);

    $display("Try ANDing 0 and #31, update status");

    //immd operand for both
    asel = 1'b1;
    bsel = 1'b1;

    //ALU, write to C and S
    ALUop = 2'b10;
    loadc = 1'b1;
    loads = 1'b1;

    #10;

    loadc = 1'b0;
    loads = 1'b0;

    //check that out is 16'd0 and Z is 1'b1
    check(16'd0, 3'b001);

    //Test 4
    //MOV R6, #63390
    //NOT R6, LSR #1

    //Assign value 63390 to R6
    $display("MOV R6, #-2146");
    sximm8 = -16'd2146;
    writenum = 3'd6;
    vsel = 4'b0100;
    write = 1'b1;
    #10;
    write = 1'b0;


    $display("NOT R6, LSR #1");
    //Load R6 to B
    readnum = 3'd6;
    loadb = 1'b1;
    #10;
    loadb = 1'b0;

    //Shift Right, MSB 0
    //write to C only
    shift = 2'b10;
    asel = 1'b0;
    bsel = 1'b0;
    ALUop = 2'b11;
    loadc = 1'b1;  
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    check(16'b1000_0100_0011_0000, 3'b100); //expected out is 16'b1000_0100_0011_0000

    //Test 5
    //load to b

    //Assign value 60426 to R7
    $display("MOV R7, #60426");
    sximm8 = 16'd60426;
    writenum = 3'd7;
    vsel = 4'b0100;
    write = 1'b1;
    #10;
    write = 1'b0;

    //load r7 to b
    readnum = 3'd7;
    loadb = 1'b1;
    #10;
    loadb = 1'b0;

    // try ASRS R7, write to C and S
    $display("try ASRS R7");
    shift = 2'b11;
    asel = 1'b1;
    bsel = 1'b0;
    ALUop = 2'b00;
    loadc = 1'b1;  
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    check(16'b1111_0110_0000_0101, 3'b100); // expected out 16'b1111_0110_0000_0101

    //read from remaining untested registers

    //read R2, write to C and S
    $display("read R2");
    readnum = 3'd2;
    loadb = 1'b1;
    #10;
    loadb = 1'b0;

    shift = 2'b00;
    asel = 1'b1;
    bsel = 1'b0;
    ALUop = 2'b00;
    loadc = 1'b1;
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    check(16'd16, 1'b0);

    //read R5, write to C and S
    $display("read R5");
    readnum = 3'd5;
    loadb = 1'b1;
    #10;
    loadb = 1'b0;
    shift = 2'b00;
    asel = 1'b1;
    bsel = 1'b0;
    ALUop = 2'b00;
    loadc = 1'b1;
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    check(-16'd351, 3'b100);

    //read R6, write to C and S
    $display("Read R6");
    readnum = 3'd6;
    loadb = 1'b1;
    #10;
    loadb = 1'b0;

    shift = 2'b00;
    asel = 1'b1;
    bsel = 1'b0;
    ALUop = 2'b00;
    loadc = 1'b1;
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    check(-16'd2146, 3'b100);

    //Test 6 - Subtraction overflow
    
    //write 32767 to R6
    $display("MOV R6, #32767");
    writenum = 3'd6;
    write = 1'b1;
    vsel = 4'b0100;
    sximm8 = 16'd32767;
    #10;
    write = 1'b0;


    //write -1 to R7
    $display("MOV R7, #-1");
    writenum = 3'd7;
    write = 1'b1;
    vsel = 4'b0100;
    sximm8 = -16'd1;
    #10;
    write = 1'b0;

    //load r6 to A
    loada = 1'b1;
    readnum = 3'd6;
    #10;
    loada = 1'b0;

    //load r7 to B
    loadb = 1'b1;
    readnum = 3'd7;
    #10;
    loadb = 1'b0;

    //substract A-B
    $display("positive minus negative, with overflow");
    shift = 2'b00;
    asel = 1'b0;
    bsel = 1'b0;
    ALUop = 2'b01;
    loadc = 1'b1;
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    check(-16'd32768, 3'b110);


    //Test 6.2 - Subtraction overflow
    
    //write -32767 to R6
    $display("MOV R6, #-32767");
    writenum = 3'd6;
    write = 1'b1;
    vsel = 4'b0100;
    sximm8 = -16'd32767;
    #10;
    write = 1'b0;


    //write -1 to R7
    $display("MOV R7, #-1");
    writenum = 3'd7;
    write = 1'b1;
    vsel = 4'b0100;
    sximm8 = -16'd1;
    #10;
    write = 1'b0;

    //load r6 to A
    loada = 1'b1;
    readnum = 3'd6;
    #10;
    loada = 1'b0;

    //load r7 to B
    loadb = 1'b1;
    readnum = 3'd7;
    #10;
    loadb = 1'b0;

    //substract A-B
    $display("negative minus negative, no overflow");
    shift = 2'b00;
    asel = 1'b0;
    bsel = 1'b0;
    ALUop = 2'b01;
    loadc = 1'b1;
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    check(-16'd32766, 3'b100);

    //Test 7 - Addition Overflow

    //write 32767 to R6
    $display("MOV R6, #32767");
    writenum = 3'd6;
    write = 1'b1;
    vsel = 4'b0100;
    sximm8 = 16'd32767;
    #10;
    write = 1'b0;

    //write 2 to R7
    $display("MOV R7, #2");
    writenum = 3'd7;
    write = 1'b1;
    vsel = 4'b0100;
    sximm8 = 16'd2;
    #10;
    write = 1'b0;

    //load r6 to A
    loada = 1'b1;
    readnum = 3'd6;
    #10;
    loada = 1'b0;

    //load r7 to B
    loadb = 1'b1;
    readnum = 3'd7;
    #10;
    loadb = 1'b0;

    //add A+B
    $display("positive plus positive, overflow");
    shift = 2'b00;
    asel = 1'b0;
    bsel = 1'b0;
    ALUop = 2'b00;
    loadc = 1'b1;
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    check(-16'd32767, 3'b110);

    //Test 7.2 - Addition Overflow

    //write -32767 to R6
    $display("MOV R6, #32767");
    writenum = 3'd6;
    write = 1'b1;
    vsel = 4'b0100;
    sximm8 = 16'd32767;
    #10;
    write = 1'b0;

    //write -2 to R7
    $display("MOV R7, #-2");
    writenum = 3'd7;
    write = 1'b1;
    vsel = 4'b0100;
    sximm8 = -16'd2;
    #10;
    write = 1'b0;

    //load r6 to A
    loada = 1'b1;
    readnum = 3'd6;
    #10;
    loada = 1'b0;

    //load r7 to B
    loadb = 1'b1;
    readnum = 3'd7;
    #10;
    loadb = 1'b0;

    //add A+B
    $display("positive plus negative, no overflow");
    shift = 2'b00;
    asel = 1'b0;
    bsel = 1'b0;
    ALUop = 2'b00;
    loadc = 1'b1;
    loads = 1'b1;
    #10;
    loadc = 1'b0;
    loads = 1'b0;

    check(16'd32765, 3'b000);

    //print if passed or failed
    if (err) $display("FAILED");
    else $display("PASSED");
    $stop;
  end

endmodule
