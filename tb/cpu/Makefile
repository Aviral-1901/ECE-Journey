SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += ../../rtl/cpu/alu.sv

TOPLEVEL = alu
MODULE = test_alu

COMPILE_ARGS += -DALU_ASSERT
include $(shell cocotb-config --makefiles)/Makefile.sim