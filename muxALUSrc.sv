/*
Módulo do MUX na entrada da ULA
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale  1ns/10ps

module muxALUSrc(
    input logic ALUScr,                     // flag de controle
    input logic [31:0] scrB, constante,     // entradas do MUX
    output logic [31:0] mux_ALU_output      // saída do MUX
);
    always_comb begin
        /*
        Se ALUScr está ativo (1), a entrada da ULA recebe o conteúdo da saída do estensor de sinal.
        Se não, write_register recebe o conteúdo da saída B do registrador.
        */
        case (ALUScr)
        1'b0 : mux_ALU_output = scrB;
        1'b1 : mux_ALU_output = constante;
    endcase

    end
endmodule