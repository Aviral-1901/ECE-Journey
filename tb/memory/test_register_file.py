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

@cocotb.test()
async def test_write_two_regs(dut):
    cocotb.start_soon(Clock(dut.clk, 10, unit='ns').start())
    register = [0] + [None]*31
    reg_num1 = 10
    reg_num2 = 20
    dut.read_address1.value = reg_num1
    dut.read_address2.value = reg_num2
    await RisingEdge(dut.clk)
    dut.write_enable.value = 1
    dut.write_address.value = reg_num1
    dut.write_data.value = 111
    await RisingEdge(dut.clk)
    dut.write_address.value = reg_num2
    dut.write_data.value = 222
    register[reg_num1] = 111
    register[reg_num2] = 222
    await RisingEdge(dut.clk)
    await Timer(1, unit='ns')
    actual_reg1 = int(dut.read_data1.value)
    actual_reg2 = int(dut.read_data2.value)

    assert (actual_reg1 == register[reg_num1] and actual_reg2 == register[reg_num2]), f"Register={reg_num1}: expected={register[reg_num1]} and actual={actual_reg1}, Register={reg_num2}: expected={register[reg_num2]} and actual={actual_reg2}"


@cocotb.test()
async def test_write_enable_off(dut):
    cocotb.start_soon(Clock(dut.clk, 10, unit='ns').start())
    register = [0] + [None]*31
    reg_num = 9
    await RisingEdge(dut.clk)
    dut.write_enable.value = 1
    dut.write_address.value = reg_num
    dut.write_data.value = 444
    register[reg_num] = 444
    await RisingEdge(dut.clk)
    dut.write_enable.value = 0
    dut.write_address.value = reg_num
    dut.write_data.value = 888
    dut.read_address1.value = reg_num
    await RisingEdge(dut.clk)
    await Timer (1, unit='ns')
    actual = int(dut.read_data1.value)

    assert actual == register[reg_num], f"FAIL: register={reg_num}, expected={register[reg_num]} and actual={actual}"