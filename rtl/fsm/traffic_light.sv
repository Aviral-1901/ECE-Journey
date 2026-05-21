module traffic_light(
    input logic clk,
    input logic rst_n,
    output logic red,
    output logic yellow,
    output logic green
);

typedef enum logic [1:0] {
    GREEN = 2'b00,
    YELLOW = 2'b01,
    RED = 2'b10
} state_t;

state_t current_state, next_state;
logic [1:0] counter, next_counter;

always_ff @(posedge clk) begin
    if(!rst_n) begin
        current_state <= GREEN;
        counter <= 0;
    end 
    else begin
        current_state <= next_state;
        counter <= next_counter;
    end
end

always_comb begin
    case(current_state) 
        GREEN: begin
            green=1; red=0; yellow=0;
            if (counter == 3) begin
                next_state = YELLOW;
                next_counter = 0;
            end 
            else begin
                next_state = GREEN;
                next_counter = counter + 1;
            end
        end

        YELLOW: begin
            yellow=1; red=0; green=0;
            if (counter == 1) begin
                next_state = RED;
                next_counter = 0;
            end 
            else begin
                next_state = YELLOW;
                next_counter = counter + 1;
            end
        end

        RED: begin
            red=1; green=0; yellow=0;
            if (counter == 3) begin
                next_state = GREEN;
                next_counter = 0;
            end
            else begin
                next_state = RED;
                next_counter = counter + 1;
            end
        end

        default: begin
            next_state = GREEN;
            next_counter = 0;
            green=0; yellow=0; red=0;
        end
    endcase
end 
endmodule