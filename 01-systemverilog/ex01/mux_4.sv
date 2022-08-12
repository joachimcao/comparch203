/*******************************************************************************
Creator:        Hai Cao Xuan - Joachim Cao (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      mux_4.sv
Design Name:    4-1 Multiplexer
Project Name:   Example
Description:    A 4-1 multiplexer to demonstrate
                Gate-level Combinational Modeling

Changelog:      2022.07.07 - first draft

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

`default_nettype none

module mux_4 (
  // input
  input logic        a_i,
  input logic        b_i,
  input logic        c_i,
  input logic        d_i,
  input logic [1:0]  sel_i,

  // output
  output logic       f_o
);

  // local declaration
  logic tmp_0;
  logic tmp_1;

  // combinational logic
  mux_2 mux_2_unit_0 (
    .a_i   (a_i),
    .b_i   (b_i),
    .sel_i (sel_i[0]),
    .f_o   (tmp_0)
  );

  mux_2 mux_2_unit_1 (
    .a_i   (c_i),
    .b_i   (d_i),
    .sel_i (sel_i[0]),
    .f_o   (tmp_1)
  );

  mux_2 mux_2_unit_2 (
    .a_i   (tmp_0),
    .b_i   (tmp_1),
    .sel_i (sel_i[1]),
    .f_o   (f_o)
  );

endmodule : mux_4
