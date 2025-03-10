/*
Módulo com todos os componentes do Caminho de Dados
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale  1ns/10ps

module datapath(
    input logic [31:0] instruction,                                     // instrução a ser executada
    input logic [31:0] write_data,                                      // dado a ser escrito nos registradores
    input logic ALUScr, RegWrite, RegDst, MemRead, MemWrite, MemtoReg,  // flags de controle
    input logic [3:0] ALUControl,                                       // controle da ULA
    input logic clk, rst,                                               // clock e reset
    output logic [31:0] ALUResult,                                      // saída da ULA
    output logic [31:0] out32,                                          // saída estendida de 16 para 32 bits
    output logic [31:0] w_scrB,                                         // saída dos registradores - vai para o MUX da memória de dados
    output logic Zero                                                   // flag - indica que a operação da ULA é igual a zero
);

logic [4:0] mux1_output;
logic [31:0] scrA, scrB;

    // instancia do banco de registradores
    registers registers_inst(
        .read_register1(instruction[25:21]),
        .read_register2(instruction[20:16]),
        .write_register(mux1_output),
        .write_data(write_data),
        .RegWrite(RegWrite),
        .clk(clk), 
        .rst(rst), 
        .read_data1(scrA),
        .read_data2(w_scrB)
    );

    // MUX na entrada do banco de registradores
    mux1 mux1_inst(
        .inA(instruction[20:16]),
        .inB(instruction[15:11]),
        .mux1_control(RegDst),
        .mux1_output(mux1_output)
    );

    // Estende o sinal de 16 para 32 bits
    SignExtend sign_extend_inst(
        .in16(instruction[15:0]),
        .out32(out32)
    );

    // MUX na entrada da ULA
    muxALUSrc mux_alu_inst(
        .ALUScr(ALUScr),
        .scrB(w_scrB),
        .constante(out32),
        .mux_ALU_output(scrB)
    );

    // instancia da ULA
    ALU alu_inst(
        .scrA(scrA),
        .scrB(scrB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

endmodule