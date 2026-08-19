class sequencee extends uvm_sequence#(seq_item);
`uvm_object_utils( sequencee)

function new (string name ="sequence");
super.new(name);
endfunction

task body();

seq_item req;
  `uvm_info(get_type_name(), "Base seq: Inside Body", UVM_LOW);
repeat(30) begin
req = seq_item::type_id::create("req");
start_item(req);
	assert(req.randomize());

finish_item(req);


	`uvm_info(get_type_name(), "Base seq end : Inside Body", UVM_LOW);

end
endtask

endclass



class sequencee1 extends sequencee;
`uvm_object_utils( sequencee1)

function new (string name ="sequence1");
	super.new(name);
endfunction

task body();

	seq_item req;
	  `uvm_info(get_type_name(), "Base seq: Inside Body", UVM_LOW);
	repeat(300) begin
		req = seq_item::type_id::create("req");
		start_item(req);
		assert(req.randomize()with {wr_cs==1;wr_en==1;rd_cs==0;rd_en==0;}) 

		finish_item(req);


		        `uvm_info(get_type_name(), "Base seq end : Inside Body", UVM_LOW);

	end
endtask

endclass

