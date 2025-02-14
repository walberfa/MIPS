/*
Autor do testbench: Walber Florencio 

Cenários avaliados:
- Escrita em alguns registradores;
- Leitura em alguns registradores;
- Leitura de registradores após resetar;
- Tentativa de escrita com a entrada RegWrite desabilitada;
- Tentativa de escrita no registrador 0.

Foram adicionados asserts para verificação automática,
mas o teste exibe uma saída em tabela para validação.
*/

`timescale 1ns/10ps

module reg32_tb;
    logic[31:0] write_data, read_data1, read_data2;
    logic [4:0] write_register, read_register1, read_register2;
    logic RegWrite, clk, rst;

registers regx(
    .write_data(write_data), 
    .write_register(write_register), 
    .RegWrite(RegWrite), 
    .read_register1(read_register1), 
    .read_register2(read_register2), 
    .clk(clk), 
    .rst(rst), 
    .read_data1(read_data1), 
    .read_data2(read_data2));

	
initial	begin
	clk = 0;
	forever #1 clk = ~clk;
end

initial begin
    #3;

    RegWrite = 1'b1;
    write_data = 32'b01100011011000110110001101100011;
    rst = 1'b1;

    read_register1 = 5'b11010;
    read_register2 = 5'b10011;

    write_register = 5'b10011;
    #10;
    write_register = 5'b11010;
    #10;
    write_register = 5'b01001;
    #10

    if(read_data1!== 32'b01100011011000110110001101100011) $display("Error:		read_data1 incorrect!");
	
    rst = 1'b0;
    #5;

    if((read_data1|read_data2)!== 32'b0) $display("Error: 		reset failed!");

    write_data = 32'b01110111011101110111011101110111;
    rst = 1'b1;
    #5;

    read_register2 = 5'b01001;
    #10;

    if(read_data2!== 32'b01110111011101110111011101110111) $display("Error:		read_data2 incorrect!");

    read_register1 = 5'b11110;

    RegWrite = 1'b0;
    #5;

    write_register = 5'b11110;
    #10;

    if(read_data1!== 32'b0) $display("Error:		read_data1 disabled!");

    RegWrite = 1'b1;
    #5;

    write_register = 5'b11110;
    read_register2 = 5'b00000;
    #10;

    write_register = 5'b00000;
    #10;

    $finish;

end

initial begin
    $display("              Tempo   rst  write_register  read_register1 read_register2          Saída(read_data1)                   Saída(read_data2)");
    $monitor($time, "   %b      %b           %b       %b                %b      %b", rst, write_register, read_register1, read_register2, read_data1, read_data2);
end

endmodule
