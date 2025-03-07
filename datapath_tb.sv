`timescale 1ns/10ps

module tb_datapath;

    // Sinais de entrada e saída
    logic clk;
    logic rst;
    logic [31:0] instruction;
    logic [31:0] write_data;
    logic ALUScr;
    logic RegWrite;
    logic RegDst;
    logic MemRead;
    logic MemWrite;
    logic MemtoReg;
    logic [3:0] ALUControl;
    logic [31:0] ALUResult;
    logic [31:0] out32;
    logic Zero;
    logic [31:0] read_data;

    // Instancia o módulo datapath
    datapath uut (
        .instruction(instruction),
        .ALUScr(ALUScr),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .ALUControl(ALUControl),
        .clk(clk),
        .rst(rst),
        .ALUResult(ALUResult),
        .out32(out32),
        .Zero(Zero),
        .read_data(read_data)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa os sinais
        clk = 1;
        rst = 1;
        instruction = 32'h00000000;
        write_data = 32'h00000000;
        ALUScr = 0;
        RegWrite = 0;
        RegDst = 0;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 0;
        ALUControl = 4'b0000;
        #10;

        // Desliga o reset
        rst = 0;

        // Inicializa os registradores
        uut.registers_inst.data[17] = 32'h00000004; // $s1 = 4
        uut.registers_inst.data[18] = 32'h00000002; // $s2 = 2

        // Inicializa a memória
        uut.data_memory_inst.memory[5] = 32'h00000010; // Memória no endereço $5 = 16

        // Teste da instrução LW
        // LW $t0, 0($5)
        #10;
        instruction = 32'h8C080005; // LW $t0, 0($5)
        ALUScr = 1;
        RegDst = 0;
        RegWrite = 1;
        MemRead = 1;
        MemWrite = 0;
        MemtoReg = 1;
        ALUControl = 4'b0010;
        #30;
        $display("+------TESTE LW------+");
        $display(" opcode: %b", instruction[31:26]);
        $display(" rs:     %b", instruction[25:21]);
        $display(" rt:     %b", instruction[20:16]);
        $display(" offset: %b", instruction[15:0]);
        $display(" write register: %h", uut.registers_inst.write_register);
        $display(" $t0: %h (esperado: 00000010)", uut.registers_inst.data[8]);

        // Teste da instrução ADD
        // ADD $t1, $s1, $s2
        #10;
        instruction = 32'h2324820; // ADD $t1, $s1, $s2
        ALUScr = 0;
        RegDst = 1;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 0;
        ALUControl = 4'b0010;
        #30;
        $display("+------TESTE ADD------+");
        $display(" opcode: %b", instruction[31:26]);
        $display(" rs:     %b", instruction[25:21]);
        $display(" rt:     %b", instruction[20:16]);
        $display(" rd:     %b", instruction[15:11]);
        $display(" shamt:  %b", instruction[10:6]);
        $display(" funct:  %b", instruction[5:0]);
        $display(" write register: %h", uut.registers_inst.write_register);
        $display(" $t1: %h (esperado: 00000006)", uut.registers_inst.data[9]);

        // Teste da instrução SUB
        // SUB $t2, $s1, $s2
        #10;
        instruction = 32'h2325022; // SUB $t2, $s1, $s2
        ALUScr = 0;
        RegDst = 1;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 0;
        ALUControl = 4'b0110;
        #30;
        $display("+------TESTE SUB------+");
        $display(" opcode: %b", instruction[31:26]);
        $display(" rs:     %b", instruction[25:21]);
        $display(" rt:     %b", instruction[20:16]);
        $display(" rd:     %b", instruction[15:11]);
        $display(" shamt:  %b", instruction[10:6]);
        $display(" funct:  %b", instruction[5:0]);
        $display(" write register: %h", uut.registers_inst.write_register);
        $display(" $t2: %h (esperado: 00000002)", uut.registers_inst.data[10]);

        // Finaliza a simulação
        $finish;
    end

endmodule