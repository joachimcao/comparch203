/*******************************************************************************
Creator:        Hai Cao Xuan (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      alu.sv
Design Name:    ALU
Project Name:   Computer Architecture Examples
Description:    Arithmetic Logic Unit

Changelog:      06.07.2022 - First draft, v0.1

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

`default_nettype none

module alu #(
  parameter DataWidth = 8
) (
  // Input
  input logic [DataWidth-1:0]   data_a_i,
  input logic [DataWidth-1:0]   data_b_i,
  input my_pkg::alu_op_e        alu_op_i,
  input logic                   dvalid_i,

  // Output
  output logic [DataWidth-1:0]  result_o,
  output logic                  rvalid_o
);

  logic [DataWidth-1:0] adder_result;
  logic [DataWidth-1:0] or_result;
  logic [DataWidth-1:0] and_result;
  logic [DataWidth-1:0] result;

/////////////////////////////
// Arithmetic Unit - Adder //
/////////////////////////////

  assign adder_result = $unsigned(data_a_i) + $unsigned(data_b_i);

////////////////
// Logic Unit //
////////////////

  assign or_result  = data_a_i | data_b_i;
  assign and_result = data_a_i & data_b_i;

///////////////////
// Select Result //
///////////////////

  always_comb begin : proc_choose_result
    case (alu_op_i)
      my_pkg::A_NOP : result = '0;
      my_pkg::A_ADD : result = adder_result;
      my_pkg::A_OR :  result = or_result;
      my_pkg::A_AND : result = and_result;
      default :   result = '0;
    endcase

    result_o = (dvalid_i) ? result : '0;
    rvalid_o  = dvalid_i;
  end

endmodule : alu
