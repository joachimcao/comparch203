#*******************************************************************************
# Creator:        Hai Cao Xuan (caoxuanhaipr@gmail.com)
#
# Additional Contributions by:
#
# File Name:      makefile
# Project Name:   Example
#
#*******************************************************************************
# Copyright (c) 2022 Hai Cao Xuan
#*******************************************************************************

TOPMODULE = top
FILES := include/my_pkg.svh \
				 src/button_buffer.sv \
				 src/counter.sv \
				 src/master.sv

VERILATOR = verilator
VERILATOR_COV = verilator_coverage
BROWSER = brave-beta

### LINT FLAGS
LINT_FLAGS = -Wall --lint-only -sv

### VERILATE FLAGS
# Generate C++ in executable form
VERILATOR_FLAGS += -sv -cc
# Optimize
#VERILATOR_FLAGS += -x-initial unique
#VERILATOR_FLAGS += -x-assign unique
VERILATOR_FLAGS += -O3 -CFLAGS -DCOVERAGE
# Warn abount lint issues; may not want this on less solid designs
VERILATOR_FLAGS += -Wall
# Make waveforms
VERILATOR_FLAGS += --trace-fst
# Check SystemVerilog assertions
#VERILATOR_FLAGS += --assert
# Generate coverage analysis
VERILATOR_FLAGS += --coverage
#VERILATOR_FLAGS += --coverage-line
#VERILATOR_FLAGS += --coverage-toggle
#VERILATOR_FLAGS += --coverage-user
# Run make to compile model, with as many CPUs as are free
VERILATOR_FLAGS += --build -j

### COVERAGE FLAGS
COV_DIR = logs/annotated
LCOV_FILE = logs/coverage.info
HTML_DIR = logs/html
COV_FLAGS += --annotate $(COV_DIR)
COV_FLAGS += --write-info $(LCOV_FILE) logs/coverage.dat
# Set minimum coverage hits
COV_FLAGS += --annotate-min 1

# Input files for Verilator
VERILATOR_INPUT = $(FILES) $(TOPMODULE).sv --top-module $(TOPMODULE)


.PHONY: help
help:
	@echo -e "make [option]"
	@echo -e "\tlint    run lint checks for syntax and violations"
	@echo -e "\tbuild   verilate and build modules"
	@echo -e "\tsim     run simulation"
	@echo -e "\tcov     check coverage"
	@echo -e "\twave    open waveforms"
	@echo -e "\tclean   clean the working folder"
	@echo -e "\thelp    print this help"

.PHONY: all
all: lint sim

.PHONY: lint
lint:
	@echo -e "-> LINTING"
	$(VERILATOR) $(LINT_FLAGS) $(VERILATOR_INPUT)

.PHONY: build
build: ./obj_dir/V$(TOPMODULE)
./obj_dir/V$(TOPMODULE): $(FILES) $(TOPMODULE).sv tb_$(TOPMODULE).cpp
	@echo -e "-> BUILDING"
	$(VERILATOR) $(VERILATOR_FLAGS) $(VERILATOR_INPUT) --exe tb_$(TOPMODULE).cpp

.PHONY: sim
sim: ./obj_dir/V$(TOPMODULE)
	@echo -e "-> SIMULATING"
	./obj_dir/V$(TOPMODULE)

.PHONY: cov
cov:
	@echo -e "-> COVERAGE"
	$(VERILATOR_COV) $(COV_FLAGS)
	genhtml $(LCOV_FILE) --output-directory $(HTML_DIR)

.PHONY: wave
wave: $(TOPMODULE).fst
	@echo -e "-> WAVEFORMS"
	@gtkwave $(TOPMODULE).fst wave.gtkw

.PHONY: clean
clean:
	rm -rf obj_dir logs
	rm -f *.fst
	rm -f *.json
	rm -f *.svg
