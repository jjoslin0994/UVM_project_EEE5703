// -----------------------------------------------------------------------------
// ALU Verification — UCF EEE 5703
// Authors: Jonathan Joslin, Patrik Reagan
// Date: 30 November 2024
// -----------------------------------------------------------------------------
interface alu_interface(input logic clock);
  
  logic [31:0] src_a, src_b;
  logic [2:0] op_code;
  bit z_flag;
  logic [31:0] result;
  
endinterface: alu_interface;