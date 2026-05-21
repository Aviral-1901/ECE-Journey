module traffic_light_tb;
logic clk;
initial clk = 0;
always #5 clk = ~clk;
logic rst_n;
logic green;
logic yellow;
logic red;

traffic_light tf_uut (
    .clk(clk),
    .rst_n(rst_n),
    .green(green),
    .yellow(yellow),
    .red(red)
);

task tick (input int n);
begin
    repeat(n) @(posedge clk);
    #1;
end
endtask

initial begin
$dumpfile("traffic_light.vcd");
$dumpvars(0, traffic_light_tb);
$monitor("time=%0t clk=%b rst_n=%b green=%b yellow=%b red=%b", $time, clk, rst_n, green, yellow, red);

//reset check
rst_n=0; tick(2);
assert(green == 1) else $fatal(1, "Fail: after reset green should be 1");
$display("Pass: green is 1 after reset");

//green check
rst_n=1; tick(2);
assert(green == 1) else $fatal(1, "Fail: after 2 cycles green should be 1");
$display("Pass: green light");

//yellow check
tick(3);
assert(yellow == 1) else $fatal(1, "Fail: after 5 cycles yellow should be 1");
$display("Pass: yellow light");

//red check
tick(3);
assert(red == 1) else $fatal(1, "Fail: after 8 cycles red should be 1");
$display("Pass: red light");

rst_n=0; tick(2);
rst_n=1; tick(20);

$finish;
end
endmodule


