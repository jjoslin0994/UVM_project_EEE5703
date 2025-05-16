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

// Used under educational fair use for verification testing.
// Verification developed by Jonathan Joslin and Patrik Reagan (UCF EEE 5703, Fall 2024).


`include "sr_cpu.svh"

module sr_alu
(
    input        [31:0] srcA,
    input        [31:0] srcB,
    input        [ 2:0] oper,
    output              zero,
    output logic [31:0] result
);

    always_comb
        case (oper)
            default   : result =  srcA +  srcB;
            `ALU_ADD  : result =  srcA +  srcB;
            `ALU_OR   : result =  srcA |  srcB;
            `ALU_SRL  : result =  srcA >> srcB [4:0];
            `ALU_SLTU : result = (srcA <  srcB) ? 32'd1 : 32'd0;
            `ALU_SUB  : result =  srcA -  srcB;
        endcase

    assign zero = (result == '0);

endmodule