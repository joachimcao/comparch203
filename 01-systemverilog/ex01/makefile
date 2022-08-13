BROWSER=brave

.PHONY: lintm2
lintm2:
	verilator -Wall -sv --lint-only mux_2.sv

.PHONY: lintm4
lintm4:
	verilator -Wall -sv --lint-only mux_4.sv

.PHONY: lintm2n
lintm2n:
	verilator -Wall -sv --lint-only mux_2_nbit.sv

.PHONY: lintm4n
lintm4n:
	verilator -Wall -sv --lint-only mux_4_nbit.sv

.PHONY: netm2
netm2:
	yosys mux_2.ys
	netlistsvg -o mux_2.svg mux_2.json
	$(BROWSER) mux_2.svg

.PHONY: netm4
netm4:
	yosys mux_4.ys
	netlistsvg -o mux_4.svg mux_4.json
	$(BROWSER) mux_4.svg

.PHONY: clean
clean:
	rm -f *.json *.svg
