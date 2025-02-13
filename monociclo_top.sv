`timescale 1ns/10ps

module monociclo_top(
    input logic [31:0] instruction, write_data,
    output logic [31:0] ALUResult,
    output logic Zero
);

logic [5:0] op_code, funct_field;
logic [3:0] operation;
logic [1:0] ALUOp;
logic RegDst, ALUScr, MemtoReg, RegWrite, MemRead, MemWrite, Branch;

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
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

endmodule