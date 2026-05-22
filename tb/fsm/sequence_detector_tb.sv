module seq_detector_tb;
logic clk;
initial clk = 0;
always #5 clk = ~clk;
logic rst_n;
logic data;
logic detected;

seq_detector seq_det_uut(
    .clk(clk),
    .rst_n(rst_n),
    .data(data),
    .detected(detected)
);

task tick (input int n);
begin
    repeat(n) @(posedge clk);
    #1;
end
endtask

initial begin
$monitor("time=%0t clk=%b rst_n=%b data=%b detected=%b",$time, clk, rst_n, data, detected);
rst_n=0; tick(2);
rst_n=1;
data=1; tick(1);
data=0; tick(1);
data=1; tick(1);
data=1; 
#1;
assert (detected==1) else $fatal(1, "Fail: detected should be 1 after 1011 sequence");
$display("Pass: sequence detected");
tick(1);

data=1; tick(1);
data=0; tick(1);
data=1; tick(1);
data=0; tick(1);
data=1; tick(1);
data=1; 
#1;
assert (detected==1) else $fatal(1, "Fail: detected should be 1 after 1011 sequence");
$display("Pass: sequence detected");
tick(1);

data=0; tick(1);
data=0; tick(1);
data=1; tick(1);
data=0; tick(1);
data=1; tick(1);
data=1; 
#1;
assert (detected==1) else $fatal(1, "Fail: detected should be 1 after 1011 sequence");
$display("Pass: sequence detected");
$finish;
end
endmodule