`timescale 1ns/10ps

module main_control(
    input logic [5:0] op_code,
    output logic RegDst, ALUScr, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0
);

    always_comb

    begin  
        RegDst = 1'bx;
        ALUScr = 1'bx;
        MemtoReg = 1'bx;
        RegWrite = 1'bx;
        MemRead = 1'bx;
        MemWrite = 1'bx;
        Branch = 1'bx;
        ALUOp1 = 1'bx;
        ALUOp0 = 1'bx;

        case(op_code)
            6'b000000: begin // R-format
                RegDst = 1;
                ALUScr = 0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp1 = 1;
                ALUOp0 = 0;
            end
            6'b100011: begin // lw
                RegDst = 0;
                ALUScr = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                ALUOp1 = 0;
                ALUOp0 = 0;
            end
            6'b101011: begin // sw
                ALUScr = 1;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                Branch = 0;
                ALUOp1 = 0;
                ALUOp0 = 0;
            end
            6'b000100: begin // beq
                ALUScr = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp1 = 0;
                ALUOp0 = 1;
            end
        endcase
    end


endmodule