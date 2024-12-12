/*
ULA de 32 bits
Autor: Walber Florencio
Polo UFC
29 Nov 24
*/

`timescale  1ns/10ps

module ula32(
  input logic [3:0] ULAControl,
  input logic [31:0] scrA, scrB,
  output logic [31:0] ULAResult,
  output logic Zero
);
  
  always_comb
  
  begin

   case(ULAControl)
      4'b0000 : ULAResult = scrA + scrB; //Adição
      4'b0001 : ULAResult = scrA + ~scrB + 1; //Subtração (complemento 2)
      4'b0010 : ULAResult = signed'(scrA) - signed'(scrB); //Subtração com sinal
      4'b0011 : ULAResult = scrA & scrB; //AND
      4'b0100 : ULAResult = scrA | scrB; //OR
      4'b0101 : ULAResult = scrA ^ scrB; //XOR
      4'b0110 : ULAResult = scrA << scrB; //Shift lógico a esquerda
      4'b0111 : ULAResult = scrA >> scrB; //Shift lógico a direita
      4'b1000 : ULAResult = signed'(scrA) >>> scrB; //Shift aritmético a direita
    endcase

    if (ULAResult == 32'b0) Zero = 1;
    else Zero = 0;
  end

endmodule
