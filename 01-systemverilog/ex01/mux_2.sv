/*******************************************************************************
Creator:        Hai Cao Xuan - Joachim Cao (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      mux_2.sv
Design Name:    2-1 Multiplexer
Project Name:   Example
Description:    A 2-1 multiplexer to demonstrate
                Gate-level Combinational Modeling

Changelog:      2022.07.07 - first draft

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

`default_nettype none

module mux_2 (
  // input
  input logic   a_i,
  input logic   b_i,
  input logic   sel_i,

  // output
  output logic  f_o
);

  logic sel_n;
  logic tmp_0;
  logic tmp_1;

  not not_gate(
    sel_n,
    sel_i
  );

  and and_gate_0(
    tmp_0,
    a_i,
    sel_n
  );

  and and_gate_1(
    tmp_1,
    b_i,
    sel_i // error
  );

  or or_gate(
    f_o,
    tmp_0,
    tmp_1
  );

endmodule : mux_2
