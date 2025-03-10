/*
Unidade de extensão de sinal (de 16 para 32 bits)
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale  1 ns/10ps

module SignExtend (
    input logic [15:0] in16,
    output logic [31:0] out32
);

assign out32[31:16] = {16{in16[15]}}; //Repete o bit de sinal nos bits adicionais
assign out32[15:0] = in16;

endmodule