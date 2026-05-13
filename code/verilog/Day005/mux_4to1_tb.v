module mux_4to1_tb;
reg i0;
reg i1;
reg i2;
reg i3;
reg [1:0] s;
wire y;

mux_4to1 mux_4to1_uut (
    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .s(s),
    .y(y)
);

initial begin
s=2'b00; i0=1; i1=0; i2=0; i3=0; #10; $display("s=%b i0=%b i1=%b i2=%b i3=%b y=%b",s,i0,i1,i2,i3,y);
s=2'b01; i0=0; i1=1; i2=0; i3=0; #10; $display("s=%b i0=%b i1=%b i2=%b i3=%b y=%b",s,i0,i1,i2,i3,y);
s=2'b10; i0=0; i1=0; i2=1; i3=0; #10; $display("s=%b i0=%b i1=%b i2=%b i3=%b y=%b",s,i0,i1,i2,i3,y);
s=2'b11; i0=1; i1=0; i2=0; i3=1; #10; $display("s=%b i0=%b i1=%b i2=%b i3=%b y=%b",s,i0,i1,i2,i3,y);
$finish;
end
endmodule