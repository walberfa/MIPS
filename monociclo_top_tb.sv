module tb_monociclo_top;

    // Sinais de entrada e saída
    logic clk;
    logic rst;
    logic [31:0] instruction;
    logic [31:0] ALUResult;
    logic Zero;

    // Instancia o módulo monociclo_top
    monociclo_top uut (
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa os sinais
        clk = 0;
        rst = 1;

        // Aplica reset
        #10;
        rst = 0;

        // Espera algumas instruções serem executadas
        #100;

        // Finaliza a simulação
        $finish;
    end

    initial begin
        $display("              Tempo   instruction    ALUResult   Zero");
        $monitor($time, " %b %b %b", instruction, ALUResult, Zero);
    end

endmodule