module user_fsm(
    input clk,
    input rst,
    input load_btn,
    input start_btn,
    input knn_done,

    output reg load_x,
    output reg load_y,
    output reg load_k,
    output reg start_knn,

    output reg led2,
    output reg led3,
    output reg led4,
    output reg done_led
);

reg [2:0] state;

localparam LOAD_X = 3'd0,
           LOAD_Y = 3'd1,
           LOAD_K = 3'd2,
           READY  = 3'd3,
           RUN    = 3'd4,
           DONE   = 3'd5;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= LOAD_X;
    end
    else begin

        /* Default outputs */
        load_x    <= 0;
        load_y    <= 0;
        load_k    <= 0;
        start_knn <= 0;
        led2      <= 0;
        led3      <= 0;
        led4      <= 0;
        done_led  <= 0;

        case(state)

            LOAD_X: begin
                led2 <= 1;
                if(load_btn) begin
                    load_x <= 1;
                    state <= LOAD_Y;
                end
            end

            LOAD_Y: begin
                led3 <= 1;
                if(load_btn) begin
                    load_y <= 1;
                    state <= LOAD_K;
                end
            end

            LOAD_K: begin
                led4 <= 1;
                if(load_btn) begin
                    load_k <= 1;
                    state <= READY;
                end
            end

            READY: begin
                if(start_btn) begin
                    start_knn <= 1;
                    state <= RUN;
                end
            end

            RUN: begin
                if(knn_done)
                    state <= DONE;
            end

            DONE: begin
                done_led <= 1;
            end

        endcase
    end
end

endmodule