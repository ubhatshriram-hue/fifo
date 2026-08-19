class base_test extends uvm_test;
`uvm_component_utils(base_test)
environment env;

function new(string name = "base_test",uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
env=environment::type_id::create("env",this);
endfunction

task run_phase(uvm_phase phase);
sequencee s1;

sequencee1 s2;
	s1=sequencee::type_id::create("s1");

	s2=sequencee1::type_id::create("s2");
	
	phase.raise_objection(this);

	s1.start(env.agtin.seqr);
	
	s2.start(env.agtin.seqr);
	
	
	phase.drop_objection(this);
endtask
endclass
