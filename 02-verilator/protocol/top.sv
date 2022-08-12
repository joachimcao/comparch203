`default_nettype none

module top (
  // Input
  input logic clk_i,
  input logic button_i,
  // Output
  output logic [3:0] counter_o
);

  logic req /* verilator public*/;
  logic busy /* verilator public*/;
  logic [3:0] counter /* verilator public*/;

  master master0 (
    .clk_i    (clk_i),
    .counter_i(counter),
    .busy_i   (busy),
    .button_i (button_i),
    .req_o    (req),
    .counter_o(counter_o)
  );

  counter counter0 (
    .clk_i    (clk_i),
    .req_i    (req),
    .counter_o(counter),
    .busy_o   (busy)
  );

endmodule : top
