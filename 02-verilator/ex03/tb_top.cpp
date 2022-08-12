#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cstdlib>
#include <string>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <verilated_fst_c.h>
#include "Vtop.h"
#include "Vtop_my_pkg.h"

#define MAX_SIM       1000000
vluint64_t sim_unit = 0;
vluint64_t sim_time = 0;
uint8_t x_result    = 0;
uint8_t x_result_q0 = 0;
uint8_t x_result_q1 = 0;
uint8_t x_rvalid    = 0;
uint8_t x_rvalid_q0 = 0;
uint8_t x_rvalid_q1 = 0;

void dut_clock(Vtop *dut, VerilatedFstC *vtrace);
void set_reset(Vtop *dut);
void set_random(Vtop *dut);
void get_expected(Vtop *dut);
void monitor_proc(Vtop *dut);
void monitor_outputs(Vtop *dut);

void initial(Vtop *dut) {
}

void dut_clock(Vtop *dut, VerilatedFstC *vtrace) {
  sim_time = sim_unit * 10 + 2;
  if (vtrace)
    vtrace->dump(sim_time); // Dump values to update inputs

  sim_time = sim_time + 3;
  dut->clk_i = 0;
  dut->eval();
  if (vtrace)
    vtrace->dump(sim_time); // Dump values after negedge

  monitor_outputs(dut);        // Values are "stable" to monitor

  sim_time = sim_time + 5;
  dut->clk_i = 1;
  dut->eval();
  if (vtrace) {
    vtrace->dump(sim_time); // Dump values after posedge
    //vtrace->flush();
  }
}

void set_reset(Vtop *dut) {
  if ((sim_unit < 5) || (sim_unit > 10))
    dut->rst_ni = 1;
  else
    dut->rst_ni = 0;
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
    x_rvalid = 0;
  }
  else
    switch (dut->alu_op){
      case Vtop_my_pkg::alu_op_e::A_NOP:
        x_result = 0;
        x_rvalid = 1;
        break;

      case Vtop_my_pkg::alu_op_e::A_ADD:
        x_result = dut->data_a + dut->data_b;
        x_rvalid = 1;
        break;

      case Vtop_my_pkg::alu_op_e::A_OR:
        x_result = dut->data_a | dut->data_b;
        x_rvalid = 1;
        break;

      case Vtop_my_pkg::alu_op_e::A_AND:
        x_result = dut->data_a & dut->data_b;
        x_rvalid = 1;
        break;
    }
}

void monitor_proc(Vtop *dut) {
  // Second DFF
  if (!dut->rst_ni) {
    x_result_q1 = 0;
    x_rvalid_q1 = 0;
  } else {
    x_result_q1 = x_result_q0;
    x_rvalid_q1 = x_rvalid_q0;
  }
  // First DFF
  if (!dut->rst_ni) {
    x_result_q0 = 0;
    x_rvalid_q0 = 0;
  } else {
    x_result_q0 = x_result;
    x_rvalid_q0 = x_rvalid;
  }
}

void monitor_outputs(Vtop *dut) {
  printf("@%3d: ", sim_unit);
  printf("RECEIVED  %2x  %1b : ", dut->result, dut->rvalid);
  printf("EXPECTED  %2x  %1b ", x_result_q1, x_rvalid_q1);

  if ((dut->result != x_result_q1) || (dut->rvalid != x_rvalid_q1))
    printf(" <= FAIL\n");
  else
    printf("\n");
}

int main(int argc, char **argv, char **env) {
	// Call commandArgs first!
	Verilated::commandArgs(argc, argv);

  // Instantiate the design
	Vtop *dut = new Vtop;

  // Trace generating
  Verilated::traceEverOn(true);
  VerilatedFstC *vtrace = new VerilatedFstC;
  dut->trace(vtrace, 2); // trace down to 2 hierarchy
  vtrace->open("top.fst");
  vtrace->dump(0);

  // Initial setups
  srand(time(NULL));
  initial(dut);
  dut->eval();

  // Check procedure
  while (sim_unit < MAX_SIM){
    dut_clock(dut, vtrace);
    monitor_proc(dut);
    set_random(dut);
    get_expected(dut);
    set_reset(dut);
    sim_unit++;
	}

  vtrace->close();
  delete dut;
  exit(EXIT_SUCCESS);
}
