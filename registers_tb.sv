`timescale 1ns/10ps

module tb_registers;

    // Sinais de entrada e saída
    logic [31:0] write_data;
    logic [4:0] read_register1, read_register2, write_register;
    logic RegWrite;
    logic clk, rst;
    logic [31:0] read_data1, read_data2;

    // Instancia o módulo registers
    registers reg32 (
        .write_data(write_data),
        .read_register1(read_register1),
        .read_register2(read_register2),
        .write_register(write_register),
        .RegWrite(RegWrite),
        .clk(clk),
        .rst(rst),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa os sinais
        clk = 0;
        rst = 0;
        RegWrite = 0;
        write_data = 32'h0;
        read_register1 = 5'h0;
        read_register2 = 5'h0;
        write_register = 5'h0;

        // Aplica reset
        #1;
        rst = 1;
        #9;
        rst = 0;
        $display("Iniciando testes...");

        // Teste 1: Escreve no registrador 1 e lê do registrador 1
        write_data = 32'hA5A5A5A5;
        write_register = 5'h1;
        RegWrite = 1;
        #10;
        RegWrite = 0;
        read_register1 = 5'h1;
        #10;
        $display("Teste 1 ($1) - read_data1: %h (esperado: A5A5A5A5)", read_data1);

        // Teste 2: Lê do registrador 0 (deve ser sempre 0)
        #10;
        write_register = 5'h0;
        RegWrite = 1;
        #10;
        RegWrite = 0;
        read_register2 = 5'h0;
        #10;
        $display("Teste 2 ($0) - read_data2: %h (esperado: 00000000)", read_data2);

        // Teste 3: Escreve no registrador 2 e lê do registrador 2
        #10;
        write_data = 32'h42424242;
        write_register = 5'h2;
        RegWrite = 1;
        #10;
        RegWrite = 0;
        read_register2 = 5'h2;
        #10;
        $display("Teste 3 ($2) - read_data2: %h (esperado: 42424242)", read_data2);

        // Teste 4: Escreve no registrador 10 e lê do registrador 10
        #10;
        write_data = 32'h12345678;
        write_register = 5'hA;
        RegWrite = 1;
        #10;
        RegWrite = 0;
        read_register1 = 5'hA;
        #10;
        $display("Teste 4 ($10) - read_data2: %h (esperado: 12345678)", read_data1);

        // Teste 5: Reseta e lê os registradores 2 e 10
        #10;
        rst = 1;
        #10;
        $display("Resetando...");
        $display("Teste 5 ($10) - read_data1: %h (esperado: 00000000)", read_data1);
        $display("Teste 5 ($2)  - read_data2: %h (esperado: 00000000)", read_data2);
        
        // Finaliza a simulação
        $finish;
    end

endmodule