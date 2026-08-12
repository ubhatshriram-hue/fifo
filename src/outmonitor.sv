class outmonitor extends uvm_monitor;
`uvm_component_utils(outmonitor);
virtual my_if vif;
uvm_analysis_port#(seq_item) apout;

 function new(string name, uvm_component parent);
    super.new(name, parent);
    apout = new("apout", this);
  endfunction

 function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "vif not set for monitor")
  endfunction

task run_phase(uvm_phase phase);
    seq_item tr;
     @(vif.cbmono);
    forever begin
     @(vif.cbmono);
tr = seq_item::type_id::create("tr");

tr.wr_cs    = vif.cbmono.wr_cs;
tr.rd_cs    = vif.cbmono.rd_cs;
tr.wr_en    = vif.cbmono.wr_en;
tr.rd_en    = vif.cbmono.rd_en;

tr.data_in  = vif.cbmono.data_in;
tr.data_out = vif.cbmono.data_out;

tr.full     = vif.cbmono.full;
tr.empty    = vif.cbmono.empty;

tr.rst      = vif.cbmono.rst;


      `uvm_info("OUTPUT_MONITOR", $sformatf("Captured output\n%s", tr.sprint()), UVM_NONE)
      apout.write(tr);
    end
  endtask

endclass



