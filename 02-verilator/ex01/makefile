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

TOPMODULE=top
FILES := include/my_pkg.svh \
						src/alu.sv

.PHONY: help
help:
	@echo -e "make [option]"
	@echo -e "\tlint    run lint checks for syntax and violations"
	@echo -e "\tsview   view schematics"
	@echo -e "\tbuild   verilate and build modules"
	@echo -e "\tsim     run simulation"
	@echo -e "\tclean   clean the working folder"
	@echo -e "\thelp    print this help"

.PHONY: all
all: lint sim

.PHONY: sview
sview: $(TOPMODULE).svg
	brave-browser-beta $(TOPMODULE).svg

$(TOPMODULE).svg: $(TOPMODULE).ys
	yosys $(TOPMODULE).ys
	netlistsvg -o $(TOPMODULE).svg $(TOPMODULE).json

.PHONY: lint
lint:
	@echo -e "-> LINTING"
	verilator -Wall -sv --lint-only $(FILES) $(TOPMODULE).sv --top-module $(TOPMODULE)

.PHONY: build
build: ./obj_dir/V$(TOPMODULE)
./obj_dir/V$(TOPMODULE): $(FILES) $(TOPMODULE).sv tb_$(TOPMODULE).cpp
	@echo -e "[1] -> VERILATING"
	verilator -Wall -sv -cc $(FILES) $(TOPMODULE).sv --top-module $(TOPMODULE) --exe tb_$(TOPMODULE).cpp
	@echo -e "[2] -> BUILDING"
	make -C obj_dir -f V$(TOPMODULE).mk V$(TOPMODULE)

.PHONY: sim
sim: ./obj_dir/V$(TOPMODULE)
	@echo -e "-> SIMULATING"
	./obj_dir/V$(TOPMODULE)

.PHONY: clean
clean:
	rm -rf obj_dir/
	rm -f *.vcd
	rm -f *.json
	rm -f *.svg
