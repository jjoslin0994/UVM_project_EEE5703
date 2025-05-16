// -----------------------------------------------------------------------------
// CPU Verification — UCF EEE 5703
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

// Used under educational fair use for verification testing.
// Verification developed by Jonathan Joslin and Patrik Reagan (UCF EEE 5703, Fall 2024).

`ifndef SR_CPU_SVH
`define SR_CPU_SVH

// ALU commands

`define ALU_ADD     3'b000
`define ALU_OR      3'b001
`define ALU_SRL     3'b010
`define ALU_SLTU    3'b011
`define ALU_SUB     3'b100

// Instruction opcode

`define RVOP_ADDI   7'b0010011
`define RVOP_BEQ    7'b1100011
`define RVOP_LUI    7'b0110111
`define RVOP_BNE    7'b1100011
`define RVOP_ADD    7'b0110011
`define RVOP_OR     7'b0110011
`define RVOP_SRL    7'b0110011
`define RVOP_SLTU   7'b0110011
`define RVOP_SUB    7'b0110011

// Instruction funct3

`define RVF3_ADDI   3'b000
`define RVF3_BEQ    3'b000
`define RVF3_BNE    3'b001
`define RVF3_ADD    3'b000
`define RVF3_OR     3'b110
`define RVF3_SRL    3'b101
`define RVF3_SLTU   3'b011
`define RVF3_SUB    3'b000
`define RVF3_ANY    3'b???

// Instruction funct7

`define RVF7_ADD    7'b0000000
`define RVF7_OR     7'b0000000
`define RVF7_SRL    7'b0000000
`define RVF7_SLTU   7'b0000000
`define RVF7_SUB    7'b0100000
`define RVF7_ANY    7'b???????

`endif  // `ifndef SR_CPU_SVH