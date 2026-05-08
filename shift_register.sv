typedef enum logic [1:0] {
    NA    = 2'b00,
    LOAD  = 2'b01,
    LEFT  = 2'b10,
    RIGHT = 2'b11
} funct_t;

module shift_register #(
    parameter WIDTH = 4
) (
    input  logic clk,
    input  logic rst,
    input  funct_t funct_i,
    input  logic [WIDTH-1:0] word_i,
    input  logic serial_i,
    output logic [WIDTH-1:0] out_o
);

    logic [WIDTH-1:0] out_d;
    logic [WIDTH-1:0] out_q;

    assign out_o = out_q;

    always_comb begin
        out_d = out_q;

        case (funct_i)
            NA: begin
                out_d = out_q;
            end

            LOAD: begin
                out_d = word_i;
            end

            LEFT: begin
                out_d = {out_q[WIDTH-2:0], serial_i};
            end

            RIGHT: begin
                out_d = {serial_i, out_q[WIDTH-1:1]};
            end
            
            default: begin
                out_d = out_q;
            end
        endcase
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            out_q <= '0;
        end else begin
            out_q <= out_d;
        end
    end

endmodule
