BROWSER=brave-browser-beta

.PHONY: lintd
lintd:
	verilator -Wall -sv --lint-only dff_en.sv

.PHONY: lints
lints:
	verilator -Wall -sv --lint-only dff_sync_2.sv

.PHONY: netd
netd:
	yosys dff_en.ys
	netlistsvg -o dff_en.svg dff_en.json
	$(BROWSER) dff_en.svg

.PHONY: nets
nets:
	yosys dff_sync_2.ys
	netlistsvg -o dff_sync_2.svg dff_sync_2.json
	$(BROWSER) dff_sync_2.svg

.PHONY: clean
clean:
	rm -f *.json *.svg
