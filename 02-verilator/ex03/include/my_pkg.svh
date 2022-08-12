/*******************************************************************************
Creator:        Hai Cao Xuan (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      my_pkg.svh
Design Name:    My Package
Project Name:   Computer Architecture Examples
Description:    Package of configuration and defines

Changelog:      06.07.2022 - First draft, v0.1

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

package my_pkg;

  typedef enum logic [1:0] {
    A_NOP = 2'b00,
    A_ADD = 2'b01,
    A_OR  = 2'b10,
    A_AND = 2'b11
  } alu_op_e /*verilator public*/;

endpackage : my_pkg
