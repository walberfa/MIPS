`timescale  1ns/10ps

module datapath(
    input logic [31:0] instruction, write_data,
    input logic ALUScr, RegWrite, RegDst,
    input logic [3:0] ALUControl,
    output logic [31:0] ALUResult,
    output logic Zero
);

logic [4:0] mux1_output;
logic [31:0] scrA, scrB, w_scrB, out32;

    registers registers_inst(
        .read_register1(instruction[25:21]),
        .read_register2(instruction[20:16]),
        .write_register(mux1_output),
        .write_data(write_data),
        .RegWrite(RegWrite),
        .read_data1(scrA),
        .read_data2(w_scrB)
    );

    mux1 mux1_inst(
        .inA(instruction[20:16]),
        .inB(instruction[15:11]),
        .mux1_control(RegDst),
        .mux1_output(mux1_output)
    );

    SignExtend sign_extend_inst(
        .in16(instruction[15:0]),
        .out32(out32)
    );

    muxALUSrc mux_alu_inst(
        .ALUScr(ALUScr),
        .scrB(w_scrB),
        .constante(out32),
        .mux_ALU_output(scrB)
    );

    ALU alu_inst(
        .scrA(scrA),
        .scrB(scrB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

endmodule