class inagent extends uvm_agent;
 `uvm_component_utils(inagent)

driver drv;
sequencer seqr;
inmonitor moni ;

  function new(string name = "inagent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
 
      drv = driver::type_id::create("drv", this);
      seqr = sequencer::type_id::create("seqr", this);
moni = inmonitor::type_id::create("moni", this);
  endfunction

function void connect_phase(uvm_phase phase);
  
      drv.seq_item_port.connect(seqr.seq_item_export);
   
  endfunction
endclass
