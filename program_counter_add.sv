/*
Módulo que reúne do contador de programa (PC), as ULAs somadoras,
o shif left e o MUX de controle do PC.
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale  1ns/10ps

module program_counter_add(
    input logic [31:0] shift_left_in, // sinal estendido em 32 bits
    input logic Branch,               // flag - indica se a operação é de Branch
    input logic Zero,                 // flag - indica se a saída da ULA é zero
    input logic  clk, rst,            // clock e reset
    output logic [31:0] pc            // contador de programa
);

    logic [31:0] pc_plus_4;         // contador de programa + 4
    logic [31:0] shift_left_2;      // sinal estendido * 2
    logic [31:0] add_result;        // saída do somador
    logic [31:0] mux_output;        // saída do MUX

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 32'b0;      // Reseta a contagem do PC
        end else begin
            pc <= mux_output; // Atualiza o valor de PC
        end
    end
    
    assign pc_plus_4 = pc + 4;
    assign shift_left_2 = shift_left_in << 2;

    assign add_result = pc_plus_4 + shift_left_2;

    /* gerenciamento do MUX:
    Se Branch e Zero estão ativos (1), o PC recebe o endereço da instrução com salto.
    Senão, recebe o endereço + 4 (próxima instrução).
    */
    always_comb begin
        if (Branch && Zero) mux_output = add_result;
        else mux_output = pc_plus_4;
    end

endmodule