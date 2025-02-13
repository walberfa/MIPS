`timescale  1ns/10ps

module mux1(
    input logic mux1_control,
    input logic [4:0] inA, inB,
    output logic [4:0] mux1_output
);
    always_comb begin
        
        case (mux1_control)
            1'b0 : mux1_output = inA;
            1'b1 : mux1_output = inB;
        endcase
    end
endmodule