/*
Testbench para validar a memória de dados
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale 1ns/10ps

module tb_data_memory;

    // Sinais de entrada e saída
    logic [31:0] address, write_data;
    logic MemRead, MemWrite, MemtoReg;
    logic rst, clk;
    logic [31:0] read_data;

    // Instancia o módulo data_memory
    data_memory data_memory_tb (
        .address(address),
        .write_data(write_data),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .rst(rst),
        .clk(clk),
        .read_data(read_data)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa os sinais
        clk = 1;
        rst = 0;
        address = 32'h00000000;
        write_data = 32'h00000000;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 0;

        // Aplica reset
        rst = 1;
        #10;
        rst = 0;

        // Teste de escrita na memória
        // Escreve 0xDEADBEEF no endereço 4
        address = 32'h00000004;
        write_data = 32'hDEADBEEF;
        MemWrite = 1;
        #10;
        MemWrite = 0;

        // Teste de leitura da memória com MemtoReg = 1
        // Lê do endereço 4
        MemRead = 1;
        MemtoReg = 1;
        #10;
        MemRead = 0;
        MemtoReg = 0;
        $display("Teste de leitura (mem $4) com MemtoReg = 1 - read_data: %h (esperado: DEADBEEF)", read_data);

        // Teste de leitura da memória com MemtoReg = 0
        // Lê do endereço 4
        MemRead = 1;
        #10;
        MemRead = 0;
        $display("Teste de leitura (mem $4) com MemtoReg = 0 - read_data: %h (esperado: 00000004)", read_data);

        // Teste de escrita na memória
        // Escreve 0xCAFEBABE no endereço 8
        address = 32'h00000008;
        write_data = 32'hCAFEBABE;
        MemWrite = 1;
        #10;
        MemWrite = 0;

        // Teste de leitura da memória com MemtoReg = 1
        // Lê do endereço 8
        MemRead = 1;
        MemtoReg = 1;
        #10;
        MemRead = 0;
        MemtoReg = 0;
        $display("Teste de leitura (mem $8) com MemtoReg = 1 - read_data: %h (esperado: CAFEBABE)", read_data);

        // Teste de leitura da memória com MemtoReg = 0
        // Lê do endereço 8
        MemRead = 1;
        #10;
        MemRead = 0;
        $display("Teste de leitura (mem $8) com MemtoReg = 0 - read_data: %h (esperado: 00000008)", read_data);

        // Teste de reset da memória
        rst = 1;
        #10;
        $display("Teste de reset da memória - read_data: %h (esperado: 00000000)", read_data);
        rst = 0;

        // Teste de escrita na memória
        // Escreve 0x0DE07A01 no endereço 10
        address = 32'h0000000A;
        write_data = 32'h0DE07A01;
        MemWrite = 1;
        #10;
        MemWrite = 0;

        // Teste de leitura da memória com MemtoReg = 1
        // Lê do endereço 10
        MemRead = 1;
        MemtoReg = 1;
        #10;
        MemRead = 0;
        MemtoReg = 0;
        $display("Teste de leitura (mem $10) com MemtoReg = 1 - read_data: %h (esperado: 0DE07A01)", read_data);

        // Teste de leitura da memória com MemtoReg = 0
        // Lê do endereço 10
        MemRead = 1;
        #10;
        MemRead = 0;
        $display("Teste de leitura (mem $10) com MemtoReg = 0 - read_data: %h (esperado: 0000000A)", read_data);


        // Finaliza a simulação
        $finish;
    end

endmodule