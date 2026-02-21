module fsm(
    input clk,
    input rst,
    input start,
    input [3:0] addr,

    output reg init,
    output reg update,
    output reg addr_enable,
    output reg vote_enable,
    output reg done
);

reg [2:0] state, next_state;

localparam IDLE      = 3'd0,
           INIT      = 3'd1,
           READ_ADDR = 3'd2,
           READ_PROC = 3'd3,
           VOTE      = 3'd4,
           DONE      = 3'd5;

/* State Register */
always @(posedge clk or posedge rst) begin
    if (rst)
        state <= IDLE;
    else
        state <= next_state;
end

/* Next State Logic */
always @(*) begin
    case(state)
        IDLE:      next_state = start ? INIT : IDLE;
        INIT:      next_state = READ_ADDR;
        READ_ADDR: next_state = READ_PROC;
        READ_PROC: next_state = (addr == 4'd15) ? VOTE : READ_ADDR;
        VOTE:      next_state = DONE;
        DONE:      next_state = start ? DONE : IDLE;
        default:   next_state = IDLE;
    endcase
end

/* Output Logic */
always @(*) begin
    init        = 0;
    update      = 0;
    addr_enable = 0;
    vote_enable = 0;
    done        = 0;

    case(state)
        INIT:      init = 1;
        READ_ADDR: addr_enable = 1;
        READ_PROC: update = 1;
        VOTE:      vote_enable = 1;
        DONE:      done = 1;
    endcase
end

endmodule