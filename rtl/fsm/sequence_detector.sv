module seq_detector(
    input logic clk,
    input logic rst_n,
    input logic data,
    output logic detected
);

typedef enum logic[1:0] {
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10,
    S3 = 2'b11
} state_t;

state_t current_state, next_state;

always_ff @(posedge clk) begin
    if(!rst_n) begin
        current_state <= S0;
    end
    else begin
        current_state <= next_state;
    end
end

always_comb begin
    case (current_state)
        S0: begin
            if(data==1) begin
                next_state = S1;
                detected = 0;
            end
            else begin
                next_state = S0;
                detected = 0;
            end
        end

        S1: begin
            if(data==0) begin
                next_state = S2;
                detected = 0;
            end
            else begin
                next_state = S1;
                detected = 0;
            end
        end

        S2: begin
            if(data==1) begin
                next_state = S3;
                detected = 0;
            end
            else begin
                next_state = S0;
                detected = 0;
            end
        end

        S3: begin
            if(data==1) begin
                next_state = S1;
                detected = 1;
            end
            else begin
                next_state = S2;
                detected = 0;
            end
        end

        default: begin
            next_state = S0;
            detected = 0;
        end
    endcase
end
endmodule