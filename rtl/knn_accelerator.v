module knn_accelerator (
    input clk,
    input rst,
    input start,

    input [7:0] x_in,
    input [7:0] y_in,
    input [2:0] k_in,

    output class_out,
    output done
);

knn_core U_knn (
    .clk(clk),
    .rst(rst),
    .start(start),
    .x_in(x_in),
    .y_in(y_in),
    .k_in(k_in),
    .class_out(class_out),
    .done(done)
);

endmodule
