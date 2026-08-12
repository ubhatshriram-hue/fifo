class inmonitor extends uvm_monitor;
`uvm_component_utils(inmonitor);
virtual my_if vif;
uvm_analysis_port#(seq_item) ap;

 function new(string name, uvm_component parent=null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

 function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "vif not set for monitor")
  endfunction

task run_phase(uvm_phase phase);
    seq_item tr;
      @(vif.cbmoni);
    forever begin
      @(vif.cbmoni);
      tr = seq_item::type_id::create("tr");


     tr.wr_cs    = vif.cbmoni.wr_cs;
tr.rd_cs    = vif.cbmoni.rd_cs;
tr.wr_en    = vif.cbmoni.wr_en;
tr.rd_en    = vif.cbmoni.rd_en;
tr.data_in  = vif.cbmoni.data_in;
tr.rst      = vif.cbmoni.rst;

      `uvm_info("INPUT_MONITOR", $sformatf("Captured Input\n%s", tr.sprint()), UVM_NONE)
      ap.write(tr);
    end
  endtask

endclass

