class sequencee extends uvm_sequence#(seq_item);
`uvm_object_utils( sequencee)

function new (string name ="sequence");
super.new(name);
endfunction

task body();

seq_item req;
  `uvm_info(get_type_name(), "Base seq: Inside Body", UVM_LOW);
repeat(100) begin
req = seq_item::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
end
endtask

endclass
