module sync_ram_tb;
logic clk;
initial clk = 0;
always #5 clk = ~clk;
logic write_enable;
logic [7:0] address;
logic [7:0] read_data;
logic [7:0] write_data;


sync_ram ram_uut(
    .clk(clk),
    .write_enable(write_enable),
    .address(address),
    .read_data(read_data),
    .write_data(write_data)
);

task tick (input int n);
begin
    repeat (n) @(posedge clk);
    #1;
end
endtask

initial begin
$monitor("time=%0t clk=%b we=%b address=%0d read_data=%0d write_data=%0d",$time,clk,write_enable,address,read_data,write_data);

write_enable=1; address=3;
write_data=3;
tick(1);
write_enable=0; address=3;
tick(1);
assert (read_data==3) else $fatal(1, "Fail: Reading failed");
$display("Pass: Reading passed");

tick(1);

write_enable=0; address=3;
write_data=4;
tick(1);
assert (read_data==3) else $fatal(1, "Fail: Should not wirte wnen write_enable=0");
$display("Pass: No writing when write_enable=0");

tick(1);

write_enable=1; address=4;
write_data=44;
tick(1);
assert (read_data==44) else $fatal(1, "Fail: Data forwarding failed");
$display("Pass: Data forwarding passed");

write_enable=0; address=3;
tick(1);
assert (read_data==3) else $fatal(1, "Fail: Address 3 corrupted");
$display("Pass: Address 3 unaffected by writes to address 4");

$finish;
end
endmodule