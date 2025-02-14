module instr_memory (
    input logic [31:0] read_address,
    output logic [31:0] instruction
);

    // Definindo a memória como um array de 256 palavras de 32 bits
    logic [31:0] memory [255:0];

    // Inicializando a memória com algumas instruções
    initial begin
        // Exemplo de inicialização de memória com instruções
        memory[0] = 32'h8C010000; // LW $1, 0($0)    ; Carrega a palavra da memória no endereço 0 para o registrador $1
        memory[1] = 32'h8C020004; // LW $2, 4($0)    ; Carrega a palavra da memória no endereço 4 para o registrador $2
        memory[2] = 32'h00221820; // ADD $3, $1, $2  ; Soma os valores dos registradores $1 e $2 e armazena o resultado no registrador $3
        memory[3] = 32'h00432022; // SUB $4, $2, $3  ; Subtrai o valor do registrador $3 do valor do registrador $2 e armazena o resultado no registrador $4
        memory[4] = 32'hAC030008; // SW $3, 8($0)    ; Armazena o valor do registrador $3 na memória no endereço 8
        memory[5] = 32'hAC04000C; // SW $4, 12($0)   ; Armazena o valor do registrador $4 na memória no endereço 12
        memory[6] = 32'h10620001; // BEQ $3, $2, 1   ; Se os valores dos registradores $3 e $2 forem iguais, desvia para a instrução no endereço 8
        memory[7] = 32'h08000000; // J 0             ; Salta para a instrução no endereço 0 (loop infinito)
        // Adicione mais instruções conforme necessário
    end

    // Lê a instrução da memória na posição especificada por read_address
    assign instruction = memory[read_address];

endmodule