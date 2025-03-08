`timescale 1ns/10ps

module monociclo_top(
    input logic clk, rst,
    output logic [31:0] instruction, write_data, 
    output logic [3:0] operation,
    output logic Zero
);

logic [31:0] pc, out32, ALUResult, w_scrB;
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
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .ALUControl(operation),
        .clk(clk),
        .rst(rst),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .w_scrB(w_scrB),
        .out32(out32)
    );

    instr_memory instr_memory_inst(
        .read_address(pc),
        .instruction(instruction)
    );

    data_memory data_memory_inst(
        .write_data(w_scrB),
        .address(ALUResult),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .rst(rst),
        .clk(clk),
        .read_data(write_data)
    );

    program_counter_add program_counter_inst(
        .shift_left_in(out32),
        .Branch(Branch),
        .Zero(Zero),
        .rst(rst),
        .clk(clk),
        .pc(pc)
    );

endmodule