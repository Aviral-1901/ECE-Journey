module alu(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [3:0] alu_op,
    output logic [31:0] result,
    output logic zero
);

logic [4:0] shift_amt;
assign shift_amt = b[4:0];

always_comb begin
    case (alu_op)
        4'b0000: result = a + b; 
        4'b0001: result = a - b;
        4'b0010: result = a & b;
        4'b0011: result = a | b;
        4'b0100: result = a ^ b;
        4'b0101: result = a << shift_amt;
        4'b0110: result = a >> shift_amt;
        4'b0111: result = $signed(a) < $signed(b);

        default: result = 32'b0;
    
    endcase
end

assign zero = (result == 32'b0);
endmodule
