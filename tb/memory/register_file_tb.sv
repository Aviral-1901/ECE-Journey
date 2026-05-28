module register_file_tb;
logic clk;
initial clk = 0;
always #5 clk = ~clk;
logic write_enable;
logic [4:0] read_address1;
logic [4:0] read_address2;
logic [4:0] write_address;
logic [31:0] read_data1;
logic [31:0] read_data2;
logic [31:0] write_data;

register_file register_uut(
    .clk(clk),
    .write_enable(write_enable),
    .read_address1(read_address1),
    .read_address2(read_address2),
    .write_address(write_address),
    .read_data1(read_data1),
    .read_data2(read_data2),
    .write_data(write_data)
);

task tick (input int n);
begin
    repeat(n) @(posedge clk);
    #1;
end
endtask

initial begin
$monitor("time=%0t we=%b ra1=%0d ra2=%0d rd1=%0d rd2=%0d wa=%0d wd=%0d",
    $time, write_enable, read_address1, read_address2, 
    read_data1, read_data2, write_address, write_data);

write_enable = 1;
write_address = 5; 
write_data = 44;
tick(1);

write_address = 6;
write_data = 55;
tick(1);

read_address1 = 5;
#1;
assert (read_data1 == 44) else $fatal(1, "Fail: Reading failed from address1");
$display("Pass: Reading passed from address1");

read_address2 = 6;
#1;
assert (read_data2 == 55) else $fatal(1, "Fail: Reading failed from address2");
$display("Pass: Reading passed from address2");

tick(1);

write_enable=0;
write_address = 5;
write_data = 99;
tick(1);
read_address1 = 5;
#1;
assert (read_data1 == 44) else $fatal(1, "Fail: Writing on write_enable=0");
$display("Pass: No Writing when write_enable=0");

tick(1);

read_address1=0; read_address2=6;
#1;
assert (read_data1==0 && read_data2==55) else $fatal(1, "Fail: Reading from two ports failed");
$display("Pass: Reading from two ports passed");

tick(1);
write_address=0;
write_data=33;
tick (1);
read_address1=0;
#1;
assert (read_data1 == 0) else $fatal(1, "Fail: Writing error on x0");
$display("Pass: No writing on x0");

$finish;
end
endmodule


