/*******************************************************************************
Creator:        Hai Cao Xuan - Joachim Cao (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      uni_counter.sv
Design Name:    Universal Counter
Project Name:   Example
Description:    A Counter with three modes: Add 1, Subtract 1, Pause
                to demonstrate FSM

Changelog:      2022.07.07 - first draft

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

`default_nettype none

module uni_counter #(
  parameter int unsigned    Width = 32
) (
  // global
  input logic               clk_i,
  input logic               rst_ni,

  // input
  input logic               en_i,
  input logic               mode_i,

  // output
  output logic [Width-1:0]  data_o
);

  // Local Declaration
  logic [Width-1:0] counter_d;
  logic [Width-1:0] counter_q;

  typedef enum logic [1:0]{
    IDLE  = 2'b00,
    PAUSE = 2'b01,
    ADD   = 2'b10,
    SUB   = 2'b11
  } state_e;
  state_e state_d, state_q;

  // Combinational Logic
  always_comb begin : proc_next_state
    state_d = IDLE;
    if (en_i)
      case (mode_i)
        1'b0: state_d = ADD;
        1'b1: state_d = SUB;
      endcase
    else
        state_d = PAUSE;
  end

  always_comb begin : proc_next_output
    counter_d = '0;
    case (state_q)
      IDLE  : counter_d = '0;
      PAUSE : counter_d = counter_q;
      ADD   : counter_d = counter_q + {{{Width-1}{1'b0}}, 1'b1};
      SUB   : counter_d = counter_q - {{{Width-1}{1'b0}}, 1'b1};
    endcase
  end

  // State Register
  always_ff @(posedge clk_i or negedge rst_ni) begin : proc_register
    if (!rst_ni) begin
      state_q   <= IDLE;
      counter_q <= '0;
    end else begin
      state_q   <= state_d;
      counter_q <= counter_d;
    end
  end

  // Output Logic
  assign data_o = counter_q;

endmodule : uni_counter
