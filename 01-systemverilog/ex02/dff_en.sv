/*******************************************************************************
Creator:        Hai Cao Xuan - Joachim Cao (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      dff_en.sv
Design Name:    D Flipflop with Enable
Project Name:   Example
Description:    A D Flipflop to demonstrate always_ff

Changelog:      2022.07.07 - first draft

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

`default_nettype none

module dff_en #(
  parameter int unsigned    Width = 32
) (
  // global
  input logic               clk_i,
  input logic               rst_ni,

  // input
  input logic [Width-1:0]   d_i,
  input logic               en_i,

  // output
  output logic [Width-1:0]  q_o
);

  always_ff @(posedge clk_i or negedge rst_ni) begin : proc_dff
    if (!rst_ni) begin
      q_o <= '0;
    end else begin
      if (en_i) begin
        q_o <= d_i;
      end
    end
  end

endmodule : dff_en
