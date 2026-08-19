class scoreboard extends uvm_scoreboard;
 
  `uvm_component_utils(scoreboard)
 
  uvm_tlm_analysis_fifo #(seq_item) inp_mon_fifo;
  uvm_tlm_analysis_fifo #(seq_item) out_mon_fifo;
 
  seq_item inp_mon_xn;
  seq_item inp_mon_xn_hold;
  seq_item out_mon_xn;
 
  int match    = 0;
  int mismatch = 0;
  int count    = 0;
 
  int full;
  int empty;
  int wr_pointer;
  int rd_pointer;
  int counter;
 
  bit [`DATA_WIDTH-1:0] dataout;
 
  bit [`DATA_WIDTH-1:0] mem [0:(1<<`ADDR_WIDTH)-1];
 
 
  function new(string name = "scoreboard",
               uvm_component parent);
 
    super.new(name, parent);
 
    inp_mon_fifo = new("inp_mon_fifo", this);
    out_mon_fifo = new("out_mon_fifo", this);
 
  endfunction
 
 
  task run_phase(uvm_phase phase);
 
    forever begin
 
      inp_mon_fifo.get(inp_mon_xn);
      out_mon_fifo.get(out_mon_xn);
 
      if (inp_mon_xn_hold == null) begin
 
        inp_mon_xn_hold = inp_mon_xn;
 
      end
      else begin
 
        ref_model(inp_mon_xn_hold);
 
        validate_outputs(inp_mon_xn_hold,
                         out_mon_xn);
 
        inp_mon_xn_hold = inp_mon_xn;
 
      end
 
    end
 
  endtask
 
 
  task ref_model(seq_item t);
 
    
    if (t.rst) begin
 
      full       = 0;
      empty      = 1;
      dataout    = 0;
 
      wr_pointer = 0;
      rd_pointer = 0;
      counter    = 0;
 
      for (int i = 0;
           i < (1 << `ADDR_WIDTH);
           i++)
        mem[i] = 0;
 
    end
 
   
    t.data_out = dataout;
 
 
    if (!t.rst) begin
 
      
      if (t.wr_cs && !full && t.wr_en) begin
 
        mem[wr_pointer] = t.data_in;
 
        counter++;
        wr_pointer++;
 
      end
 
 
      
      if (t.rd_cs && !empty && t.rd_en) begin
 
        dataout = mem[rd_pointer];
 
        counter--;
        rd_pointer++;
 
      end
 
    end
 
 
    
    full  = (counter == (1 << `ADDR_WIDTH));
    empty = (counter == 0);
 
    t.full     = full;
    t.empty    = empty;
    t.data_out = dataout;
 
  endtask
 
 
  task validate_outputs(seq_item ref_tr,
                        seq_item dut_tr);
 
    count++;
 
    if ((ref_tr.data_out == dut_tr.data_out) &&
        (ref_tr.full     == dut_tr.full)     &&
        (ref_tr.empty    == dut_tr.empty)) begin
 
      match++;
 
      `uvm_info("CHECKING_OUTPUT",
                $sformatf(
                "MATCH=%0d DATA_OUT=%0h FULL=%0b EMPTY=%0b",
                match,
                dut_tr.data_out,
                dut_tr.full,
                dut_tr.empty),
                UVM_NONE)
 
    end
    else begin
 
      mismatch++;
 
      `uvm_error("CHECKING_OUTPUT",
                 $sformatf(
                 "MISMATCH=%0d\nREF: DATA_OUT=%0h FULL=%0b EMPTY=%0b\nDUT: DATA_OUT=%0h FULL=%0b EMPTY=%0b",
                 mismatch,
                 ref_tr.data_out,
                 ref_tr.full,
                 ref_tr.empty,
                 dut_tr.data_out,
                 dut_tr.full,
                 dut_tr.empty))
    end
 
  endtask
 
endclass
