
package pkg;

`define DATA_WIDTH 8
`define ADDR_WIDTH 8
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  `include "seq_item.sv"
  `include "sequencer.sv"
  
  `include "sequencee.sv"
`include "driver.sv"
`include "outmonitor.sv"
  `include "inmonitor.sv"
 `include "outagent.sv"
  `include "inagent.sv"
  `include"subcriber.sv"
	`include "scoreboard.sv"
  `include "environment.sv"
  `include "test.sv"
endpackage
