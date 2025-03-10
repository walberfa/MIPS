/*
Banco de registradores
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale 1ns/10ps

module registers (
    input logic clk,
    input logic rst,
    input logic RegWrite,
    input logic [4:0] read_register1,
    input logic [4:0] read_register2,
    input logic [4:0] write_register,
    input logic [31:0] write_data,
    output logic [31:0] read_data1,
    output logic [31:0] read_data2
);

    // Definindo os 32 registradores de 32 bits
    logic [31:0] data [31:0];

    // Inicializa os registradores com zero no reset
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 32; i++) begin
                data[i] <= 32'b0;
            end
        end else if (RegWrite) begin
            if (write_register != 5'b0) begin           // Registrador 0 sempre é zero
                data[write_register] <= write_data;     // Escreve no registrador
            end
        end
    end

    // Leitura dos registradores
    assign read_data1 = (read_register1 != 5'b0) ? data[read_register1] : 32'b0;
    assign read_data2 = (read_register2 != 5'b0) ? data[read_register2] : 32'b0;

endmodule