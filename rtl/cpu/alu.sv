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
        4'b1000: result = $signed(a) >>> shift_amt; //sra = shift right arithmetic
        4'b1001: result = a < b; //sltu

        default: result = 32'b0;
    
    endcase
end

assign zero = (result == 32'b0);


`ifdef ALU_ASSERT
always_comb begin
    if (alu_op == 4'b0001 && a == b) begin
        assert (zero == 1) else $fatal(1, "FAIL: alu_op=%d a=%0d b=%0d zero=%0d result=%0d",alu_op,a,b,zero,result);
    end
end

always_comb begin
    if (alu_op == 4'b0000 && a == 0) begin
        assert (result == b) else $fatal(1, "FAIL: For ADD if a=0 result should be b, a=%0d,b=%0d,result=%0d",a,b,result);
    end
end

always_comb begin
    if (alu_op == 4'b0111) begin
        assert (result == 0 || result == 1) else $fatal(1, "FAIL: SLT result can only be 0 or 1, a=%0d,b=%0d,result=%0d",a,b,result);
    end
end
`endif

endmodule
