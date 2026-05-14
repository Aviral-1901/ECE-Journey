module counter_4bit_tb;
logic clk;
initial clk=0;
always #5 clk = ~clk;
logic rst_n;
logic enable;
logic [3:0] count;

counter_4bit counter_uut (
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .count(count)
);

task tick(input int n);
begin
    repeat(n) @(posedge clk);
    #1;
end
endtask

initial begin
$dumpfile("counter_4bit.vcd");
$dumpvars(0, counter_4bit_tb);
$monitor("time=%0t clk=%b rst_n=%b enable=%b count=%b", $time, clk, rst_n, enable, count);
rst_n=0; enable=1;
tick(2);

rst_n=1; enable=1;
tick(2);
assert(count == 4'b0010) 
    else $fatal(1, "increment fail");
$display("increment pass");

enable=0;
tick(1);
assert(count == 4'b0010) 
    else $fatal(1, "hold fail");
$display("hold pass");

rst_n=0;
tick(1);
assert(count == 4'b0000) 
    else $fatal(1, "reset fail");
$display("reset pass");

rst_n=1; enable=1;
tick(16);
assert(count == 4'b0000) 
    else $fatal(1, "wraparound fail");
$display("wraparound pass");

$finish;
end
endmodule