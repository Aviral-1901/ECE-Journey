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


async def test_alu_op(dut, a, b, alu_op, expected_result):
    dut.a.value = a
    dut.b.value = b
    dut.alu_op.value = alu_op
    await Timer(1, units="ns")
    actual_result = int(dut.result.value)
    assert actual_result == expected_result, f"FAIL: expected = {expected_result} and actual = {actual_result}"

@cocotb.test()
async def test_alu_sub_multiple(dut):
    alu_op = 0b0001

    expected_result = (10-3) % (2**32)
    await test_alu_op(dut,10,3,alu_op,expected_result)

    expected_result = (0-1) % (2**32)
    await test_alu_op(dut,0,1,alu_op,expected_result)

    expected_result = (5-5) % (2**32)
    await test_alu_op(dut,5,5,alu_op,expected_result)


@cocotb.test()
async def test_alu_add(dut):
    alu_op = 0b0000

    expected_result = (10+3) % (2**32)
    await test_alu_op(dut,10,3,alu_op,expected_result)

@cocotb.test()
async def test_alu_and(dut):
    alu_op = 0b0010

    expected_result = 10 & 3
    await test_alu_op(dut,10,3,alu_op,expected_result)

@cocotb.test()
async def test_alu_or(dut):
    alu_op = 0b0011

    expected_result = 10 | 3
    await test_alu_op(dut,10,3,alu_op,expected_result)

@cocotb.test()
async def test_alu_xor(dut):
    alu_op = 0b0100

    expected_result = 10 ^ 3
    await test_alu_op(dut,10,3,alu_op,expected_result)

@cocotb.test()
async def test_alu_sll(dut):
    alu_op = 0b0101
    a = 9
    b = 33

    expected_result = (a << (b%32)) % (2**32)
    await test_alu_op(dut,a,b,alu_op,expected_result)

@cocotb.test()
async def test_alu_srl(dut):
    alu_op = 0b0110
    a = 18
    b = 6

    expected_result = (a >> (b%32))
    await test_alu_op(dut,a,b,alu_op,expected_result)

@cocotb.test()
async def test_alu_sra(dut):
    alu_op = 0b1000
    a = 4294967295
    b = 6
    a_signed = a - 2**32 if a >= 2**31 else a
    expected_result = (a_signed >> (b%32)) % (2**32)
    await test_alu_op(dut,a,b,alu_op,expected_result)

@cocotb.test()
async def test_alu_slt(dut):
    alu_op = 0b0111
    a = 4294967295
    b = 1
    a_signed = a - 2**32 if a >= 2**31 else a
    b_signed = b - 2**32 if b >= 2**31 else b

    expected_result = 1 if a_signed < b_signed else 0
    await test_alu_op(dut,a,b,alu_op,expected_result)

@cocotb.test()
async def test_alu_sltu(dut):
    alu_op = 0b1001
    a = 4294967290
    b = 1

    expected_result = 1 if a < b else 0
    await test_alu_op(dut,a,b,alu_op,expected_result)