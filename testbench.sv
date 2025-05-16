// ALU Verification
// Date: 30 Novmeber 2024


`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

// ----------------------------------------------------------------
//Include Files
// ----------------------------------------------------------------
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"


module top;
  
  // ----------------------------------------------------------------
  //Instantiation
  // ----------------------------------------------------------------
  
  logic clock;
  
  alu_interface intf(.clock(clock));
  
  // device under test
  sr_alu dut( 
    .srcA(intf.src_a),
    .srcB(intf.src_b),
    .oper(intf.op_code),
    .zero(intf.z_flag),
    .result(intf.result)
  );
  
//   -----------------------------------------------------------------
// Infterface Settings
//   -----------------------------------------------------------------
  initial begin
    
    uvm_config_db #(virtual alu_interface)::set(null, "*", "vif", intf );
    
  end
  
//   -----------------------------------------------------------------
// Start Test
//   -----------------------------------------------------------------
  initial begin
    run_test("alu_test");
  end
  
  initial begin
    clock = 0;
    #5;
    forever begin
      clock = ~clock;
      #10;
    end
  end
  
  initial begin
    #5000
    $display("ran out of clock cycles");
    $finish();
  end
  
  // Output waveform
  initial begin 
    $dumpfile("d.vcd");
    $dumpvars();
  end
  
endmodule