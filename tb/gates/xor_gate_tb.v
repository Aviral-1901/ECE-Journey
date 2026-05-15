module xor_gate_tb;
reg a;
reg b;
wire y;

xor_gate xor_uut(
    .a(a),
    .b(b),
    .y(y)
);

initial begin
a=0; b=0; #10; $display("a=%b b=%b y=%b",a,b,y);
a=0; b=1; #10; $display("a=%b b=%b y=%b",a,b,y);
a=1; b=0; #10; $display("a=%b b=%b y=%b",a,b,y);
a=1; b=1; #10; $display("a=%b b=%b y=%b",a,b,y);
$finish;
end
endmodule