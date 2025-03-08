`timescale 1ns/10ps

module instr_memory (
    input logic [31:0] read_address,
    output logic [31:0] instruction
);

    // Definindo a memória como um array de 256 palavras de 8 bits
    logic [0:255][7:0] memory ;

    // Inicializando a memória com algumas instruções
    initial begin
        // Exemplo de inicialização de memória com instruções
        memory[0+:4] = 32'h8C080005;  // LW $t0, 0($5)      ; Carrega a palavra da memória no endereço 5 para o registrador $t0
        memory[4+:4] = 32'h2324820;   // ADD $t1, $s1, $s2  ; Soma os valores dos registradores $s1 e $s2 e armazena o resultado no registrador $t1
        memory[8+:4] = 32'h2325022;   // SUB $t2, $s1, $s2  ; Subtrai os valores dos registradores $s1 e $s2 e armazena o resultado no registrador $t2
        memory[12+:4] = 32'hAC09000A; // SW $t1, 0($10)     ; Armazena o valor do registrador $t1 na memória no endereço 10
        memory[16+:4] = 32'h02295820; // ADD $t3, $s1, $t1  ; Soma os valores dos registradores $s1 e $t1 e armazena o resultado no registrador $t3
        memory[20+:4] = 32'h110B0004; // BEQ $t0, $t3, 4    ; Se os valores dos registradores $t0 e $t3 forem iguais, desvia com 4 de deslocamento
        // Simulando que há mais instruções na memória...
    end

    // Lê a instrução da memória na posição especificada por read_address
    always_comb begin
        instruction <= memory[read_address+:4];
    end

endmodule