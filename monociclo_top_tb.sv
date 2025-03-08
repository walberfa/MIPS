module tb_monociclo_top;

    // Sinais de entrada e saída
    logic clk;
    logic rst;
    logic [31:0] instruction;
    logic [31:0] write_data;
    logic [3:0] operation;
    logic Zero;

    // Instancia o módulo monociclo_top
    monociclo_top dut (
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .write_data(write_data),
        .operation(operation),
        .Zero(Zero)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa os sinais
        clk = 1;
        rst = 1;

        // Desliga o reset
        #10;
        rst = 0;

        // Inicializa os registradores
        dut.datapath_inst.registers_inst.data[17] = 32'h00000004; // $s1 = 4
        dut.datapath_inst.registers_inst.data[18] = 32'h00000002; // $s2 = 2

        // Inicializa a memória
        dut.data_memory_inst.memory[5] = 32'h0000000A; // Memória no endereço $5 = 10
        
        // Espera algumas instruções serem executadas
        #50;

        // Finaliza a simulação
        $finish;
    end

    initial begin
        $display("              Tempo   instruction   write_data   operation   Zero");
        $monitor($time, "   %h      %h      %b      %b", instruction, write_data, operation, Zero);
    end

endmodule