module ucsbece152a_counter_tb();

    parameter WIDTH = 3;

    logic clk = 0;
    always #(10) clk = ~clk;

    logic rst;
    logic enable_i;
    logic dir_i;
    logic [WIDTH-1:0] count;

    ucsbece152a_counter #(
        .WIDTH(WIDTH)
    ) DUT (
        .clk(clk),
        .rst(rst),
        .count_o(count),
        .enable_i(enable_i),
        .dir_i(dir_i)
    );

    integer i;

    initial begin
        $display("Begin simulation.");
        rst = 1'b1;
        enable_i = 1'b1;
        dir_i = 1'b0;

        @(negedge clk);
        rst = 1'b0;
        for (i = 0; i < 16; i++) begin
            if (count != i % (2 ** WIDTH)) begin
                $display(
                    "Count up error: expected %d, received %d",
                    i % (2 ** WIDTH),
                    count
                );
            end
            @(negedge clk);
        end

        enable_i = 1'b0;
        @(negedge clk);
        if (count != 3'b000) begin
            $display("Enable error: expected counter to pause at 0, received %d", count);
        end

        @(negedge clk);
        if (count != 3'b000) begin
            $display("Enable error: expected counter to stay paused at 0, received %d", count);
        end

        enable_i = 1'b1;
        dir_i = 1'b1;

        @(negedge clk);
        if (count != 3'b111) begin
            $display("Count down error: expected 7, received %d", count);
        end

        @(negedge clk);
        if (count != 3'b110) begin
            $display("Count down error: expected 6, received %d", count);
        end

        @(negedge clk);
        if (count != 3'b101) begin
            $display("Count down error: expected 5, received %d", count);
        end

        rst = 1'b1;
        enable_i = 1'b0;
        dir_i = 1'b1;

        @(negedge clk);
        if (count != '0) begin
            $display("Reset error: expected 0, received %d", count);
        end

        rst = 1'b0;

        $display("End simulation.");
        $stop;
    end

endmodule