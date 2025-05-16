// -----------------------------------------------------------------------------
// ALU Verification — UCF EEE 5703
// Authors: Jonathan Joslin, Patrik Reagan
// Date: 30 November 2024
// -----------------------------------------------------------------------------
// Object

class alu_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(alu_sequence_item)
  
  //Instantiations
  //generate random input values and store the result
  rand logic [31:0] src_a, src_b;
  randc logic [2:0] op_code;
  
  bit z_flag; // output
  logic [31:0] result; // ouput
  
  // Default Constraints--------------------------------------------------
  constraint input_c {
  	src_a >= src_b;
  }
  
  constraint op_code_c {op_code inside {[0:4]};}
  
  constraint arithmetic {
    if(op_code == 3'b000 || op_code == 3'b100){ // addition
      src_a dist {
        [0:0] :/4,
        [0:32'hFFFF_FFFE] :/2,
        [32'hFFFF_FFFF:32'hFFFF_FFFF] :/4
      };
      
      src_b dist {
        [0:0] :/2, // 0 
        [0:32'hFFFF_FFFE] :/1, // other
        [32'hFFFF_FFFF:32'hFFFF_FFFF] :/40 // max
      };
    }
  }
  
  function new(string name="alu_sequence_item");
    super.new(name);
  endfunction: new
endclass: alu_sequence_item