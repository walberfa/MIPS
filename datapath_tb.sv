/*
Testbench para validar o caminho de dados
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

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
    logic [31:0] w_scrB;
    logic Zero;

    // Instancia o módulo datapath
    datapath datapath1 (
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .write_data(write_data),
        .ALUScr(ALUScr),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .out32(out32),
        .w_scrB(w_scrB),
        .Zero(Zero)
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
        datapath1.registers_inst.data[17] = 32'h00000004; // $s1 = 4
        datapath1.registers_inst.data[18] = 32'h00000002; // $s2 = 2

        // Simula a inicialização da memória
        write_data = 32'h0000000A; // Memória no endereço $5 = 10

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
        $display("+----LW $t0, 0($5)---+");
        $display(" opcode: %b", instruction[31:26]);
        $display(" rs:     %b", instruction[25:21]);
        $display(" rt:     %b", instruction[20:16]);
        $display(" offset: %b", instruction[15:0]);
        $display(" write register: %h", datapath1.registers_inst.write_register);
        $display(" $t0: %h (esperado: 0000000A)", datapath1.registers_inst.data[8]);

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
        write_data = 32'h00000006;
        #30;
        $display("+------TESTE ADD------+");
        $display("+--ADD $t1, $s1, $s2--+");
        $display(" opcode: %b", instruction[31:26]);
        $display(" rs:     %b", instruction[25:21]);
        $display(" rt:     %b", instruction[20:16]);
        $display(" rd:     %b", instruction[15:11]);
        $display(" shamt:  %b", instruction[10:6]);
        $display(" funct:  %b", instruction[5:0]);
        $display(" write register: %h", datapath1.registers_inst.write_register);
        $display(" ALU Result: %h", ALUResult);
        $display(" Zero: %b (esperado: 0)", Zero);
        $display(" $t1: %h (esperado: 00000006)", datapath1.registers_inst.data[9]);

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
        write_data = 32'h00000002;
        #30;
        $display("+------TESTE SUB------+");
        $display("+--SUB $t2, $s1, $s2--+");
        $display(" opcode: %b", instruction[31:26]);
        $display(" rs:     %b", instruction[25:21]);
        $display(" rt:     %b", instruction[20:16]);
        $display(" rd:     %b", instruction[15:11]);
        $display(" shamt:  %b", instruction[10:6]);
        $display(" funct:  %b", instruction[5:0]);
        $display(" write register: %h", datapath1.registers_inst.write_register);
        $display(" ALU Result: %h", ALUResult);
        $display(" Zero: %b (esperado: 0)", Zero);
        $display(" $t2: %h (esperado: 00000002)", datapath1.registers_inst.data[10]);

        // Teste da instrução SW
        // SW $t1, 0($10)
        #10;
        instruction = 32'hAC09000A; // SW $t1, 0($10)
        ALUScr = 1;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 1;
        ALUControl = 4'b0010;
        write_data = 32'h00000006;
        #30;
        $display("+------TESTE SW------+");
        $display("+---SW $t1, 0($10)---+");
        $display(" opcode: %b", instruction[31:26]);
        $display(" rs:     %b", instruction[25:21]);
        $display(" rt:     %b", instruction[20:16]);
        $display(" offset: %b", instruction[15:0]);
        $display(" write data: %h", write_data);
        $display(" Mem[address]: %2d (esperado: 10)", ALUResult);
        $display(" Mem[10]: %h (esperado: 00000006)", w_scrB);

        // Teste da instrução ADD
        // ADD $t3, $s1, $t1
        #10;
        instruction = 32'h02295820; // ADD $t3, $s1, $t1
        ALUScr = 0;
        RegDst = 1;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 0;
        ALUControl = 4'b0010;
        write_data = 32'h0000000A;
        #30;
        $display("+------TESTE ADD------+");
        $display("+--ADD $t3, $s1, $t1--+");
        $display(" opcode: %b", instruction[31:26]);
        $display(" rs:     %b", instruction[25:21]);
        $display(" rt:     %b", instruction[20:16]);
        $display(" rd:     %b", instruction[15:11]);
        $display(" shamt:  %b", instruction[10:6]);
        $display(" funct:  %b", instruction[5:0]);
        $display(" write register: %h", datapath1.registers_inst.write_register);
        $display(" ALU Result: %h", ALUResult);
        $display(" Zero: %b (esperado: 0)", Zero);
        $display(" $t3: %h (esperado: 0000000A)", datapath1.registers_inst.data[11]);

        // Teste da instrução BEQ
        // BEQ $t0, $t3, 4
        #10;
        instruction = 32'h110B0004; // BEQ $t0, $t3, 4
        ALUScr = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        ALUControl = 4'b0110;
        #30;
        $display("+------TESTE BEQ------+");
        $display("+---BEQ $t0, $t3, 4---+");
        $display(" opcode: %b", instruction[31:26]);
        $display(" rs:     %b", instruction[25:21]);
        $display(" rt:     %b", instruction[20:16]);
        $display(" offset: %b", instruction[15:0]);
        $display(" ALU Result: %h", ALUResult);
        $display(" Zero: %b (esperado: 1)", Zero);

        // Finaliza a simulação
        $finish;
    end

endmodule