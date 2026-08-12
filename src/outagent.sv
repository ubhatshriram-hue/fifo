class outagent extends uvm_agent;

`uvm_component_utils(outagent)

outmonitor mono;

function new(string name = "outagent", uvm_component parent = null);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    mono = outmonitor::type_id::create("mono", this);
endfunction

endclass
