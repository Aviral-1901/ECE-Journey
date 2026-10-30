module alu_checker(
    input logic clk,
    input logic [3:0] alu_op,
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [31:0] result,
    input logic zero
);

assert property (@(posedge clk) (alu_op == 4'b0001 && a ==b) |-> (zero == 1))
else 
$error("FAIL: a=%0d b=%0d result=%0d zero=%0d",a,b,result,zero);
endmodule