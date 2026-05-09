module adder_subtractor_tb;
reg [3:0] a;
reg [3:0] b;
reg sub;
wire [3:0] result;
wire cout;

adder_subtractor add_sub_uut(
    .a(a),
    .b(b),
    .sub(sub),
    .result(result),
    .cout(cout)
);

initial begin
sub=0; a=4'b0101; b=4'b0011; #10; $display("sub=%b a=%b b=%b result=%b cout=%b",sub,a,b,result,cout);
sub=0; a=4'b1111; b=4'b0001; #10; $display("sub=%b a=%b b=%b result=%b cout=%b",sub,a,b,result,cout);
sub=1; a=4'b0111; b=4'b0011; #10; $display("sub=%b a=%b b=%b result=%b cout=%b",sub,a,b,result,cout);
sub=1; a=4'b0101; b=4'b0101; #10; $display("sub=%b a=%b b=%b result=%b cout=%b",sub,a,b,result,cout);
sub=1; a=4'b0011; b=4'b0111; #10; $display("sub=%b a=%b b=%b result=%b cout=%b",sub,a,b,result,cout);
$finish;
end
endmodule