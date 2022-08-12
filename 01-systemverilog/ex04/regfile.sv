/*******************************************************************************
Creator:        Hai Cao Xuan - Joachim Cao (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      regfile.sv
Design Name:    Register File
Project Name:   Example
Description:    A simple Register File

Changelog:      2022.07.07 - first draft

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

`default_nettype none

module regfile #(
  parameter int unsigned    Width = 32,
  parameter int unsigned    Size  = 32
) (
  // global
  input logic                    clk_i,
  input logic                    rst_ni,

  // input
  input logic [$clog2(Size)-1:0] rs1_addr_i,
  input logic [$clog2(Size)-1:0] rs2_addr_i,
  input logic [$clog2(Size)-1:0] rd_addr_i,
  input logic [Width-1:0]        rd_data_i,
  input logic                    wr_en_i,

  // output
  output logic [Width-1:0]       rs1_data_o,
  output logic [Width-1:0]       rs2_data_o
);

  // Local Declaration
  logic [Width-1:0] registers [0:Size-1];

  // State Register
  always_ff @(posedge clk_i or negedge rst_ni) begin : proc_register
    if (!rst_ni) begin
      for (int i = 0; i < Size; i++)
        registers[i] <= '0;
    end else begin
      if (wr_en_i)
        registers[rd_addr_i] <= rd_data_i;
    end
  end

  // Output Logic
  assign rs1_data_o = registers[rs1_addr_i];
  assign rs2_data_o = registers[rs2_addr_i];

endmodule : regfile
