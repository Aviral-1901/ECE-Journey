module vending_machine(
    input logic clk,
    input logic rst_n,
    input logic coin5,
    input logic coin10,
    output logic dispense,
    output logic change
);

typedef enum logic[2:0] {
    S0 = 3'b000,
    S5 = 3'b001,
    S10 = 3'b010,
    S15 = 3'b011,
    S20 = 3'b100
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
            dispense=0; change=0; next_state=S0;
            if (coin5) begin
                next_state = S5;
            end
            else if (coin10) begin
                next_state = S10;
            end
        end

        S5: begin
            dispense=0; change=0; next_state=S5;
            if (coin5) begin
                next_state = S10;
            end
            else if (coin10) begin
                next_state = S15;
            end
        end

        S10: begin
            dispense=0; change=0; next_state=S10;
            if (coin5) begin
                next_state = S15;
            end
            else if (coin10) begin
                next_state = S20;
            end
        end

        S15: begin
            dispense=0; change=0; next_state=S15;
            if (coin5) begin
                next_state = S20;
            end
            else if (coin10) begin
                next_state = S0;
                dispense=1; change=0;
            end
        end

        S20: begin
            dispense=0; change=0; next_state=S20;
            if (coin5) begin
                next_state = S0;
                dispense = 1; change = 0;
            end
            else if (coin10) begin
                next_state = S0;
                dispense = 1; change = 1;
            end
        end

        default: begin
            next_state = S0;
            dispense = 0;
            change = 0;
        end
    endcase
end
endmodule
