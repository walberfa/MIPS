/*
Módulo do MUX na entrada do banco de registradores
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale  1ns/10ps

module mux1(
    input logic mux1_control,       // recebe a flag RegDst
    input logic [4:0] inA, inB,     // entradas do MUX
    output logic [4:0] mux1_output  // saída do MUX
);
    always_comb begin
        /*
        Se RegDst está ativo (1), write_register recebe o conteúdo em instruction  [15:11].
        Se não, write_register recebe o conteúdo de instruction [20:16].
        */
        case (mux1_control)
            1'b0 : mux1_output = inA;
            1'b1 : mux1_output = inB;
        endcase
    end
endmodule