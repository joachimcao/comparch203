#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cstdlib>
#include <string>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vtop.h"
#include "Vtop_my_pkg.h"

#define MAX_SIM       20
vluint64_t sim_unit = 0;

int main(int argc, char **argv, char **env) {
	// Call commandArgs first!
	Verilated::commandArgs(argc, argv);

  // Instantiate our design
	Vtop *dut = new Vtop;

  // Check procedure
  // 1. Set initial values
  sim_unit = 0;
  // 2. Set test values
  dut->alu_op = 0;
  dut->dvalid = 1;
  dut->data_a = 0x1d;
  dut->data_b = 0x3a;
  dut->eval();
  // 3. Monitor output values
  printf("@%2d: %1b %2b %3x %3x ", sim_unit, dut->dvalid, dut->alu_op, dut->data_a, dut->data_b);
  printf("** RECEIVED %3x %1b \n", dut->result, dut->rvalid);

  sim_unit++;
  dut->alu_op = 1;
  dut->dvalid = 1;
  dut->data_a = 0x5e;
  dut->data_b = 0x12;
  dut->eval();
  printf("@%2d: %1b %2b %3x %3x ", sim_unit, dut->dvalid, dut->alu_op, dut->data_a, dut->data_b);
  printf("** RECEIVED %3x %1b \n", dut->result, dut->rvalid);

  sim_unit++;
  dut->alu_op = 2;
  dut->dvalid = 1;
  dut->data_a = 0x89;
  dut->data_b = 0x30;
  dut->eval();
  printf("@%2d: %1b %2b %3x %3x ", sim_unit, dut->dvalid, dut->alu_op, dut->data_a, dut->data_b);
  printf("** RECEIVED %3x %1b \n", dut->result, dut->rvalid);

  sim_unit++;
  dut->alu_op = 3;
  dut->dvalid = 1;
  dut->data_a = 0xca;
  dut->data_b = 0xac;
  dut->eval();
  printf("@%2d: %1b %2b %3x %3x ", sim_unit, dut->dvalid, dut->alu_op, dut->data_a, dut->data_b);
  printf("** RECEIVED %3x %1b \n", dut->result, dut->rvalid);

  sim_unit++;
  dut->alu_op = 2;
  dut->dvalid = 0;
  dut->data_a = 0xde;
  dut->data_b = 0xaf;
  dut->eval();
  printf("@%2d: %1b %2b %3x %3x ", sim_unit, dut->dvalid, dut->alu_op, dut->data_a, dut->data_b);
  printf("** RECEIVED %3x %1b \n", dut->result, dut->rvalid);

  delete dut;
  exit(EXIT_SUCCESS);
}
