module sync_ram #(
    parameter DEPTH = 256,
    parameter WIDTH = 8
) (
    input logic clk,
    input logic write_enable,
    input logic [$clog2(DEPTH)-1:0] address,
    input logic [WIDTH-1:0] write_data,
    output logic [WIDTH-1:0] read_data
);

logic [WIDTH-1:0] ram [DEPTH];

always_ff @(posedge clk) begin
    if (write_enable) begin
        read_data <= write_data;
        ram[address] <= write_data;
    end
    else begin
        read_data <= ram[address];
    end
end
endmodule

