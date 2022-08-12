`default_nettype none

module top (
  input logic  clk_i,
  input logic  button_i,
  output logic stable_o
);


  button_buffer bb0 (
    .clk_i   (clk_i),
    .button_i(button_i),
    .stable_o(stable_o)
  );

endmodule : top
