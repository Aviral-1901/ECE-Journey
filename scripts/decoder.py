hex_value = int(input("Enter hex value of the instruction: "), 16)

opcode = hex_value & 0x0000007F

def get_signed_12bit(imm_unsigned):
    if imm_unsigned >= 2048:
        return imm_unsigned - 4096
    return imm_unsigned

if (opcode==0x33):
    rd = (hex_value >> 7) & 0x1F
    funct3 = (hex_value >> 12) & 0x07
    rs1 = (hex_value >> 15) & 0x1F
    rs2 = (hex_value >> 20) & 0x1F
    funct7 = (hex_value >> 25) & 0x7F
    if (funct7==0):
        if (funct3==0):
            print(f"add x{rd}, x{rs1}, x{rs2}")
        elif (funct3==7):
            print(f"and x{rd}, x{rs1}, x{rs2}")
        elif (funct3==6):
            print(f"or x{rd}, x{rs1}, x{rs2}")
        elif (funct3==4):
            print(f"xor x{rd}, x{rs1}, x{rs2}")
        elif (funct3==2):
            print(f"slt x{rd}, x{rs1}, x{rs2}")
    elif (funct7==0x20):
        if (funct3==0):
            print(f"sub x{rd}, x{rs1}, x{rs2}")

elif (opcode==0x13):
    imm_unsigned = (hex_value >> 20) & 0xFFF
    imm_signed = get_signed_12bit(imm_unsigned)
    rd = (hex_value >> 7) & 0x1F
    funct3 = (hex_value >> 12) & 0x07
    rs1 = (hex_value >> 15) & 0x1F
    rs2 = (hex_value >> 20) & 0x1F

    if (funct3==0):
        print(f"addi x{rd}, x{rs1}, {imm_signed}")
    elif (funct3==7):
        print(f"andi x{rd}, x{rs1}, {imm_signed}")


elif (opcode==0x03):
    imm_unsigned = (hex_value >> 20) & 0xFFF
    imm_signed = get_signed_12bit(imm_unsigned)
    rd = (hex_value >> 7) & 0x1F
    funct3 = (hex_value >> 12) & 0x07
    rs1 = (hex_value >> 15) & 0x1F
    rs2 = (hex_value >> 20) & 0x1F

    if (funct3==2):
        print(f"lw x{rd}, {imm_signed}(x{rs1})")


elif (opcode==0x23):
    imm_upper = (hex_value >> 25) & 0x7F
    rs2 = (hex_value >> 20) & 0x1F
    rs1 = (hex_value >> 15) & 0x1F
    funct3 = (hex_value >> 12) & 0x07
    imm_lower = (hex_value >> 7) & 0x1F
    imm_unsigned = (imm_upper << 5) + imm_lower
    imm_signed = get_signed_12bit(imm_unsigned)

    if (funct3==2):
        print(f"sw x{rs2}, {imm_signed}(x{rs1})")
