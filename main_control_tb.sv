/*
Testbench para validar o controle principal
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale 1ns/10ps

module main_control_tb();
    logic [5:0] op_code;
    logic RegDst, ALUScr, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0;

    main_control tb1(
        .op_code(op_code),
        .RegDst(RegDst),
        .ALUScr(ALUScr),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp1(ALUOp1),
        .ALUOp0(ALUOp0)
    );

    initial begin
        op_code = 6'b000000; // espera as flags para R-format
        #10;

        op_code = 6'b100011; // espera as flags para LW
        #10;

        op_code = 6'b101011; // espera as flags para SW
        #10;

        op_code = 6'b000100; // espera as flags para BEQ
        #10;
    end

    initial begin
        $display("                Time  OP Code     Operation ");
        $monitor($time, "  %b   %b %b %b %b %b %b %b %b %b", op_code, RegDst, ALUScr, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0);
    end

endmodule