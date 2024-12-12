`timescale  1ns/10ps

module ula32_tb();
    logic [3:0] ULAControl;
    logic [31:0] scrA, scrB, ULAResult;
    logic Zero;
    
ula32 ula_1(.ULAControl(ULAControl), .scrA(scrA), .scrB(scrB), .ULAResult(ULAResult), .Zero(Zero));

initial begin
    scrA = 32'b00000000000000000000000000000011; //3
    scrB = 32'b00000000000000000000000000000010; //2
    
    ULAControl = 4'b0000; //Soma. Espera: 5
    #10;

    ULAControl = 4'b0001; //Subtração. Espera: 1
    #10;

    ULAControl = 4'b0010; //Subtração. Espera: 1
    #10;

    ULAControl = 4'b0011; //AND. Espera: 32'b10
    #10;

    ULAControl = 4'b0100; //OR. Espera: 32'b11
    #10;

    ULAControl = 4'b0101; //XOR. Espera: 32'b01
    #10;

    ULAControl = 4'b0110; //SLE. Espera: 32'b1100
    #10;

    ULAControl = 4'b0111; //SLD. Espera: 32'b0
    #10;

    ULAControl = 4'b1000; //SAD. Espera: 32'b0
    #10;

    scrA = 32'b00000000000000000000000000000100; //4
    scrB = 32'b00000000000000000000000000000101; //5
    
    ULAControl = 4'b0000; //Soma. Espera: 9
    #10;

    ULAControl = 4'b0001; //Subtração. Espera: -1
    #10;

    ULAControl = 4'b0010; //Subtração. Espera: -1
    #10;

    ULAControl = 4'b0011; //AND. Espera: 32'b100
    #10;

    ULAControl = 4'b0100; //OR. Espera: 32'b101
    #10;

    ULAControl = 4'b0101; //XOR. Espera: 32'b01
    #10;

    ULAControl = 4'b0110; //SLE. Espera: 32'b10000000
    #10;

    ULAControl = 4'b0111; //SLD. Espera: 32'b0
    #10;

    ULAControl = 4'b1000; //SAD. Espera: 32'b0
    #10;

    scrA = 32'b11000000000000000000000000000100;
    scrB = 32'b00000000000000000000000000000100;
    
    ULAControl = 4'b0000; //Soma. Espera: 11000000000000000000000000001000
    #10;

    ULAControl = 4'b0001; //Subtração. Espera: 11000000000000000000000000000000
    #10;

    ULAControl = 4'b0010; //Subtração. Espera: 11000000000000000000000000000000
    #10;

    ULAControl = 4'b0011; //AND. Espera: 00000000000000000000000000000100
    #10;

    ULAControl = 4'b0100; //OR. Espera: 11000000000000000000000000000100
    #10;

    ULAControl = 4'b0101; //XOR. Espera: 11000000000000000000000000000000
    #10;

    ULAControl = 4'b0110; //SLE. Espera: 00000000000000000000000001000000
    #10;

    ULAControl = 4'b0111; //SLD. Espera: 00001100000000000000000000000000
    #10;

    ULAControl = 4'b1000; //SAD. Espera: 11111100000000000000000000000000
    #10;
end

initial begin
    $display("              Tempo ULAControl	  	scrA				scrB	  			Saída			Zero");
    $monitor($time, "  %b  %b %b %b	 %b", ULAControl, scrA, scrB, ULAResult, Zero);
end

endmodule
