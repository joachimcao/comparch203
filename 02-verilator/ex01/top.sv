/*******************************************************************************
Creator:        Hai Cao Xuan (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      top.sv
Design Name:    top
Project Name:   Computer Architecture Examples
Description:    top module

Changelog:      06.07.2022 - First draft, v0.1

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

`default_nettype none

module top #(
  parameter DataWidth = 8
) (
  input logic [DataWidth-1:0]  data_a,
  input logic [DataWidth-1:0]  data_b,
  input my_pkg::alu_op_e       alu_op,
  input logic                  dvalid,

  output logic [DataWidth-1:0] result,
  output logic                 rvalid
);

  alu #(
    .DataWidth(DataWidth)
  ) alu_0 (
    .data_a_i   (data_a),
    .data_b_i   (data_b),
    .alu_op_i   (alu_op),
    .dvalid_i   (dvalid),
    .result_o   (result),
    .rvalid_o   (rvalid)
  );

endmodule : top
