module data_mem #(
    parameter DEPTH = 256,
    parameter WIDTH = 32
) (
    input logic clk,
    input logic write_enable,
    input logic [31:0] address,
    input logic [WIDTH-1:0] write_data,
    input logic [2:0] funct3,
    output logic [WIDTH-1:0] read_data
);

logic [WIDTH-1:0] ram [DEPTH];

logic [7:0] word_address;
logic [1:0] byte_offset;
assign word_address = address[9:2];
assign byte_offset = address[1:0];

always_ff @(posedge clk) begin
    if (write_enable) begin
        ram[word_address] <= write_data;
    end
end


logic [31:0] raw;
logic [31:0] shifted_raw;
assign raw = ram[word_address];
assign shifted_raw = raw >> (byte_offset * 8);

logic [31:0] lb_out, lh_out, lw_out, lbu_out, lhu_out;
assign lb_out  = {{24{shifted_raw[7]}}, shifted_raw[7:0]};
assign lh_out  = {{16{shifted_raw[15]}}, shifted_raw[15:0]};
assign lw_out  = raw;
assign lbu_out = {24'b0, shifted_raw[7:0]};
assign lhu_out = {16'b0, shifted_raw[15:0]};


always_comb begin
    case(funct3)
        3'b000: read_data = lb_out;  // LB 
        3'b001: read_data = lh_out;  // LH 
        3'b010: read_data = lw_out;  // LW 
        3'b100: read_data = lbu_out; // LBU 
        3'b101: read_data = lhu_out; // LHU 
        default: read_data = lw_out;
    endcase
end
endmodule

