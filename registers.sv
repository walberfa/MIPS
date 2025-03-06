`timescale 1ns/10ps

module registers (
        input logic [31:0] write_data,
        input logic [4:0] read_register1, read_register2, write_register,
        input logic RegWrite,
        input logic clk, rst,
        output logic [31:0] read_data1, read_data2
    );

    reg [31:0][31:0] data;
    reg [31:0] en;

    // Banco de registradores
    genvar i;  
    generate
        for (i = 0; i < 32; i++) begin
            if (i==0)
                register32 reg0(.write_data(write_data), .en(en[0]), .clk(clk), .rst(1'b0),.data(data[0])); // Registrador 0 não permite ser escrito
            else
                register32 regx(.write_data(write_data), .en(en[i]), .clk(clk), .rst(rst), .data(data[i])); // Cria os outros 31 registradores
        end
    endgenerate

    // Saídas
    read_out out1(.read_register(read_register1), .data(data), .read_data(read_data1)); // Instancia a saída 1
    read_out out2(.read_register(read_register2), .data(data), .read_data(read_data2)); // Instancia a saída 2


    //Lógica para habilitar escrita nos registradores
    always_comb begin
        en = 32'd0;

        if(RegWrite) begin    
            for (int j = 0; j < 32; j++)
                if(write_register==j) en[j] = 1'b1;
            end
    end

endmodule


// Módulo do registrador
module register32(
    input logic [31:0] write_data,
    input logic clk, rst, en,
    output reg [31:0] data
    );

    always_ff @ (posedge clk) begin
        if (rst&en) data = write_data;
        else if (rst&~en) data = data;
        else data = 'd0;
    end

endmodule

// Módulo para fazer a leitura do dado da saída
module read_out(
    input logic [4:0] read_register,
    logic [31:0][31:0] data,
    output logic [31:0] read_data);

    always_comb begin
        for (int l = 0; l < 32; l++)
            if(read_register==l) read_data = data[l];
    end

endmodule