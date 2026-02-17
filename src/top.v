module top(
    input clk,
    input rst,
    input BTNC,
    input [7:0] SW,

    output LED0,  // class
    output LED1,  // done
    output LED2,  // Load X
    output LED3,  // Load Y
    output LED4   // Load K
);

/* -------- Button Edge Detection -------- */
reg btnc_d;

always @(posedge clk)
    btnc_d <= BTNC;

wire btnc_pulse = BTNC & ~btnc_d;

/* -------- Registers -------- */
reg [7:0] X_reg, Y_reg;
reg K_reg;

/* -------- Wires -------- */
wire load_x, load_y, load_k;
wire start_knn;
wire knn_done;
wire class_out;

/* -------- User FSM -------- */
user_fsm U_user (
    .clk(clk),
    .rst(rst),
    .btnc_pulse(btnc_pulse),
    .knn_done(knn_done),
    .load_x(load_x),
    .load_y(load_y),
    .load_k(load_k),
    .start_knn(start_knn),
    .led2(LED2),
    .led3(LED3),
    .led4(LED4)
);

/* -------- Register Input Data -------- */
always @(posedge clk or posedge rst) begin
    if (rst) begin
        X_reg <= 0;
        Y_reg <= 0;
        K_reg <= 0;
    end
    else begin
        if (load_x)
            X_reg <= SW;

        if (load_y)
            Y_reg <= SW;

        if (load_k)
            K_reg <= SW[0];
    end
end

/* -------- KNN Core -------- */
knn_core U_knn (
    .clk(clk),
    .rst(rst),
    .start(start_knn),
    .x_in(X_reg),
    .y_in(Y_reg),
    .k_in(K_reg),
    .class_out(class_out),
    .done(knn_done)
);

/* -------- LED Outputs -------- */
assign LED0 = class_out;
assign LED1 = knn_done;

endmodule