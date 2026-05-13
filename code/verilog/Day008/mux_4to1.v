module mux_4to1(
    input wire i0,
    input wire i1,
    input wire i2,
    input wire i3,
    input wire [1:0] s,
    output wire y
);
wire y0, y1;
mux_2to1 m2to1_uut0(
    .i0(i0),
    .i1(i1),
    .s(s[0]),
    .y(y0)
);
mux_2to1 m2to1_uut1(
    .i0(i2),
    .i1(i3),
    .s(s[0]),
    .y(y1)
);
mux_2to1 m2to1_uut2(
    .i0(y0),
    .i1(y1),
    .s(s[1]),
    .y(y)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
);
endmodule