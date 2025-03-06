`timescale  1ns/10ps

module datapath_tb();
    logic [31:0] instruction, write_data;
    logic ALUScr, RegWrite, RegDst;
    logic [3:0] ALUControl;
    logic clk, rst;
    logic [31:0] ALUResult, out32;
    logic Zero;

    datapath datapath_inst(
        .instruction(instruction),
        .write_data(write_data),
        .ALUScr(ALUScr),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .ALUControl(ALUControl),
        .clk(clk),
        .rst(rst),
        .ALUResult(ALUResult),
        .out32(out32),
        .Zero(Zero)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa os sinais
        clk = 1;
        rst = 0;
        instruction = 32'h00000000;
        write_data = 32'h00000000;
        ALUScr = 0;
        RegWrite = 0;
        RegDst = 0;
        ALUControl = 4'b0010;
        #1;

        rst = 1;
        RegWrite = 1;
        ALUScr = 1;
        #9;

        // LW
        instruction = 32'h8C010002;
        write_data = 32'h00000002;
        #10;

        // LW
        instruction = 32'h8C020004;
        write_data = 32'h00000004;
        #10;

        // ADD
        write_data = 32'h00000000;
        instruction = 32'h00220800;
        RegDst = 1;
        ALUScr = 0;
        #50;

        $finish;
    end

    initial begin
        $display("            Time Instruction  WriteData  ALUScr  RegWrite  RegDst  ALUControl  ALUResult  Zero");
        $monitor($time, "  %h %h %b %b %b %b %h %b", instruction, write_data, ALUScr, RegWrite, RegDst, ALUControl, ALUResult, Zero);
    end

endmodule