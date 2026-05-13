module register_4bit_tb;
logic clk;
initial clk = 0;
always #5 clk = ~clk;
logic write_enable;
logic [3:0] d;
logic [3:0] q;

register_4bit reg_4bit_uut(
    .clk(clk),
    .write_enable(write_enable),
    .d(d),
    .q(q)
);

initial begin
$dumpfile("register_4bit.vcd");
$dumpvars(0, register_4bit_tb);
$monitor("time=%0t clk=%b write_enable=%b d=%b q=%b", $time, clk, write_enable, d, q);
write_enable=1; d=4'b1101; #10;
write_enable=0; d=4'b1010; #10;
write_enable=1; d=4'b1110; #10;
write_enable=1; d=4'b1010; #10; 
write_enable=0; d=4'b1111; #10;  
write_enable=0; d=4'b0000; #10;  
write_enable=1; d=4'b0110; #10;  
$finish;
end
endmodule