// -----------------------------------------------------------------------------
// ALU Verification — UCF EEE 5703
// Authors: Jonathan Joslin, Patrik Reagan
// Date: 30 November 2024
// -----------------------------------------------------------------------------
class alu_scoreboard extends uvm_component;
  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp #(alu_sequence_item, alu_scoreboard) scoreboard_port;

  // Transaction array
  alu_sequence_item transactions[$];

  // Declare covergroup inside the class
  covergroup cg_opcode_ALU with function sample(bit[2:0] op, bit [31:0] A, bit [31:0] B, bit zero_flag);
    cp_opcode_arith: coverpoint op {
      bins add = 	{3'b000};
      bins OR =		{3'b001};
      bins sub = 	{3'b100};
      bins srl = 	{3'b010};
      bins sltu = 	{3'b011};
    }
    
    coverpoint A {
      bins zero = {[0:0]};
      bins other = {[1:$]};
      bins max = {32'hFFFF_FFFF};
    }
    coverpoint B {
      bins zero = {[0:0]};
      bins other = {[1:$]};
      bins max = {32'hFFFF_FFFF};
    }
  endgroup: cg_opcode_ALU

 // Declare the covergroup instance as a pointer

  // Constructor
  function new(string name="alu_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SCOREBOARD_CLASS", "Inside Constructor", UVM_HIGH)
     // Instantiate the covergroup in the constructor
    cg_opcode_ALU = new ();
  endfunction: new

  // Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCOREBOARD_CLASS", "Build Phase", UVM_HIGH)
    scoreboard_port = new("scoreboard_port", this);
  endfunction: build_phase

  // Connect Phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCOREBOARD_CLASS", "Connect Phase", UVM_HIGH)
  endfunction: connect_phase

  // Write Method to store transactions
  function void write(alu_sequence_item item);
    transactions.push_back(item);
  endfunction: write

  // Run Phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SCOREBOARD_CLASS", "Run phase!", UVM_HIGH)

    forever begin
      alu_sequence_item cur_trans;
      wait(transactions.size() > 0);
      cur_trans = transactions.pop_front();
      compare(cur_trans);
    end
  endtask: run_phase

  // Compare: Generate Expected result and compare with actual
  task compare(alu_sequence_item cur_trans);
    logic [31:0] expected;
    logic [31:0] actual;
    logic zero_e, zero_a;
    string op_code;

    // Sample the covergroup
    cg_opcode_ALU.sample(cur_trans.op_code, cur_trans.src_a, cur_trans.src_b, cur_trans.z_flag);

    // Generate expected value based on operation
    case(cur_trans.op_code)
      0 : begin // ALU ADD srcA + srcB
        expected = cur_trans.src_a + cur_trans.src_b;
        op_code = "ADD";
      end
      1 : begin // ALU OR srcA | srcB
        expected = cur_trans.src_a | cur_trans.src_b;
        op_code = "OR";
      end
      2 : begin // ALU SRL srcA >> srcB [4:0]
        expected = cur_trans.src_a >> cur_trans.src_b[4:0];
        op_code = "SRL";
      end
      3 : begin // ALU SLTU (srcA < srcB) ? 32'd1 : 32'd0;
        expected = (cur_trans.src_a < cur_trans.src_b) ? 32'd1 : 32'd0;
        op_code = "SLTU";
      end
      4 : begin // ALU SUB srcA - srcB
        expected = cur_trans.src_a - cur_trans.src_b;
        op_code = "SUB";
      end
      default : begin // Default to ADD if operation is undefined
        expected = cur_trans.src_a + cur_trans.src_b;
        op_code = "ADD";
      end
    endcase

    // Check if expected and actual values match
    zero_e = (expected == 0);
    actual = cur_trans.result;
    zero_a = cur_trans.z_flag;

    if (actual != expected || zero_e != zero_a) begin
      `uvm_error("COMPARE", $sformatf("Transaction failed! op = %s, Actual = %d, Expected = %d", op_code, actual, expected))
    end else begin
      `uvm_info("COMPARE", $sformatf("Transaction Success! op = %s, Actual = %d, Expected = %d", op_code, actual, expected), UVM_LOW)
    end
  endtask: compare

endclass: alu_scoreboard
