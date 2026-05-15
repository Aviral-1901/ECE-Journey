module register_4bit(
    input logic clk,
    input logic write_enable,
    input logic [3:0] d,
    output logic [3:0] q
);

always_ff @(posedge clk) begin
    if (write_enable) begin
        q <= d;
    end
end
endmodule
