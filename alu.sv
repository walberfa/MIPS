module ALU(
    input logic [31:0] scrA, scrB,
    input logic [3:0] ALUControl,
    output logic [31:0] ALUResult,
    output logic Zero
);

  always_comb
  
  begin

   case(ULAControl)
        4'b0000 : ULAResult = scrA & scrB;    // AND
        4'b0001 : ULAResult = scrA | scrB;    // OR
        4'b0010 : ULAResult = scrA + scrB;    // Adição *******
        4'b0110 : ULAResult = scrA - scrB;    // Subtração ****
        4'b0111 : ULAResult = scrA < scrB;    // Menor que
        4'b1100 : ULAResult = ~(scrA | scrB); // NOR
    endcase

    if (ULAResult == 32'b0) Zero = 1;
    else Zero = 0;
  end
    
endmodule