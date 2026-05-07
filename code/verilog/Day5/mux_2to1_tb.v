module mux_2to1_tb;
reg i0;
reg i1;
reg s;
wire y;

mux_2to1 mux_uut(
    .i0(i0),
    .i1(i1),
    .s(s),
    .y(y)
);

initial begin
s=0; i0=0; i1=1; #10; $display("s=%b i0=%b i1=%b y=%b",s,i0,i1,y);
s=0; i0=1; i1=0; #10; $display("s=%b i0=%b i1=%b y=%b",s,i0,i1,y);
s=1; i0=0; i1=1; #10; $display("s=%b i0=%b i1=%b y=%b",s,i0,i1,y);
s=1; i0=1; i1=0; #10; $display("s=%b i0=%b i1=%b y=%b",s,i0,i1,y);
$finish;
end
endmodule