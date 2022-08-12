/*******************************************************************************
Creator:        Hai Cao Xuan (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      button_buffer.sv
Design Name:    Button Buffer
Project Name:   Simple Protocol
Description:    Arithmetic Logic Unit

Changelog:      05.08.2022 - First draft, v0.1

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

`default_nettype none

module button_buffer
//import *;
(
  // Input
  input logic clk_i,
  input logic button_i,
  // Output
  output logic stable_o
);

  typedef enum logic [1:0] {
    IDLE  = 2'b00,
    HOLD  = 2'b01,
    PRESS = 2'b10
  } state_e;
  state_e state_d;
  state_e state_q;

  always_comb begin
    /* verilator lint_off CASEINCOMPLETE */
    case (state_q)
      IDLE:    state_d = button_i ? PRESS : IDLE;
      PRESS:   state_d = button_i ? HOLD  : IDLE;
      HOLD:    state_d = button_i ? HOLD  : IDLE;
      default: state_d = IDLE;
    endcase
    /* verilator lint_on CASEINCOMPLETE */
  end

  always_ff @(posedge clk_i) begin
    state_q <= state_d;
  end

  assign stable_o = (state_q == PRESS) ? 1'b1 : 1'b0;

endmodule : button_buffer
