module sr_latch(
    input logic s,
    input logic r,
    output logic q,
    output logic q_bar
);

always @(s, r, q) begin
    if (s==0 && r==0) begin
    end 
    else if (s==0 && r==1) begin
        q = 0;
        q_bar = 1;
    end
    else if (s==1 && r==0) begin
        q = 1;
        q_bar = 0;
    end
    else begin
        q=0;
        q_bar=0;
    end 
end
endmodule