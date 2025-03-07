`timescale 1ns/10ps

module data_memory (
    input logic [31:0] address,
    input logic [31:0] write_data,
    input logic MemRead,
    input logic MemWrite,
    input logic MemtoReg,
    input logic rst,
    input logic clk,
    output logic [31:0] read_data
);

    logic [31:0] data_from_mem, data_from_alu;

    // Definindo a memória como um array de 256 palavras de 32 bits
    logic [31:0] memory [255:0];

    assign data_from_alu = address;

    always_ff @(posedge rst) begin
        // Zera a memória
        for (int i = 0; i < 256; i++) begin
            memory[i] <= 32'b0;
        end
    end
    
    always_ff @(posedge clk) begin
        if (MemWrite) begin
            // Escreve o dado na memória na posição especificada por address
            memory[address] <= write_data;
        end
        if (MemRead) begin
            // Lê o dado da memória na posição especificada por address
            data_from_mem <= memory[address];
        end
    end

    /*
    MUX que seleciona a saída da memória ou da ALU. 
    Se MemtoReg estiver ativo, a saída vem da memória, caso contrário, da ALU.
    */
    always_comb begin
        if (rst) read_data = 32'b0;
        else
            if (MemtoReg) read_data = data_from_mem;
            else read_data = data_from_alu;
    end

endmodule