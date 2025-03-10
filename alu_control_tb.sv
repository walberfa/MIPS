/*
Testbench para validar o controle da ULA
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale 1ns/10ps

module ALU_control_tb();
    logic [1:0] ALUOp;
    logic [5:0] funct_field;
    logic [3:0] operation;

    ALU_control tb2(
        .ALUOp(ALUOp),
        .funct_field(funct_field),
        .operation(operation)
    );

    initial begin
        /**Espera operation = 0010**/
        ALUOp = 2'b00; // LW or SW
        funct_field = 6'b000010; // subtract
        #10;

        /**Espera operation = 0110**/
        ALUOp = 2'b01; // Branch equal
        #10;

        /**Espera operation = 0110**/
        ALUOp = 2'b10; // R-type
        #10;

        /**Espera operation = 0010**/
        funct_field = 6'b000000; // add
        #10;

        /**Espera operation = 0010**/
        ALUOp = 2'b11; // Não está no escopo
        #10;
    end

    initial begin
        $display("                 Time  ALUOp   Funct-field  Operation ");
        $monitor($time, "     %b    %b       %b", ALUOp, funct_field, operation);
    end


endmodule