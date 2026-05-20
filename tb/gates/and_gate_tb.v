module and_gate_tb;
reg a;
reg b;
wire y;
and_gate and_uut(
    .a(a),
    .b(b),
    .y(y)
);
initial begin
a=0; b=0; #10;
assert (y == 1'b0) else $fatal(1, "Fail: 0&0 should be 0");
$display("pass: 0&0 = 0");

a=0; b=1; #10;
assert (y == 1'b0) else $fatal(1, "Fail: 0&1 should be 0");
$display("pass: 0&1 = 0");

a=1; b=0; #10;
assert (y == 1'b0) else $fatal(1, "Fail: 1&0 should be 0");
$display("pass: 1&0 = 0");

a=1; b=1; #10;
assert (y == 1'b1) else $fatal(1, "Fail: 1&1 should be 1");
$display("pass: 1&1 = 1");

$finish;
end
endmodule
