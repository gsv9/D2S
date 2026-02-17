module knn_core(
    input clk,
    input rst,
    input start,

    input [7:0] x_in,
    input [7:0] y_in,
    input [2:0]k_in,

    output class_out,
    output done
);

/* -------- Input Latching -------- */
reg [7:0] x_reg, y_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        x_reg <= 0;
        y_reg <= 0;
    end
    else if (start) begin
        x_reg <= x_in;
        y_reg <= y_in;
    end
end

/* -------- Internal Wires -------- */
wire [3:0] addr;
wire init;
wire update;
wire addr_enable;
wire vote_enable;

wire [7:0] xi, yi;
wire class_i;

wire [8:0] dist;

wire c1, c2, c3, c4, c5;
wire vote_result;

/* -------- Address Counter -------- */
addr_counter U1 (
    .clk(clk),
    .rst(rst),
    .init(init),          // NEW
    .addr_enable(addr_enable),
    .addr(addr)
);

/* -------- Training RAM -------- */
ram U2 (
    .clk(clk),
    .addr(addr),
    .xi(xi),
    .yi(yi),
    .class_i(class_i)
);

/* -------- Distance Engine -------- */
dist_cal U3 (
    .x(x_reg),            // FIXED
    .y(y_reg),            // FIXED
    .xi(xi),
    .yi(yi),
    .dist(dist)
);

/* -------- K Selector -------- */
kclass U4 (
    .clk(clk),
    .rst(rst),
    .init(init),          // NEW
    .update(update),
    .dist(dist),
    .c_in(class_i),
    .c1(c1),
    .c2(c2),
    .c3(c3),
    .c4(c4),
    .c5(c5)
);

/* -------- Voting Unit -------- */
vote U5 (
    .k_in(k_in),
    .c1(c1),
    .c2(c2),
    .c3(c3),
    .c4(c4),
    .c5(c5),
    .result(vote_result)
);

/* -------- Control FSM -------- */
fsm U6 (
    .clk(clk),
    .rst(rst),
    .start(start),
    .addr(addr),
    .init(init),          // NEW
    .update(update),
    .addr_enable(addr_enable),
    .vote_enable(vote_enable),
    .done(done)
);

/* -------- Output Register -------- */
reg result_reg;

always @(posedge clk or posedge rst) begin
    if (rst)
        result_reg <= 0;
    else if (vote_enable)
        result_reg <= vote_result;
end

assign class_out = result_reg;

endmodule
