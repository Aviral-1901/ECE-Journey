typedef struct packed {
    logic [3:0] result;
    logic cout;
    logic overflow;
    logic zero;
} alu_status_t;

module adder_subtractor(
    input logic[3:0] a,
    input logic[3:0] b,
    input logic sub,
    output alu_status_t status
);

logic c0, c1, c2;
logic [3:0] b_xor;

assign b_xor[0] = b[0] ^ sub;
assign b_xor[1] = b[1] ^ sub;
assign b_xor[2] = b[2] ^ sub;
assign b_xor[3] = b[3] ^ sub;

full_adder fa_0(
    .a(a[0]),
    .b(b_xor[0]),
    .sum(status.result[0]),
    .cin(sub),
    .cout(c0)
);

full_adder fa_1(
    .a(a[1]),
    .b(b_xor[1]),
    .sum(status.result[1]),
    .cin(c0),
    .cout(c1)
);

full_adder fa_2(
    .a(a[2]),
    .b(b_xor[2]),
    .sum(status.result[2]),
    .cin(c1),
    .cout(c2)
);

full_adder fa_3(
    .a(a[3]),
    .b(b_xor[3]),
    .sum(status.result[3]),
    .cin(c2),
    .cout(status.cout)
);

assign status.overflow = status.cout ^ c2;
assign status.zero = (status.result == 4'b0000);
endmodule