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


elif (opcode==0x63):
    imm11 = (hex_value >> 7) & 0x1
    imm4_1 = (hex_value >> 8) & 0xF
    funct3 = (hex_value >> 12) & 0x7
    rs1 = (hex_value >> 15) & 0x1F
    rs2 = (hex_value >> 20) & 0x1F
    imm10_5 = (hex_value >> 25) & 0x3F
    imm12 = (hex_value >> 31) & 0x1
    immediate = (imm12 << 12) | (imm11 << 11) | (imm10_5 << 5) | (imm4_1 << 1) | 0

    print("imm4_1 : ",imm4_1)
    print("imm10_5 : ",imm10_5)
    print("imm11 : ",imm11)
    print("imm12 : ",imm12)

    if immediate & 0x1000: #checking for bit12 (signbit)
        immediate -= 0x2000 #subtracting by the number which has 1 in bit13

    if (funct3==0):
        print(f"beq x{rs1}, x{rs2}, {immediate}")
    
    elif (funct3==1):
        print(f"bne x{rs1}, x{rs2}, {immediate}")

    elif (funct3==4):
        print(f"blt x{rs1}, x{rs2}, {immediate}")

    elif (funct3==5):
        print(f"bge x{rs1}, x{rs2}, {immediate}")


elif (opcode==0x6F):
    rd = (hex_value >> 7) & 0x1F
    imm19_12 = (hex_value >> 12) & 0xFF
    imm11 = (hex_value >> 20) & 0x1
    imm10_1 = (hex_value >> 21) & 0x3FF
    imm20 = (hex_value >> 31) & 0x1

    offset = (imm20 << 20) | (imm19_12 << 12) | (imm11 << 11) | (imm10_1 << 1) | 0

    if offset & 0x100000:
        offset -= 0x200000

    print(f"jal x{rd}, {offset}")
