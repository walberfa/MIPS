module program_counter_add(
    input logic [31:0] shift_left_in,
    input logic Branch,
    input logic Zero,
    output logic [31:0] pc
);

    logic [31:0] pc_plus_4;
    logic [31:0] shift_left_2;
    logic [31:0] add_result;
    logic [31:0] mux_output;

    assign pc_plus_4 = pc + 4;
    assign shift_left_2 = shift_left_in << 2;

    assign add_result = pc_plus_4 + shift_left_2;

    always_comb begin
        if (Branch && Zero) mux_output = add_result;
        else mux_output = pc_plus_4;

        pc = mux_output;
    end

endmodule