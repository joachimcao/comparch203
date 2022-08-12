/*******************************************************************************
Creator:        Hai Cao Xuan - Joachim Cao (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      mux_2_nbit.sv
Design Name:    N-bit 2-1 Multiplexer
Project Name:   Example
Description:    A simple logic unit to demonstrate
                how to use parameter

Changelog:      2022.07.23 - first draft

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

`default_nettype none

module mux_2_nbit #(
  parameter int unsigned Width = 8
) (
  // input
  input logic [Width-1:0]  a_i,
  input logic [Width-1:0]  b_i,
  input logic              sel_i,

  // output
  output logic [Width-1:0] f_o
);

  assign f_o = sel_i ? b_i : a_i;

endmodule : mux_2_nbit
