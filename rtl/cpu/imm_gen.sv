module imm_gen(
    input logic [31:0] instruction,
    output logic [31:0] imm
);

always_comb begin
    case (instruction[6:0])
        7'b0000011: begin
            imm = {{20{instruction[31]}}, instruction[31:20]};
        end

        7'b0100011: begin
            imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        end

        7'b1100011: begin
            imm = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        end

        default: begin
            imm = 32'b0;
        end
    endcase
end
endmodule
