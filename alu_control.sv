/*
Controla as operações da ULA de acordo com AULOp e function field
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale 1ns/10ps

module ALU_control(
    input logic [1:0] ALUOp,        // Indica qual operação deve ser realizada
    input logic [5:0] funct_field,  // Indica qual operação deve ser realizada
    output logic [3:0] operation    // Código da operação a ser realizada
);

    always_comb

    begin
        if(ALUOp==2'b00) operation = 4'b0010;
        if(ALUOp[0]==1) operation = 4'b0110;
        if(ALUOp[1]==1) begin
            if(funct_field[3:0]==4'b0000) operation = 4'b0010;
            if(funct_field[3:0]==4'b0010) operation = 4'b0110;
        end 
    end

endmodule