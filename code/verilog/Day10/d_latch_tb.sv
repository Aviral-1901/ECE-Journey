module d_latch_tb;
logic d;
logic en;
logic q;
logic q_bar;

d_latch d_latch_uut(
    .d(d),
    .en(en),
    .q(q),
    .q_bar(q_bar)
);

initial begin
$dumpfile("d_latch.vcd");
$dumpvars(0, d_latch_tb);
en=1; d=0; #10; $display("en=%b d=%b q=%b q_bar=%b",en,d,q,q_bar);
en=1; d=0; #5; $display("en=%b d=%b q=%b q_bar=%b",en,d,q,q_bar);
en=1; d=1; #5; $display("en=%b d=%b q=%b q_bar=%b",en,d,q,q_bar);
en=1; d=0; #5; $display("en=%b d=%b q=%b q_bar=%b",en,d,q,q_bar);
en=1; d=1; #5; $display("en=%b d=%b q=%b q_bar=%b",en,d,q,q_bar);
en=1; d=1; #10; $display("en=%b d=%b q=%b q_bar=%b",en,d,q,q_bar);
en=0; d=0; #10; $display("en=%b d=%b q=%b q_bar=%b",en,d,q,q_bar);
en=0; d=1; #10; $display("en=%b d=%b q=%b q_bar=%b",en,d,q,q_bar);
$finish;
end
endmodule