/*******************************************************************************
Creator:        ...

Additional Contributions by:

File Name:      dff_sync_2.sv
Design Name:    2 Flipflop Synchronizer
Project Name:   Example
Description:    ...

Changelog:      YYYY.MM.DD - ...

*******************************************************************************/

`default_nettype none

module dff_sync_2 #(
  parameter int unsigned    Width = 32
) (
  // global
  input logic               clk_i,
  input logic               rst_ni,

  // input
  input logic [Width-1:0]   data_i,

  // output
  output logic [Width-1:0]  data_o
);

  logic [Width-1:0] tmp;

  always_ff @(posedge clk_i) begin : proc_2_dff
    if (!rst_ni) begin
      tmp    <= '0;
      data_o <= '0;
    end else begin
      tmp    <= data_i;
      data_o <= tmp;
    end
  end

endmodule : dff_sync_2
