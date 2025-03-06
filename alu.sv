`timescale  1ns/10ps

module ALU(
    input logic [31:0] scrA, scrB,
    input logic [3:0] ALUControl,
    output logic [31:0] ALUResult,
    output logic Zero
);

  always_comb begin

   case(ALUControl)
        4'b0000 : ALUResult = scrA & scrB;    // AND
        4'b0001 : ALUResult = scrA | scrB;    // OR
        4'b0010 : ALUResult = scrA + scrB;    // Adição *******
        4'b0110 : ALUResult = scrA - scrB;    // Subtração ****
        4'b0111 : ALUResult = scrA < scrB;    // Menor que
        4'b1100 : ALUResult = ~(scrA | scrB); // NOR
    endcase

    if (ALUResult == 32'b0) Zero = 1;
    else Zero = 0;
  end
    
endmodule