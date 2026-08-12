class environment extends uvm_test;
`uvm_component_utils(environment)
inagent agtin;
outagent agtout;
scoreboard sb;


function new(string name = "environment",uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
agtin=inagent::type_id::create("agtin",this);
agtout=outagent::type_id::create("agtout",this);
sb=scoreboard::type_id::create("sb",this);
endfunction

function void connect_phase(uvm_phase phase);
agtin.moni.ap.connect(sb.inp_mon_fifo.analysis_export);
agtout.mono.apout.connect(sb.out_mon_fifo.analysis_export);
  endfunction
endclass



