`timescale  1 ns/10ps

module sign_ext_tb();
logic [15:0] in16;
logic [31:0] out32;

SignExtend sign_ext_inst(.in16(in16), .out32(out32));

initial begin
    in16 = 16'b0100001100110011;
    #10;
    in16 = 16'b1111001100110011;
    #10;
end

initial begin
    $display("              Tempo       Saída");
    $monitor($time, "   %b", out32);
end

endmodule