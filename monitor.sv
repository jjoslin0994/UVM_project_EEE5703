// -----------------------------------------------------------------------------
// ALU Verification — UCF EEE 5703
// Authors: Jonathan Joslin, Patrik Reagan
// Date: 30 November 2024
// -----------------------------------------------------------------------------

class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)
   
  virtual alu_interface vif;
 
  alu_sequence_item item;
  
  uvm_analysis_port #(alu_sequence_item) monitor_port;
  

  
  // Constructor
  function new(string name="alu_monitor", uvm_component parent);
    super.new(name,parent);
    `uvm_info("MONITOR_CLASS", "Inside Constructor", UVM_HIGH )
    
  endfunction: new
  
  // Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR_CLASS", "Build Phase", UVM_HIGH )
    
    monitor_port = new("monitor_port", this);
    
    if(!(uvm_config_db #(virtual alu_interface)::get(this, "*", "vif", vif))) begin
      `uvm_error("MONITOR_CLASS", "Failed to obtain vif from config db");
    end

  endfunction: build_phase
  
  // Connect Phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MONITOR_CLASS", "Connect Phase", UVM_HIGH )

  endfunction: connect_phase

  // Run Phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR_CLASS","Run Phase!", UVM_HIGH)
    
    forever begin
      
      item = alu_sequence_item::type_id::create("item");
            
      //sample the inputs
      @(posedge vif.clock);
      item.src_a = vif.src_a;
      item.src_b = vif.src_b;
      item.op_code = vif.op_code;
      
      // sample the outputs
      item.result = vif.result;
      item.z_flag = vif.z_flag;
      
      // send item to scoreboard
      monitor_port.write(item);
      
    end
    
    
  endtask: run_phase
  
endclass: alu_monitor