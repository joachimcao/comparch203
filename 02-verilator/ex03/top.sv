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
  input logic                  clk_i,
  input logic                  rst_ni,

  input logic [DataWidth-1:0]  data_a,
  input logic [DataWidth-1:0]  data_b,
  input my_pkg::alu_op_e       alu_op,
  input logic                  dvalid,

  output logic [DataWidth-1:0] result,
  output logic                 rvalid
);

  logic [DataWidth-1:0]  data_a_q;
  logic [DataWidth-1:0]  data_b_q;
  my_pkg::alu_op_e       alu_op_q;
  logic                  dvalid_q;

  logic [DataWidth-1:0]  result_d;
  logic                  rvalid_d;

  alu #(
    .DataWidth(DataWidth)
  ) alu_0 (
    .data_a_i   (data_a_q),
    .data_b_i   (data_b_q),
    .alu_op_i   (alu_op_q),
    .dvalid_i   (dvalid_q),
    .result_o   (result_d),
    .rvalid_o   (rvalid_d)
  );

  always_ff @(posedge clk_i) begin : proc_in
    if (~rst_ni) begin
      data_a_q <= '0;
      data_b_q <= '0;
      alu_op_q <= my_pkg::A_NOP;
      dvalid_q <= '0;
    end else begin
      data_a_q <= data_a;
      data_b_q <= data_b;
      alu_op_q <= alu_op;
      dvalid_q <= dvalid;
    end
  end

  always_ff @(posedge clk_i) begin : proc_out
    if (~rst_ni) begin
      result <= '0;
      rvalid <= '0;
    end else begin
      result <= result_d;
      rvalid <= rvalid_d;
    end
  end

endmodule : top
