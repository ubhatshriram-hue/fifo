class seq_item extends uvm_sequence_item;
rand logic wr_cs;
rand logic rd_cs;
rand logic wr_en;
rand logic rd_en;
rand logic [`DATA_WIDTH -1 :0] data_in;
logic [`DATA_WIDTH -1 :0] data_out;
logic full;
logic empty;
logic rst;
function new (string name ="seq_item");
super.new(name);
endfunction

`uvm_object_utils_begin(seq_item)
  `uvm_field_int(rst, UVM_ALL_ON)
  `uvm_field_int(wr_cs, UVM_ALL_ON)
  `uvm_field_int(rd_cs , UVM_ALL_ON)
  `uvm_field_int(wr_en, UVM_ALL_ON)
  `uvm_field_int(rd_en, UVM_ALL_ON)
  `uvm_field_int(data_in, UVM_ALL_ON)
  `uvm_field_int(data_out, UVM_ALL_ON)
  `uvm_field_int(full, UVM_ALL_ON)
  `uvm_field_int(empty, UVM_ALL_ON)
`uvm_object_utils_end

constraint c1 { wr_cs == wr_en; }
constraint c2 { rd_cs == rd_en; }

endclass
