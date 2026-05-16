IVERILOG = iverilog
VVP = vvp

RTL = rtl
TB = tb
SIM = sim

FLAGS = -g2012

test_and:
	$(IVERILOG) $(FLAGS) -o $(SIM)/gates/and_sim $(RTL)/gates/and_gate.v $(TB)/gates/and_gate_tb.v
	$(VVP) $(SIM)/gates/and_sim

test_or:
	$(IVERILOG) $(FLAGS) -o $(SIM)/gates/or_sim $(RTL)/gates/or_gate.v $(TB)/gates/or_gate_tb.v
	$(VVP) $(SIM)/gates/or_sim

test_xor:
	$(IVERILOG) $(FLAGS) -o $(SIM)/gates/xor_sim $(RTL)/gates/xor_gate.v $(TB)/gates/xor_gate_tb.v
	$(VVP) $(SIM)/gates/xor_sim

test_majority:
	$(IVERILOG) $(FLAGS) -o $(SIM)/gates/majority_sim $(RTL)/gates/majority_voter.v $(TB)/gates/majority_voter_tb.v
	$(VVP) $(SIM)/gates/majority_sim

test_gates: test_and test_or test_xor test_majority