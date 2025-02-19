`timescale 1ns/10ps

module control_tb();
    logic [5:0] op_code, funct_field;
    logic RegDst, ALUScr, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    logic [3:0] operation;

    control control_inst(
        .op_code(op_code),
        .funct_field(funct_field),
        .RegDst(RegDst),
        .ALUScr(ALUScr),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .operation(operation)
    );

    initial begin
        op_code = 6'b000000;        // R-format
        funct_field = 6'b100000;    // Add
        #10;

        funct_field = 6'b100010;    // Substract
        #10;

        op_code = 6'b100011;        // LW
        #10;

        op_code = 6'b101011;        // SW
        funct_field = 6'b0;         // Don't care
        #10;

        op_code = 6'b000100;        // BEQ
        #10;
    end

    initial begin
        $display("                Time  OPCode  FunctionField    Operation ");
        $monitor($time, "  %b   %b      %b %b %b %b %b %b %b %b", op_code, funct_field, RegDst, ALUScr, MemtoReg, RegWrite, MemRead, MemWrite, Branch, operation);
    end

endmodule