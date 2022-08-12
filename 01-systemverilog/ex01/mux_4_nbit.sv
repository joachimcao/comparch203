/*******************************************************************************
Creator:        Hai Cao Xuan - Joachim Cao (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      mux_4_nbit.sv
Design Name:    N-bit 4-1 Multiplexer
Project Name:   Example
Description:    A simple logic unit to demonstrate
                how to use parameter

Changelog:      2022.07.07 - first draft

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

`default_nettype none

module mux_4_nbit #(
  parameter int unsigned Width = 32
) (
  // input
  input logic [Width-1:0]  a_i,
  input logic [Width-1:0]  b_i,
  input logic [Width-1:0]  c_i,
  input logic [Width-1:0]  d_i,
  input logic [1:0]        sel_i,

  // output
  output logic [Width-1:0] f_o
);

  // local Declaration
  logic [Width-1:0] tmp_0;
  logic [Width-1:0] tmp_1;

  // combinational Logic
  mux_2_nbit #(
    .Width(Width)
  ) mux_2_unit_0 (
    .a_i   (a_i),
    .b_i   (b_i),
    .sel_i (sel_i[0]),
    .f_o   (tmp_0)
  );

  mux_2_nbit #(
    .Width(Width)
  ) mux_2_unit_1 (
    .a_i   (c_i),
    .b_i   (d_i),
    .sel_i (sel_i[0]),
    .f_o   (tmp_1)
  );

  mux_2_nbit #(
    .Width(Width)
  ) mux_2_unit_2 (
    .a_i   (tmp_0),
    .b_i   (tmp_1),
    .sel_i (sel_i[1]),
    .f_o   (f_o)
  );

endmodule : mux_4_nbit
