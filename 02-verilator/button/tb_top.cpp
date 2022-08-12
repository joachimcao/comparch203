#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cstdlib>
#include <string>
#include <iostream>
#include <verilated.h>
#include <verilated_fst_c.h>
#include "Vtop.h"
#include "Vtop_my_pkg.h"

#define MAX_SIM       100
vluint64_t sim_unit = 0;
vluint64_t sim_time = 0;
uint8_t past     = 0;
uint8_t past_1     = 0;
uint8_t x_stable = 0;

void dut_clock(Vtop *dut, VerilatedFstC *vtrace);
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

void set_random(Vtop *dut) {
  past_1 = past;
  past = dut->button_i;
  dut->button_i = (rand()%5 > 1);
  dut->eval();
}

void get_expected(Vtop *dut) {
  x_stable = (~past_1) & (past);
}

void monitor_proc(Vtop *dut) {
}

void monitor_outputs(Vtop *dut) {
  printf("@%3d: ", sim_unit);
  printf("INPUT  %1b : ", dut->button_i);
  printf("RECEIVED  %1b : ", dut->stable_o);
  printf("EXPECTED  %1b ", x_stable);

  if (dut->stable_o != x_stable)
    printf(" <= FAIL\n");
  else
    printf("\n");
}

int main(int argc, char **argv, char **env) {
	// Call commandArgs first!
	Verilated::commandArgs(argc, argv);

Verilated::mkdir("logs");
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
    set_random(dut);
    monitor_proc(dut);
    get_expected(dut);
    sim_unit++;
	}

  vtrace->close();
#if VM_COVERAGE
    Verilated::mkdir("logs");
    Verilated::threadContextp()->coveragep()->write("logs/coverage.dat");
#endif
  delete dut;
  exit(EXIT_SUCCESS);
}
