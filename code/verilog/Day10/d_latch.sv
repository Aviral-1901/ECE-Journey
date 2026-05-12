module d_latch(
    input logic d,
    input logic en,
    output logic q,
    output logic q_bar
);

always_latch begin
    if (en) begin
        q = d;
        q_bar = ~d;
    end
end
endmodule