module control_unit(
    input logic [6:0] opcode,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    output logic RegWrite,
    output logic MemWrite,
    output logic MemToReg,
    output logic ALUSrc,
    output logic branch,
    output logic [3:0] alu_op
);

logic [3:0] rtype_selector;
assign rtype_selector = {funct7[6], funct3};


always_comb begin
    RegWrite=0; MemWrite=0; ALUSrc=0; MemToReg=0; branch=0; alu_op=4'b0000;
    case (opcode)
        7'b0110011: begin //r-type
            RegWrite=1; MemWrite=0; ALUSrc=0; MemToReg=0; branch=0;
            case(rtype_selector)  
                4'b0000: alu_op = 4'b0000; // ADD
                4'b1000: alu_op = 4'b0001; // SUB
                4'b0111: alu_op = 4'b0010; // AND
                4'b0110: alu_op = 4'b0011; // OR
                4'b0100: alu_op = 4'b0100; // XOR
                4'b0001: alu_op = 4'b0101; // SLL
                4'b0101: alu_op = 4'b0110; // SRL
                4'b0010: alu_op = 4'b0111; // SLT
            endcase
        end

        7'b0010011: begin // I-type ALU (addi, etc)
            RegWrite=1; MemWrite=0; ALUSrc=1; MemToReg=0; branch=0;
            case(funct3)
                3'b000: alu_op = 4'b0000; // ADDI
                3'b111: alu_op = 4'b0010; // ANDI
                3'b110: alu_op = 4'b0011; // ORI
                3'b100: alu_op = 4'b0100; // XORI
                3'b001: alu_op = 4'b0101; // SLLI
                3'b101: alu_op = 4'b0110; // SRLI
                3'b010: alu_op = 4'b0111; // SLTI
                default: alu_op = 4'b0000;
            endcase
        end


        7'b0000011: begin //lw
            RegWrite=1; MemWrite=0; ALUSrc=1; MemToReg=1; branch=0; alu_op=4'b0000;
        end

        7'b0100011: begin //sw
            RegWrite=0; MemWrite=1; ALUSrc=1; MemToReg=0; branch=0; alu_op=4'b0000;
        end
        
        7'b1100011: begin //beq
            RegWrite=0; MemWrite=0; ALUSrc=0; MemToReg=0; branch=1; alu_op=4'b0001;
        end

        default: begin
            RegWrite=0; MemWrite=0; ALUSrc=0; MemToReg=0; branch=0; alu_op=4'b0000;
        end
    endcase
end
endmodule
