# UVM_project_EEE5703
ALU Verification — UCF EEE 5703
Authors: Jonathan Joslin, Patrik Reagan
Date: 30 November 2024


This verification project targets the ALU and control unit functionality
of a small RISC-V core. The design under test (DUT) is the `schoolRISCV`
processor from the TinyTapeout project.

The ALU module used here is sourced from `schoolRISCV`, originally based
on Sarah L. Harris’s MIPS CPU and the schoolMIPS project.

Copyright (c) 2017–2020 Stanislav Zhelnio & Aleksandr Romanov.
Modified in 2024 by Yuri Panchul & Mike Kuskov for systemverilog-homework.

Used under educational fair use for verification testing.

This testbench uses UVM methodology for constrained-random testing,
functional coverage, and result checking.

