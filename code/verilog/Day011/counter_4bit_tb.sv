module counter_4bit_tb;
logic clk;
initial clk = 0;
always #5 clk = ~clk;
logic rst_n;
logic enable;
logic [3:0] count;

counter_4bit couter4_uut(
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .count(count)
);

initial begin 
$dumpfile("counter_4bit.vcd");
$dumpvars(0, counter_4bit_tb);
$monitor("time=%0t clk=%b rst_n=%b enable=%b count=%b", $time, clk, rst_n, enable, count);

rst_n=0; enable=1; #10;

rst_n=1; enable=1; #20;
rst_n=1; enable=0; #10;
if (count != 4'b0010) begin
    $display("FAIL, Hold check");
end else begin
    $display("PASS, Hold check");
end

rst_n=0; enable=1; #10;
if (count != 4'b0000) begin
    $display("FAIL, reset check");
end else begin
    $display("PASS, reset check");
end

rst_n=1; enable=1; #160;
if (count != 4'b0000) begin
    $display("FAIL, wraparound check");
end else begin
    $display("PASS, wraparound check");
end

$finish;
end
endmodule
