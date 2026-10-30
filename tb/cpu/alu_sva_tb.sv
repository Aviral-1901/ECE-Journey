module alu_sva_tb;
logic clk;
initial clk = 0;
always #5 clk = ~clk;
logic [31:0] a;
logic [31:0] b;
logic [3:0] alu_op;
logic [31:0] result;
logic zero;

alu dut(
    .a(a),
    .b(b),
    .alu_op(alu_op),
    .result(result),
    .zero(zero)
);

alu_checker chk(
    .clk(clk),
    .a(a),
    .b(b),
    .alu_op(alu_op),
    .result(result),
    .zero(zero)
);

task tick (input int n);
begin
    repeat(n) @(posedge clk);
    #1;
end
endtask

initial begin
a=5; b=5; alu_op=4'b0001; tick(2);
$display("applied: a=%0d b=%0d result=%0d zero=%0d",a,b,result,zero);

a=9; b=4; alu_op=4'b0001; tick(2);
$display("applied: a=%0d b=%0d result=%0d zero=%0d",a,b,result,zero);

$finish;
end 
endmodule