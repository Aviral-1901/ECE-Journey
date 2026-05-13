module decoder_2to4_tb;
reg [1:0] s;
wire [3:0] y;

decoder_2to4 decoder_2to4_uut(
    .s(s),
    .y(y)
);

initial begin
s=2'b00; #10; $display("s=%b y=%b",s,y);
s=2'b01; #10; $display("s=%b y=%b",s,y);
s=2'b10; #10; $display("s=%b y=%b",s,y);
s=2'b11; #10; $display("s=%b y=%b",s,y);
$finish;
end
endmodule