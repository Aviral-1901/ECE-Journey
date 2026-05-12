module d_flipflop_tb;
logic clk;
initial clk = 0;
always #5 clk = ~clk;
logic d;
logic q;

d_flipflop d_ff_uut(
    .clk(clk),
    .d(d),
    .q(q)
);

initial begin
$dumpfile("d_flipflop.vcd");
$dumpvars(0, d_flipflop_tb);
$monitor("time=%0t clk=%b d=%b q=%b", $time, clk, d, q);
d=0; #20;
d=1; #20;
d=0; #10;
d=1; #20;
$finish;
end
endmodule
