`timescale 1ns/1ps

module top_tb;

reg clk;
reg rst;
reg start;
reg [7:0] x_in;
reg [7:0] y_in;
reg [2:0]k_in;

wire class_out;
wire done;

/* Instantiate DUT */
knn_core DUT (
    .clk(clk),
    .rst(rst),
    .start(start),
    .x_in(x_in),
    .y_in(y_in),
    .k_in(k_in),
    .class_out(class_out),
    .done(done)
);

/* Clock Generation */
initial begin
    clk = 0;
    forever #5 clk = ~clk;   // 100 MHz clock
end

/* Test Sequence */
initial begin

    // Initial reset
    rst = 1;
    start = 0;
    x_in = 0;
    y_in = 0;
    k_in = 0;

    #20;
    rst = 0;

    /* ---------- TEST 1 : K=3 ---------- */
    x_in = 8'd12;
    y_in = 8'd22;
    k_in =3'b011;      // K = 3

    #10;
    start = 1;
    #10;
    start = 0;

    wait(done);

    #20;

    /* ---------- TEST 2 : K=5 ---------- */
    /* ---------- reset for test 2 ---------- */
    rst=1;
    #10;
    rst=0;
    #10;
    x_in = 8'd60;
    y_in = 8'd70;
    k_in = 3'b101;      // K = 5

    #10;
    start = 1;
    #10;
    start = 0;

    wait(done);

    #50;
    $stop;
end

endmodule