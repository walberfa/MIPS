/*
Testbench para validar a memória de instruções
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale 1ns/10ps

module tb_instr_memory;

    // Sinais de entrada e saída
    logic [31:0] read_address;
    logic [31:0] instruction;

    // Instancia o módulo instr_memory
    instr_memory instr_memory_tb (
        .read_address(read_address),
        .instruction(instruction)
    );

    initial begin
        // Inicializa os sinais
        read_address = 32'h00000000;

        // Teste de leitura de instruções
        // Lê a instrução no endereço 0
        #10;
        read_address = 32'h00000000;
        #10;
        $display("Instrução no endereço 0: %h (esperado: 8C080005)", instruction);

        // Lê a instrução no endereço 4
        #10;
        read_address = 32'h00000004;
        #10;
        $display("Instrução no endereço 4: %h (esperado: 02324820)", instruction);

        // Lê a instrução no endereço 8
        #10;
        read_address = 32'h00000008;
        #10;
        $display("Instrução no endereço 8: %h (esperado: 02325022)", instruction);

        // Lê a instrução no endereço 12
        #10;
        read_address = 32'h0000000C;
        #10;
        $display("Instrução no endereço 12: %h (esperado: AC09000A)", instruction);

        // Lê a instrução no endereço 16
        #10;
        read_address = 32'h00000010;
        #10;
        $display("Instrução no endereço 16: %h (esperado: 02295820)", instruction);

        // Lê a instrução no endereço 20
        #10;
        read_address = 32'h00000014;
        #10;
        $display("Instrução no endereço 20: %h (esperado: 110B0004)", instruction);

        // Finaliza a simulação
        $finish;
    end

endmodule