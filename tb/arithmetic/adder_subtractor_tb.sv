module adder_subtractor_tb;
logic [3:0] a;
logic [3:0] b;
logic sub;
alu_status_t status;

adder_subtractor add_sub_uut(
    .a(a),
    .b(b),
    .sub(sub),
    .status(status)
);

initial begin
sub=0; a=4'b0101; b=4'b0011; #10; $display("sub=%b a=%b b=%b result=%b cout=%b overflow=%b zero=%b",sub, a, b, status.result,status.cout,status.overflow,status.zero);
sub=0; a=4'b1111; b=4'b0001; #10; $display("sub=%b a=%b b=%b result=%b cout=%b overflow=%b zero=%b",sub, a, b, status.result,status.cout,status.overflow,status.zero);
sub=1; a=4'b0111; b=4'b0011; #10; $display("sub=%b a=%b b=%b result=%b cout=%b overflow=%b zero=%b",sub, a, b, status.result,status.cout,status.overflow,status.zero);
sub=1; a=4'b0101; b=4'b0101; #10; $display("sub=%b a=%b b=%b result=%b cout=%b overflow=%b zero=%b",sub, a, b, status.result,status.cout,status.overflow,status.zero);
sub=1; a=4'b0011; b=4'b0111; #10; $display("sub=%b a=%b b=%b result=%b cout=%b overflow=%b zero=%b",sub, a, b, status.result,status.cout,status.overflow,status.zero);
$finish;
end 
endmodule