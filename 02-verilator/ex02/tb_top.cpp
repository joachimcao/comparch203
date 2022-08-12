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
uint8_t    x_result = 0;
uint8_t    x_valid  = 0;

void initial(Vtop *dut) {
}

void set_random(Vtop *dut) {
  dut->data_a = rand();
  dut->data_b = rand();
  dut->alu_op = rand()%4;
  dut->dvalid = rand()%2;
  dut->eval();
}

void get_expected(Vtop *dut) {
  if (!dut->dvalid) {
    x_result = 0;
    x_valid  = 0;
  }
  else
    switch (dut->alu_op){
      case Vtop_my_pkg::alu_op_e::A_NOP:
        x_result = 0;
        x_valid  = 1;
        break;

      case Vtop_my_pkg::alu_op_e::A_ADD:
        x_result = dut->data_a + dut->data_b;
        x_valid  = 1;
        break;

      case Vtop_my_pkg::alu_op_e::A_OR:
        x_result = dut->data_a | dut->data_b;
        x_valid  = 1;
        break;

      case Vtop_my_pkg::alu_op_e::A_AND:
        x_result = dut->data_a & dut->data_b;
        x_valid  = 1;
        break;
    }
}

void monitor_outputs(Vtop *dut) {
  printf("@%3d:  %2x  %2x  %2b  %1b ", sim_unit, dut->data_a, dut->data_b, dut->alu_op, dut->dvalid);
  printf(": RECEIVED  %2x  %1b ", dut->result, dut->rvalid);
  printf(": EXPECTED  %2x  %1b ", x_result, x_valid);

  if ((dut->result != x_result) || (dut->rvalid != x_valid))
    printf(" <= FAIL\n");
  else
    printf("\n");
}

int main(int argc, char **argv, char **env) {
	// Call commandArgs first!
	Verilated::commandArgs(argc, argv);

  // Instantiate our design
	Vtop *dut = new Vtop;

  // Initial setup
  srand(time(NULL));
  initial(dut);
  dut->eval();

  printf("Time:  A   B   Op  V : RECEIVED   R  V : EXPECTED   R  V\n");

  // Check procedure
  while (sim_unit < MAX_SIM){
    set_random(dut);
    get_expected(dut);
    monitor_outputs(dut);
    sim_unit++;
	}

  delete dut;
  exit(EXIT_SUCCESS);
}
