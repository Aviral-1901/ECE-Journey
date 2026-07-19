module imm_gen(
    input logic [31:0] instruction,
    output logic [31:0] imm
);

logic [6:0] opcode;
assign opcode = instruction[6:0];

logic [31:0] i_type_imm;
logic [31:0] s_type_imm;
logic [31:0] b_type_imm;
logic [31:0] j_type_imm;

assign i_type_imm = {{20{instruction[31]}}, instruction[31:20]};
assign s_type_imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
assign b_type_imm = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
assign j_type_imm = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};

always_comb begin
    case (opcode)
        7'b0000011: begin //lw
            imm = i_type_imm;
        end

        7'b0010011: begin // I-Type ALU (addi, etc.)
            imm = i_type_imm;
        end

        7'b0100011: begin //sw
            imm = s_type_imm;
        end

        7'b1100011: begin //b-type
            imm = b_type_imm;
        end
        
        7'b1101111: begin //j-type
            imm = j_type_imm;
        end

        default: begin
            imm = 32'b0;
        end
    endcase
end
endmodule
