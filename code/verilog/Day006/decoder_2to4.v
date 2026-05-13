module decoder_2to4(
    input wire [1:0] s,
    output wire [3:0] y
);

    assign y[0] = ~s[1] & ~s[0];
    assign y[1] = ~s[1] & s[0];
    assign y[2] = s[1] & ~s[0];
    assign y[3] = s[1] & s[0];
endmodule