module control_unit(
    input logic [6:0] opcode,
    output logic RegWrite,
    output logic MemWrite,
    output logic MemToReg,
    output logic ALUSrc,
    output logic branch
);

always_comb begin
    RegWrite=0; MemWrite=0; ALUSrc=0; MemToReg=0; branch=0;
    case (opcode)
        7'b0110011: begin
            RegWrite=1; MemWrite=0; ALUSrc=0; MemToReg=0; branch=0;
        end

        7'b0000011: begin
            RegWrite=1; MemWrite=0; ALUSrc=1; MemToReg=1; branch=0;
        end

        7'b0100011: begin
            RegWrite=0; MemWrite=1; ALUSrc=1; MemToReg=0; branch=0;
        end
        
        7'b1100011: begin
            RegWrite=0; MemWrite=0; ALUSrc=0; MemToReg=0; branch=1;
        end

        default: begin
            RegWrite=0; MemWrite=0; ALUSrc=0; MemToReg=0; branch=0;
        end
    endcase
end
endmodule
