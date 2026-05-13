module sr_latch_tb;
logic s;
logic r;
logic q;
logic q_bar;

sr_latch sr_uut(
    .s(s),
    .r(r),
    .q(q),
    .q_bar(q_bar)
);

initial begin
$dumpfile("sr_latch.vcd");
$dumpvars(0, sr_latch_tb);
s=0; r=0; #10; $display("s=%b r=%b q=%b q_bar=%b",s,r,q,q_bar);
s=1; r=0; #10; $display("s=%b r=%b q=%b q_bar=%b",s,r,q,q_bar);
s=1; r=0; #5; $display("s=%b r=%b q=%b q_bar=%b",s,r,q,q_bar);
s=0; r=0; #5; $display("s=%b r=%b q=%b q_bar=%b",s,r,q,q_bar);
s=0; r=1; #10; $display("s=%b r=%b q=%b q_bar=%b",s,r,q,q_bar);
s=0; r=0; #10; $display("s=%b r=%b q=%b q_bar=%b",s,r,q,q_bar);
s=1; r=1; #10; $display("s=%b r=%b q=%b q_bar=%b",s,r,q,q_bar);
$finish;
end
endmodule