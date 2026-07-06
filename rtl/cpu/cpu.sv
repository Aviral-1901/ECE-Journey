module cpu(
    input logic clk,
    input logic rst_n
);

logic [31:0] pc; //current pc value
logic [31:0] instruction;
logic [6:0] opcode;
logic [4:0] rs1, rs2, rd;
logic [31:0] imm;
logic zero_flag;
logic RegWrite, MemWrite, ALUSrc, MemToReg, branch;
logic [31:0] read_data1, read_data2;
logic [31:0] alu_result;
logic [31:0] ram_read_data;
logic [31:0] ALUSrc_muxout, MemToReg_muxout, PC_muxout;
logic [31:0] imem [0:255]; //for simulating the instruction memory
logic [2:0] funct3;
logic [6:0] funct7;
logic [3:0] alu_op;


assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];
assign rd  = instruction[11:7];
assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];

assign instruction = imem[pc[9:2]];

initial begin
    $readmemh("tb/cpu/program.hex", imem);
end

always_ff @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin
        pc <= 32'b0;
    end
    else begin
        pc <= PC_muxout;
    end
end

control_unit cu(
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .MemToReg(MemToReg),
    .ALUSrc(ALUSrc),
    .branch(branch),
    .alu_op(alu_op)
);

imm_gen gen(
    .instruction(instruction),
    .imm(imm)
);

register_file reg_file(
    .clk(clk),
    .write_enable(RegWrite),
    .read_address1(rs1),
    .read_address2(rs2),
    .write_address(rd),
    .write_data(MemToReg_muxout),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

alu alu_instantion(
    .a(read_data1),
    .b(ALUSrc_muxout),
    .alu_op(alu_op),
    .result(alu_result),
    .zero(zero_flag)
);

sync_ram #(.DEPTH(256), .WIDTH(32)) ram(
    .clk(clk),
    .write_enable(MemWrite),
    .address(alu_result[9:2]),
    .write_data(read_data2),
    .read_data(ram_read_data)
);

// ALUSrc mux 
assign ALUSrc_muxout = ALUSrc ? imm : read_data2;

// MemToReg mux
assign MemToReg_muxout = MemToReg ? ram_read_data : alu_result;

// pcsel mux
assign PC_muxout = (branch & zero_flag) ? pc+imm : pc+4;

endmodule
