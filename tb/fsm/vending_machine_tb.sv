module vending_machine_tb;
logic clk;
initial clk = 0;
always #5 clk = ~clk;
logic rst_n;
logic coin5;
logic coin10;
logic dispense;
logic change;

vending_machine uut(
    .clk(clk),
    .rst_n(rst_n),
    .coin5(coin5),
    .coin10(coin10),
    .dispense(dispense),
    .change(change)
);

task tick (input int n);
begin
    repeat(n) @(posedge clk);
    #1;
end
endtask

task insert_coin5;
begin
    coin5 = 1;
    coin10 = 0;
    @(posedge clk);
    #1;
    coin5 = 0;
end
endtask

task insert_coin10;
begin
    coin10 = 1;
    coin5 = 0;
    @(posedge clk);
    #1;
    coin10 = 0;
end
endtask

initial begin
$dumpfile("vending_machine.vcd");
$dumpvars(0, vending_machine_tb);
$monitor("time=%0t clk=%b rst_n=%b coin5=%b coin10=%b dispense=%b change=%b",$time,clk,rst_n,coin5,coin10,dispense,change);
rst_n=0; coin5=0; coin10=0; tick(2);

rst_n=1; tick(1);

//test-1
insert_coin5();
insert_coin5();
insert_coin5();
insert_coin5();
coin5=1; #1;
assert(dispense==1 && change==0) else $fatal(1,"Fail: Expected dispense=1, change=0");
$display("Pass: Total 25, dispense=1, change=0");
@(posedge clk);

//test-2
insert_coin10();
insert_coin10();
coin5=1; #1;
assert(dispense==1 && change==0) else $fatal(1,"Fail: Expected dispense=1, change=0");
$display("Pass: Total 25, dispense=1, change=0");
@(posedge clk);


//test-3
insert_coin10();
insert_coin10();
coin10=1; #1;
assert(dispense==1 && change==1) else $fatal(1, "Fail: Expected dispense=1, change=1");
$display("Pass: Total 30, dispense=1, change=1");
@(posedge clk);

//test-4
insert_coin5();
insert_coin10();
rst_n=0; tick(1);
assert(dispense==0 && change==0) else $fatal(1, "Fail: After Reset");
$display("Pass: Reset working well");

$finish;
end
endmodule