module ucsbece152a_counter #(
    parameter WIDTH = 3
) (
    input  logic clk,
    input  logic rst,
    output logic [WIDTH-1:0] count_o,
   
    input  logic enable_i, //part 2
    input  logic dir_i //part 2
);

    logic [WIDTH-1:0] count_d;
    logic [WIDTH-1:0] count_q;

    assign count_o = count_q;

    always_comb begin
        count_d = count_q + 1'b1;
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count_q <= '0;
        end else begin
            count_q <= count_d;
        end
    end

endmodule
