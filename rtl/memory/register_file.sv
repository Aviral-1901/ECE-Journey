module register_file(
    input logic clk,
    input logic write_enable,
    input logic [4:0] read_address1,
    input logic [4:0] read_address2,
    input logic [4:0] write_address,
    input logic [31:0] write_data,
    output logic [31:0] read_data1,
    output logic [31:0] read_data2
);

logic [31:0] registers [32];

always_ff @(posedge clk) begin
    if (write_enable && write_address!=0) begin
        registers[write_address] <= write_data;
    end
end

always_comb begin
    if (read_address1==5'b00000) begin
        read_data1 = 0;
    end
    else begin
        read_data1 = registers[read_address1];
    end

    if (read_address2==5'b00000) begin
        read_data2 = 0;
    end
    else begin
        read_data2 = registers[read_address2];
    end
end
endmodule