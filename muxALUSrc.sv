`timescale  1ns/10ps

module muxALUSrc(
    input logic ALUScr,
    input logic [31:0] scrB, constante,
    output logic [31:0] mux_ALU_output
);
    always_comb begin
        
        case (ALUScr)
        1'b0 : mux_ALU_output = scrB;
        1'b1 : mux_ALU_output = constante;
    endcase

    end
endmodule