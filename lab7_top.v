`define MNONE  2'd0
`define MREAD  2'd1
`define MWRITE 2'd2

module lab7_top(KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
  input [3:0] KEY;
  input [9:0] SW;
  output [9:0] LEDR;
  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

  assign LEDR[9:8] = 2'b00; // upper 2 LEDs are not used, tie low
  assign {HEX0, HEX1, HEX2, HEX3, HEX4, HEX5} = {42{1'b1}}; // don't display anything on 7 segment displays

  wire clk, reset, s, load;
  wire [15:0] in;
  wire N, V, Z, w;
  wire [1:0] mem_cmd;
  wire [8:0] mem_addr;
  wire [15:0] read_data, write_data;
  cpu CPU(clk, reset, in, N, V, Z, mem_cmd, mem_addr, read_data, write_data); //initialize CPU instance
  
  wire write;
  wire [15:0] din, dout;
  assign din = write_data; // connect write_data with dout
  RAM #(16,8) MEM(clk, mem_addr[7:0], mem_addr[7:0], write, din, dout); //initialize RAM instance
  

  //RAM dout logic
  wire readOrWrite;

  assign readOrWrite = (`MREAD == mem_cmd) & (1'b0 == mem_addr[8]); //tri-state inverter for dout depending on memory command and memory address
  assign read_data = readOrWrite ? dout : {16{1'bz}};         

  //RAM write select logic depending on memory command and memory address. 
  assign write = (`MWRITE == mem_cmd) & (1'b0 == mem_addr[8]);

  //LED output combinational circuit block and
  wire loadLEDReg;
  //when memory address is 0x100 and write operation, load led register
  assign loadLEDReg = (mem_addr == 9'h100) & (mem_cmd == `MWRITE);

  //led output register
  vDFFE #(8) LED_REG(clk, loadLEDReg, write_data[7:0], LEDR[7:0]);

  //Comb logic mapping switches to read_data
  wire enableTriStateDrive;
  //TristateDriver enabled if reading and memory address is 0x140
  assign enableTriStateDrive = (mem_cmd == `MREAD) & (mem_addr == 9'h140);

  //tristatedriver enabled readdata to 0 if enabled.
  assign read_data[15:8] = enableTriStateDrive ? 8'h00: {8{1'bz}};
  //tristateDriver enabled to set read_data to switch values.
  assign read_data[7:0] = enableTriStateDrive ? SW[7:0] : {8{1'bz}};

  //setting the clock
  assign clk = ~KEY[0];
  //setting the reset
  assign reset = ~KEY[1];


endmodule
