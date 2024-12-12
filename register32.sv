/*
Registrador de 32 bits
Autor: Walber Florencio
Polo UFC
29 Nov 24
*/

`timescale 1ns/10ps

module register_file32(
    input logic [31:0] write_data,
    input logic [4:0] write_register, read_register1, read_register2,
    input logic clk, rst, RegWrite,
    output logic [31:0] read_data1, read_data2
);

    reg [31:0][31:0] X;
    reg [31:0] en;

//Banco de registradores
genvar i;
generate
	for (i = 0; i < 32; i++) begin
		if (i==0)
			register32 reg0(.write_data(write_data), .en(en[0]), .clk(clk), .rst(1'b0),.X(X[0])); //Registrador 0 não permite ser escrito
		else
			register32 regx(.write_data(write_data), .en(en[i]), .clk(clk), .rst(rst), .X(X[i])); //Cria os outros 31 registradores
	end
endgenerate

//Saídas
read_out out1(.read_register(read_register1), .X(X), .read_data(read_data1)); //Instancia a saída 1
read_out out2(.read_register(read_register2), .X(X), .read_data(read_data2)); //Instancia a saída 2

//Lógica para habilitar escrita nos registradores
always_ff @ (posedge clk) begin
	en = 32'd0;

    if(RegWrite) begin    
		for (int j = 0; j < 32; j++)
			if(write_register==j) en[j] = 1'b1;
		end
end
endmodule

//Módulo do registrador
module register32(
	input logic [31:0] write_data,
	input logic clk, rst, en,
	output reg [31:0] X
	);

	always_ff @ (posedge clk) begin
		if (rst&en) X = write_data;
		else if (rst&~en) X = X;
		else X = 'd0;
	end
endmodule

//Módulo para fazer a leitura do dado da saída
module read_out(
	input logic [4:0] read_register,
	logic [31:0][31:0] X,
	output logic [31:0] read_data);

always_comb begin
	for (int l = 0; l < 32; l++)
		if(read_register==l) read_data = X[l];
end

endmodule
