import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_alu_sub(dut):
    dut.a.value = 10
    dut.b.value = 3
    dut.alu_op.value = 0b0001

    await Timer(1, units="ns")

    actual_result = int(dut.result.value)
    expected_result = (10 - 3) % (2**32)

    assert actual_result == expected_result, f"FAIL: expected = {expected_result} and actual = {actual_result}"