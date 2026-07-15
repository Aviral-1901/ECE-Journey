module data_mem_tb;
logic clk;
initial clk = 0;
always #5 clk = ~clk;
logic write_enable;
logic [31:0] address;
logic [31:0] write_data;
logic [2:0] funct3;
logic [31:0] read_data;

data_mem d_mem_uut(
    .clk(clk),
    .write_enable(write_enable),
    .address(address),
    .write_data(write_data),
    .funct3(funct3),
    .read_data(read_data)
);

task tick (input int n);
begin
    repeat (n) @(posedge clk);
    #1;
end
endtask


initial begin
$monitor("time=%0t clk=%b we=%b address=%0d funct3=%b read_data=%0d write_data=%0d",$time,clk,write_enable,address,funct3,read_data,write_data);

write_enable=1; address=0; funct3=010;
write_data=32'hAABBCCDD;
tick(1);
write_enable=0;

//lw
funct3 = 3'b010; address = 0; #1;
assert (read_data == 32'hAABBCCDD) else $fatal(1, "Fail: LW failed");
$display("Pass: LW = %h", read_data);

//lb at 0
funct3 = 3'b000; address = 0; #1;
assert (read_data == 32'hFFFFFFDD) else $fatal(1, "Fail: LB Address 0 failed");
$display("Pass: LB Address 0 = %h", read_data);

//lbu
funct3 = 3'b100; address = 1; #1;
assert (read_data == 32'h000000CC) else $fatal(1, "Fail: LBU Address 1 failed");
$display("Pass: LBU Address 1 = %h",read_data);

//lb at 2
funct3 = 3'b000; address = 2; #1;
assert (read_data == 32'hFFFFFFBB) else $fatal(1, "Fail: LB Address 2 failed");
$display("Pass: LB Address 2 = %h",read_data);

//lh at 2
funct3 = 3'b001; address = 2; #1;
assert (read_data == 32'hFFFFAABB) else $fatal(1, "Fail: LH Address 2 failed");
$display("Pass: LH Address 2 = %h",read_data);

//lhu at 2
funct3 = 3'b101; address = 2; #1;
assert (read_data == 32'h0000AABB) else $fatal(1, "Fail: LHU Address 2 failed");
$display("Pass: LHU Address 2 = %h",read_data);

$finish;
end
endmodule