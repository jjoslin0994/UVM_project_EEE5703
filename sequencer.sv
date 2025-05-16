// -----------------------------------------------------------------------------
// ALU Verification — UCF EEE 5703
// Authors: Jonathan Joslin, Patrik Reagan
// Date: 30 November 2024
// -----------------------------------------------------------------------------

class alu_sequencer extends uvm_sequencer#(alu_sequence_item);
  `uvm_component_utils(alu_sequencer)
  
  
  function new(string name="alu_sequencer", uvm_component parent);
    super.new(name,parent);
    `uvm_info("SEQUENCER_CLASS", "Inside Constructor", UVM_HIGH )
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SEQUENCER_CLASS", "Build Phase", UVM_HIGH )

  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SEQUENCER_CLASS", "Connect Phase", UVM_HIGH )

  endfunction: connect_phase

  
  
endclass: alu_sequencer