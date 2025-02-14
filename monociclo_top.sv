`timescale 1ns/10ps

module monociclo_top(
    input logic clk, rst,
);

logic [31:0] instruction, write_data, pc, ALUResult, out32;
logic [5:0] op_code, funct_field;
logic [3:0] operation;
logic [1:0] ALUOp;
logic Zero, RegDst, ALUScr, MemtoReg, RegWrite, MemRead, MemWrite, Branch;

    control control_inst(
        .op_code(instruction[31:26]),
        .funct_field(instruction[5:0]),
        .RegDst(RegDst),
        .ALUScr(ALUScr),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .operation(operation)
    );

    datapath datapath_inst(
        .instruction(instruction),
        .write_data(write_data),
        .ALUScr(ALUScr),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .ALUControl(operation),
        .clk(clk),
        .rst(rst),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .out32(out32)
    );

    instr_memory instr_memory_inst(
        .read_address(pc)
        .instruction(instruction)
    );

    data_memory data_memory_inst(
        .write_data(write_data),
        .address(ALUResult),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .rst(rst),
        .read_data(write_data)
    );

    program_counter_add program_counter_inst(
        .shift_left_in(out32),
        .Branch(Branch),
        .Zero(Zero),
        .pc(pc)
    );

endmodule