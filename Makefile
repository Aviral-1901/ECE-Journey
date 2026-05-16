IVERILOG = iverilog
VVP = vvp

RTL = rtl
TB = tb
SIM = sim

FLAGS = -g2012

test_and:
	gi$(IVERILOG) $(FLAGS) -o $(SIM)/gates/and_sim $(RTL)/gates/and_gate.v $(TB)/gates/and_gate_tb.v
	$(VVP) $(SIM)/gates/and_sim