import cocotb
from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock

@cocotb.test()
async def test_write_then_read(dut):
    cocotb.start_soon(Clock(dut.clk, 10, unit="ns").start())
    register = [0] + [None] * 31
    reg_num = 5
    await RisingEdge(dut.clk)
    dut.write_enable.value = 1
    dut.write_address.value = reg_num
    dut.write_data.value = 42
    dut.read_address1.value = reg_num
    register[reg_num] = 42
    await RisingEdge(dut.clk)
    await Timer(1, unit="ns")
    actual = int(dut.read_data1.value)

    assert (actual == register[5]) ,f"FAIL: register= {reg_num}, expected={register[5]} and actual={actual}"


@cocotb.test()
async def test_write_x0(dut):
    cocotb.start_soon(Clock(dut.clk, 10, unit='ns').start())
    register = [0] + [None]*31
    reg_num = 0
    await RisingEdge(dut.clk)
    dut.write_enable.value = 1
    dut.write_address.value = reg_num
    dut.write_data.value = 99
    dut.read_address1.value = reg_num
    register[reg_num] = 0
    await RisingEdge(dut.clk)
    await Timer(1, unit="ns")
    actual = int(dut.read_data1.value)

    assert (actual == register[reg_num]) ,f"FAIL: register= {reg_num}, expected={register[reg_num]} and actual={actual}"    