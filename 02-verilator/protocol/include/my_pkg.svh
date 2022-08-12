/*******************************************************************************
Creator:        Hai Cao Xuan (caoxuanhaipr@gmail.com)

Additional Contributions by:

File Name:      my_pkg.svh
Design Name:    My Package
Project Name:   Simple Protocol
Description:    Package of configuration and defines

Changelog:      05.08.2022 - First draft, v0.1

********************************************************************************
Copyright (c) 2022 Hai Cao Xuan
*******************************************************************************/

package my_pkg;

  typedef enum logic[1:0] {
    IDLE  = 2'b00,
    PRESS = 2'b01,
    HOLD  = 2'b10
  } state_e /* verilator public */;

endpackage : my_pkg
