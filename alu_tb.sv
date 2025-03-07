`timescale  1ns/10ps

module ALU_tb();
    logic [31:0] scrA, scrB;
    logic [3:0] ALUControl;
    logic [31:0] ALUResult;
    logic Zero;

    ALU alu(
        .scrA(scrA),
        .scrB(scrB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    initial begin
        scrA = 8'h03;  // 3
        scrB = 8'h02;  // 2

        ALUControl = 4'b0010; // Adição. Espera: 5
        #10;

        ALUControl = 4'b0110; // Subtração. Espera: 1
        #10;

        scrA = 8'h1A;   // 26
        scrB = 8'h0F;   // 15

        ALUControl = 4'b0010; // Adição. Espera: 41
        #10;

        ALUControl = 4'b0110; // Subtração. Espera: 11
        #10;

        scrA = 8'h0A;   // 10
        scrB = 8'h0A;   // 10

        ALUControl = 4'b0010; // Adição. Espera: 20
        #10;

        ALUControl = 4'b0110; // Subtração. Espera: 0
        #10;

        $finish;
    end

    initial begin
        $display("              Tempo  ALUControl   scrA        scrB	    Saída Zero");
        $monitor($time, "  %b  %d %d    %d      %b", ALUControl, scrA, scrB, ALUResult, Zero);
    end

endmodule