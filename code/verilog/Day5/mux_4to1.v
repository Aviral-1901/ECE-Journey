module mux_4to1(
    input wire i0,
    input wire i1,
    input wire i2,
    input wire i3,
    input wire [1:0] s,
    output wire y
);
    assign y = s[1] ? (s[0] ? i3 : i2) : (s[0] ? i1 : i0);
endmodule