`include "dut.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "package.sv"

import pkg::*;

module tb_top;

  bit CLK;
  bit RST;

  // Clock
  always #5 CLK = ~CLK;

  // Reset
  initial begin
    RST = 1;
    repeat(3) @(posedge CLK);
    #1 RST = 0;
  end


  // Interface
  my_if vif (
    .clk (CLK),
    .rst (RST)
  );


  // FIFO DUT
  syn_fifo DUT (

    .clk      (vif.clk),
    .rst      (vif.rst),

    .wr_cs    (vif.wr_cs),
    .rd_cs    (vif.rd_cs),

    .data_in  (vif.data_in),

    .rd_en    (vif.rd_en),
    .wr_en    (vif.wr_en),

    .data_out (vif.data_out),

    .empty    (vif.empty),
    .full     (vif.full)

  );


  // UVM configuration
  initial begin

    uvm_config_db#(virtual my_if)::set(
      uvm_root::get(),
      "*",
      "vif",
      vif
    );

    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0);

  end


  // Start UVM
  initial begin
    run_test("base_test");
  end

endmodule
