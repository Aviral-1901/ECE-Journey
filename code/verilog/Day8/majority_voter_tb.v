module majority_voter_tb;
reg a;
reg b;
reg c;
wire y;

majority_voter majority_voter_uut(
    .a(a),
    .b(b),
    .c(c),
    .y(y)
);

initial begin
a=0; b=0; c=0; #10; $display("a=%b b=%b c=%b y=%b",a,b,c,y);
a=0; b=0; c=1; #10; $display("a=%b b=%b c=%b y=%b",a,b,c,y);
a=0; b=1; c=0; #10; $display("a=%b b=%b c=%b y=%b",a,b,c,y);
a=0; b=1; c=1; #10; $display("a=%b b=%b c=%b y=%b",a,b,c,y);
a=1; b=0; c=0; #10; $display("a=%b b=%b c=%b y=%b",a,b,c,y);
a=1; b=0; c=1; #10; $display("a=%b b=%b c=%b y=%b",a,b,c,y);
a=1; b=1; c=0; #10; $display("a=%b b=%b c=%b y=%b",a,b,c,y);
a=1; b=1; c=1; #10; $display("a=%b b=%b c=%b y=%b",a,b,c,y);
$finish;
end
endmodule