/*
Testbench para validar o topo do processador monociclo
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

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

        #3
        // Inicializa a memória
        dut.data_memory_inst.memory[5] = 32'h0000000A; // Memória no endereço $5 = 10

        // Desliga o reset
        #2;
        rst = 0;
        
        // Inicializa os registradores
        dut.datapath_inst.registers_inst.data[17] = 32'h00000004; // $s1 = 4
        dut.datapath_inst.registers_inst.data[18] = 32'h00000002; // $s2 = 2
        
        // Espera as instruções serem executadas

        // Finaliza a simulação quando não houver mais instruções
        wait(instruction === 32'hx) $finish;
    end

    initial begin
        $display("              Tempo   instruction   write_data   operation   Zero");
        $monitor($time, "   %h      %h      %b      %b", instruction, write_data, operation, Zero);
    end


    /*
    Resultado esperado na saída do console:

    Tempo   instruction   write_data   operation   Zero
        0    8c080005      00000000      0010      0    // Initial PC = 0
        5    8c080005      0000000a      0010      0    // LW $t0, 0($5) -> $t0 = 10
        10   02324820      00000006      0010      0    // ADD $t1, $s1, $s2 -> $t1 = 4 + 2 = 6
        20   02325022      00000002      0110      0    // SUB $t2, $s1, $s2 -> $t2 = 4 - 2 = 2
        30   ac09000a      0000000a      0010      0    // SW $t1, 0($10) -> Memória no endereço 10 = 6
        40   02295820      0000000a      0010      0    // ADD $t3, $s1, $t1 -> $t3 = 4 + 6 = 10
        50   110b0004      00000000      0110      1    // BEQ $t0, $t3, 4 -> $t0 = 10, $t3 = 10, desvia 4 instruções
    */

endmodule