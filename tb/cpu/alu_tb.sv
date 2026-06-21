module alu_tb;
logic [31:0] a;
logic [31:0] b;
logic [3:0] alu_op;
logic [31:0] result;
logic zero;

alu alu_uut(
    .a(a),
    .b(b),
    .alu_op(alu_op),
    .result(result),
    .zero(zero)
);

initial begin
a=10; b=10; alu_op=4'b0000; #1;
assert (result==20) else $fatal(1, "Fail: ALU addition failed");
$display("Addition Pass: a=%d b=%d result=%d",a,b,result);
#1;

a=7; b=3; alu_op=4'b0001; #1;
assert (result==4) else $fatal(1, "Fail: ALU subtraction failed");
$display("Subtraction Pass: a=%d b=%d result=%d",a,b,result);
#1;

a=32'h00FF; b=32'h0007; alu_op=4'b0010; #1;
assert (result==32'h0007) else $fatal(1, "Fail: ALU AND operation failed");
$display("AND Pass: a=%h b=%h result=%h",a,b,result);
#1;

a=32'h00FF; b=32'h0007; alu_op=4'b0011; #1;
assert (result==32'h00FF) else $fatal(1, "Fail: ALU OR operation failed");
$display("OR Pass: a=%h b=%h result=%h",a,b,result);
#1;

a=32'h00FF; b=32'h0007; alu_op=4'b0100; #1;
assert (result==32'h00F8) else $fatal(1, "Fail: ALU XOR operation failed");
$display("XOR Pass: a=%h b=%h result=%h",a,b,result);
#1;

a=32'h0F; b=32'h04; alu_op=4'b0101; #1;
assert (result==32'h00F0) else $fatal(1, "Fail: ALU Left Shift failed");
$display("Left Shift Pass: a=%h b=%h result=%h",a,b,result);
#1;

a=32'hF0; b=32'h04; alu_op=4'b0110; #1;
assert (result==32'h000F) else $fatal(1, "Fail: ALU Right Shift failed");
$display("Right Shift Pass: a=%h b=%h result=%h",a,b,result);
#1;

a=32'h04; b=32'h07; alu_op=4'b0111; #1;
assert (result==32'h01) else $fatal(1, "Fail: ALU SLT failed");
$display("SLT Pass: a=%d b=%d result=%d",a,b,result);
#1;

a=32'h0F; b=32'h0F; alu_op=4'b0001; #1;
assert (zero==1'b1) else $fatal(1, "Fail: Zero flag failed");
$display("Zero Flag Pass: a=%d b=%d result=%d",a,b,result);
#1;

a=-5; b=7; alu_op=4'b0111; #1;
assert (result==1) else $fatal(1, "Fail: -5 is smaller than 7");
$display("SLT Pass: a=%d b=%d result=%d",a,b,result);
#1;

a=-5; b=-7; alu_op=4'b0111; #1;
assert (result==0) else $fatal(1, "Fail: -5 is bigger than -7");
$display("SLT Pass: a=%d b=%d result=%d",a,b,result);
#1;

a=-7; b=-5; alu_op=4'b0111; #1;
assert (result==1) else $fatal(1, "Fail: -7 is smaller than -5");
$display("SLT Signed Negative Pass: a=%d b=%d result=%d",a,b,result);
#1;

a=32'h0F; b=32'h00; alu_op=4'b0101; #1;
assert (result==32'h000F) else $fatal(1, "Fail: ALU Left Shift by 0 failed");
$display("Left Shift by 0 Pass: a=%h b=%h result=%h",a,b,result);
#1;

a=32'h01; b=32'd31; alu_op=4'b0101; #1;
assert (result==32'd2147483648) else $fatal(1, "Fail: ALU Left Shift by 31 failed");
$display("Left Shift by 31 Pass: a=%h b=%h result=%h",a,b,result);
#1;

a=32'd2147483648; b=32'd31; alu_op=4'b0110; #1;
assert (result==32'd1) else $fatal(1, "Fail: ALU Logical Right Shift failed");
$display("Logical Right Shift Pass: a=%h b=%h result=%h",a,b,result);
#1;

a=32'hFFFFFFFF; b=32'h0001; alu_op=4'b0000; #1;
assert (result==0) else $fatal(1, "Fail: Overflow addition failed");
$display("Addition Overflow Pass: a=%d b=%d result=%d",a,b,result);
#1;

a=32'h0F; b=32'd35; alu_op=4'b0101; #1;
assert (result==32'h0078) else $fatal(1, "Fail: ALU left shift by 35 should result in shifting by 3");
$display("Shift by 35 Pass: a=%h b=%d result=%h",a,b,result);
#1;

a=32'h0F; b=32'd0; alu_op=4'b0010; #1;
assert (result==32'd0) else $fatal(1, "Fail: AND operation with 0 failed");
$display("AND with 0 Pass: a=%h b=%h result=%h",a,b,result);
#1;

a=32'h0F; b=32'd0; alu_op=4'b0011; #1;
assert (result==32'h0F) else $fatal(1, "Fail: OR operation with 0 failed");
$display("OR with 0 Pass: a=%h b=%h result=%h",a,b,result);
#1;

a=32'h0F; b=32'd0; alu_op=4'b0100; #1;
assert (result==32'h0F) else $fatal(1, "Fail: XOR operation with 0 failed");
$display("XOR with 0 Pass: a=%h b=%h result=%h",a,b,result);
#1;

$finish;
end
endmodule