// -----------------------------------------------------------------------------
// ALU Verification — UCF EEE 5703
// Authors: Jonathan Joslin, Patrik Reagan
// Date: 30 November 2024
// -----------------------------------------------------------------------------

/*
    This verification project targets the ALU and control unit functionality
    of a small RISC-V core. The design under test (DUT) is the `schoolRISCV`
    processor from the TinyTapeout project.

    The ALU module used here is sourced from `schoolRISCV`, originally based
    on Sarah L. Harris’s MIPS CPU and the schoolMIPS project.

    Copyright (c) 2017–2020 Stanislav Zhelnio & Aleksandr Romanov.
    Modified in 2024 by Yuri Panchul & Mike Kuskov for systemverilog-homework.

    This testbench uses UVM methodology for constrained-random testing,
    functional coverage, and result checking.
*/


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