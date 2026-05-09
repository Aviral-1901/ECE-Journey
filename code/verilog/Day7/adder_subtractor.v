module adder_subtractor(
    input wire [3:0] a,
    input wire [3:0] b,
    input wire sub,
    output wire [3:0] result,
    output wire cout
);

wire c0, c1, c2;
wire [3:0] b_xor;
assign b_xor[0] = b[0] ^ sub;
assign b_xor[1] = b[1] ^ sub;
assign b_xor[2] = b[2] ^ sub;
assign b_xor[3] = b[3] ^ sub;

full_adder fa_0(
    .a(a[0]),
    .b(b_xor[0]),
    .cin(sub),
    .sum(result[0]),
    .cout(c0)
);

full_adder fa_1(
    .a(a[1]),
    .b(b_xor[1]),
    .cin(c0),
    .sum(result[1]),
    .cout(c1)
);

full_adder fa_2(
    .a(a[2]),
    .b(b_xor[2]),
    .cin(c1),
    .sum(result[2]),
    .cout(c2)
);

full_adder fa_3(
    .a(a[3]),
    .b(b_xor[3]),
    .cin(c2),
    .sum(result[3]),
    .cout(cout)
);

endmodule
