// -----------------------------------------------------------------------------
// ALU Verification — UCF EEE 5703
// Authors: Jonathan Joslin, Patrik Reagan
// Date: 30 November 2024
// -----------------------------------------------------------------------------
// Object class

class alu_base_sequence extends uvm_sequence;
  `uvm_object_utils(alu_base_sequence)
  
  alu_sequence_item reset_pkt;
  
  // Constructor
  function new(string name="alu_base_sequence");
    super.new(name);
    `uvm_info("BASE_SEQUENCE", "Inside Constructor", UVM_HIGH)
  endfunction
  
  // Body Task
  task body();
    `uvm_info("BASE_SEQUENCE", "Indide body task!", UVM_HIGH)
        
  endtask: body
  
endclass: alu_base_sequence



class alu_test_sequence extends alu_base_sequence;
  `uvm_object_utils(alu_test_sequence)
  
  alu_sequence_item item;
  
  // Constructor
  function new(string name="alu_test_sequence");
    super.new(name);
    `uvm_info("TEST_SEQUENCE", "Inside Constructor", UVM_HIGH)
  endfunction
  
  // Body Task
  task body();
    `uvm_info("TEST_SEQUENCE", "Indide body task!", UVM_HIGH)
    
    item = alu_sequence_item::type_id::create("item");
    start_item(item);
    item.randomize();
    finish_item(item);
    
  endtask: body
endclass: alu_test_sequence