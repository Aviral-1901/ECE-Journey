module cpu_tb;
logic clk;
initial clk = 0; 
always #5 clk = ~clk;
logic rst_n;

cpu dut(
    .clk(clk),
    .rst_n(rst_n)
);

task tick (input int n);
begin
    repeat (n) @(posedge clk);
    #1;
end
endtask

initial begin
rst_n=0; tick(2);

rst_n=1; tick(3);

assert (dut.reg_file.registers[1]==32'd5) else $fatal(1, "Fail: x1 should have value 5");
$display("Pass: x1 has value 5");

assert (dut.reg_file.registers[2]==32'd3) else $fatal(1, "Fail: x2 should have value 3");
$display("Pass: x2 has value 3");

assert (dut.reg_file.registers[3]==32'd8) else $fatal(1, "Fail: x3 should have value 8");
$display("Pass: x3 has value 8");

$finish;
end 
endmodule
