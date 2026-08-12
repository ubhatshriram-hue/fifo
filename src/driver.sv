class driver extends uvm_driver#(seq_item);
  virtual my_if vif;
  `uvm_component_utils(driver)

  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "vif not set for driver")
  endfunction


task run_phase (uvm_phase phase);

forever begin 
seq_item_port.get_next_item(req);
drive(req);
seq_item_port.item_done();
end
endtask

task drive(seq_item req);
  begin

 @(vif.cbdrv);

    `uvm_info("INPUT_DRIVER", $sformatf("Input Driver\n%s", req.sprint()), UVM_NONE)
    vif.cbdrv.wr_cs   <= req.wr_cs;
    vif.cbdrv.rd_cs   <= req.rd_cs;
    vif.cbdrv.wr_en   <= req.wr_en;
    vif.cbdrv.rd_en   <= req.rd_en;
    vif.cbdrv.data_in <= req.data_in;

    end
endtask
endclass
