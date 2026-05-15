module ripple_carry_adder(
    input wire [3:0] a,
    input wire [3:0] b,
    output wire [3:0] sum,
    output wire cout
);

wire c0, c1, c2;

full_adder fa_0(
    .a(a[0]),
    .b(b[0]),
    .cin(1'b0),
    .sum(sum[0]),
    .cout(c0)
);

full_adder fa_1(
    .a(a[1]),
    .b(b[1]),
    .cin(c0),
    .sum(sum[1]),
    .cout(c1)
);

full_adder fa_2(
    .a(a[2]),
    .b(b[2]),
    .cin(c1),
    .sum(sum[2]),
    .cout(c2)
);

full_adder fa_3(
    .a(a[3]),
    .b(b[3]),
    .cin(c2),
    .sum(sum[3]),
    .cout(cout)
);

endmodule