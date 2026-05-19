IVERILOG = iverilog
VVP = vvp

RTL = rtl
TB = tb
SIM = sim

FLAGS = -g2012

setup:
	mkdir -p sim/gates sim/combinational sim/arithmetic sim/sequential

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

test_mux2to1:
	$(IVERILOG) $(FLAGS) -o $(SIM)/combinational/mux_2to1_sim $(RTL)/combinational/mux_2to1_ternary.v $(TB)/combinational/mux_2to1_tb.v
	$(VVP) $(SIM)/combinational/mux_2to1_sim

test_mux4to1:
	$(IVERILOG) $(FLAGS) -o $(SIM)/combinational/mux_4to1_sim $(RTL)/combinational/mux_4to1.v $(TB)/combinational/mux_4to1_tb.v
	$(VVP) $(SIM)/combinational/mux_4to1_sim

test_decoder2to4:
	$(IVERILOG) $(FLAGS) -o $(SIM)/combinational/decoder_2to4_sim $(RTL)/combinational/decoder_2to4.v $(TB)/combinational/decoder_2to4_tb.v
	$(VVP) $(SIM)/combinational/decoder_2to4_sim

test_combinational: test_mux2to1 test_mux4to1 test_decoder2to4


test_half_adder:
	$(IVERILOG) $(FLAGS) -o $(SIM)/arithmetic/half_adder_sim $(RTL)/arithmetic/half_adder.v $(TB)/arithmetic/half_adder_tb.v
	$(VVP) $(SIM)/arithmetic/half_adder_sim

test_full_adder:
	$(IVERILOG) $(FLAGS) -o $(SIM)/arithmetic/full_adder_sim \
		$(RTL)/arithmetic/half_adder.v \
		$(RTL)/arithmetic/full_adder.v \
		$(TB)/arithmetic/full_adder_tb.v
	$(VVP) $(SIM)/arithmetic/full_adder_sim

test_ripple_carry_adder:
	$(IVERILOG) $(FLAGS) -o $(SIM)/arithmetic/ripple_carry_adder_sim \
		$(RTL)/arithmetic/half_adder.v \
		$(RTL)/arithmetic/full_adder.v \
		$(RTL)/arithmetic/ripple_carry_adder.v \
		$(TB)/arithmetic/ripple_carry_adder_tb.v
	$(VVP) $(SIM)/arithmetic/ripple_carry_adder_sim

test_adder_subtractor:
	$(IVERILOG) $(FLAGS) -o $(SIM)/arithmetic/adder_subtractor_sim \
		$(RTL)/arithmetic/half_adder.v \
		$(RTL)/arithmetic/full_adder.v \
		$(RTL)/arithmetic/adder_subtractor.v \
		$(TB)/arithmetic/adder_subtractor_tb.v
	$(VVP) $(SIM)/arithmetic/adder_subtractor_sim

test_adder_subtractor_sv:
	$(IVERILOG) $(FLAGS) -o $(SIM)/arithmetic/adder_subtractor_sv_sim \
		$(RTL)/arithmetic/half_adder.v \
		$(RTL)/arithmetic/full_adder.v \
		$(RTL)/arithmetic/adder_subtractor.sv \
		$(TB)/arithmetic/adder_subtractor_tb.sv
	$(VVP) $(SIM)/arithmetic/adder_subtractor_sv_sim

test_arithmetic: test_half_adder test_full_adder test_ripple_carry_adder test_adder_subtractor test_adder_subtractor_sv


test_sr_latch:
	$(IVERILOG) $(FLAGS) -o $(SIM)/sequential/sr_latch_sim $(RTL)/sequential/sr_latch.sv $(TB)/sequential/sr_latch_tb.sv
	$(VVP) $(SIM)/sequential/sr_latch_sim

test_d_latch:
	$(IVERILOG) $(FLAGS) -o $(SIM)/sequential/d_latch_sim $(RTL)/sequential/d_latch.sv $(TB)/sequential/d_latch_tb.sv
	$(VVP) $(SIM)/sequential/d_latch_sim

test_d_flipflop:
	$(IVERILOG) $(FLAGS) -o $(SIM)/sequential/d_flipflop_sim $(RTL)/sequential/d_flipflop.sv $(TB)/sequential/d_flipflop_tb.sv
	$(VVP) $(SIM)/sequential/d_flipflop_sim

test_register_4bit:
	$(IVERILOG) $(FLAGS) -o $(SIM)/sequential/register_4bit_sim $(RTL)/sequential/register_4bit.sv $(TB)/sequential/register_4bit_tb.sv
	$(VVP) $(SIM)/sequential/register_4bit_sim

test_counter_4bit:
	$(IVERILOG) $(FLAGS) -o $(SIM)/sequential/counter_4bit_sim $(RTL)/sequential/counter_4bit.sv $(TB)/sequential/counter_4bit_tb_clkedge.sv
	$(VVP) $(SIM)/sequential/counter_4bit_sim

test_sequential: test_sr_latch test_d_latch test_d_flipflop test_register_4bit test_counter_4bit


test: setup test_gates test_combinational test_arithmetic test_sequential

clean:
	rm -rf $(SIM)/gates/*
	rm -rf $(SIM)/combinational/*
	rm -rf $(SIM)/arithmetic/*
	rm -rf $(SIM)/sequential/*

wave:
	$(VVP) $(SIM)/sequential/$(MOD)_sim
	gtkwave $(SIM)/sequential/$(MOD).vcd
