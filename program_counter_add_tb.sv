/*
Testbench para validar o módulo do contador de programa
Autor: Walber Florencio
CI Inovador - Polo UFC
*/

`timescale  1ns/10ps

module program_counter_tb();
    logic [31:0] shift_left_in;
    logic Branch;
    logic Zero;
    logic rst;
    logic clk;
    logic [31:0] pc;

    program_counter_add pc_dut(
        .shift_left_in(shift_left_in),
        .Branch(Branch),
        .Zero(Zero),
        .rst(rst),
        .clk(clk),
        .pc(pc)
    );

    // Gera o clock
    always #5 clk = ~clk;

    initial begin
        // Inicializa os sinais
        clk = 1;
        rst = 1;
        Branch = 0;
        Zero = 0;
        shift_left_in = 32'h10620001;
        #10;

        rst = 0;
        #50;

        Zero = 1;
        #20;

        Branch = 1;
        #30

        rst = 1;
        #10;

        $finish;
    end

    initial begin
        $display("                Time  ShifLeftIn Branch Zero PC(Saída)");
        $monitor($time, "   %h      %b      %b    %h", shift_left_in, Branch, Zero, pc);
    end

endmodule