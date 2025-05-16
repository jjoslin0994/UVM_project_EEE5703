// -----------------------------------------------------------------------------
// ALU Verification — UCF EEE 5703
// Authors: Jonathan Joslin, Patrik Reagan
// Date: 30 November 2024
// -----------------------------------------------------------------------------

class alu_env extends uvm_env;
  `uvm_component_utils(alu_env)
  
  alu_agent agent;
  alu_scoreboard scr_b;
    
  // Constructor
  function new(string name="alu_env", uvm_component parent);
    super.new(name,parent);
    `uvm_info("ENV_CLASS", "Inside Constructor", UVM_HIGH )
  endfunction: new
  
  // Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ENV_CLASS", "Build Phase", UVM_HIGH )

    agent = alu_agent::type_id::create("agent", this);
    scr_b = alu_scoreboard::type_id::create("scr_b",this);
    
  endfunction: build_phase
  
  // Connect Phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ENV_CLASS", "Connect Phase", UVM_HIGH )
    
    // connect monitor to scoreboard
    
    agent.monitor.monitor_port.connect(scr_b.scoreboard_port);

  endfunction: connect_phase

  // Run Phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    // Logic

  endtask: run_phase
  
endclass: alu_env