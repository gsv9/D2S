module oled_simple(
    input clk,
    input rst,
    input [1:0] disp_state,
    input class_out,
    input done,

    output reg OLED_DC,
    output reg OLED_RES,
    output reg OLED_SCLK,
    output reg OLED_SDIN
);

/* ================= CLOCK DIVIDER ================= */
/* 100MHz -> ~1MHz SPI */
reg [6:0] clk_div;
wire spi_clk;

always @(posedge clk)
    clk_div <= clk_div + 1;

assign spi_clk = clk_div[6];

/* ================= STATE MACHINE ================= */

reg [4:0] state;
reg [7:0] data;
reg [3:0] bit_cnt;
reg [7:0] char_index;

/* States */
localparam RESET0  = 0,
           RESET1  = 1,
           INIT0   = 2,
           INIT1   = 3,
           IDLE    = 4,
           LOAD    = 5,
           SEND    = 6,
           NEXT    = 7;

always @(posedge spi_clk or posedge rst) begin
    if (rst) begin
        state <= RESET0;
        OLED_RES <= 0;
        OLED_SCLK <= 0;
        OLED_SDIN <= 0;
        OLED_DC <= 0;
        bit_cnt <= 0;
        char_index <= 0;
    end else begin
        case (state)

        RESET0: begin
            OLED_RES <= 0;
            state <= RESET1;
        end

        RESET1: begin
            OLED_RES <= 1;
            state <= INIT0;
        end

        /* Minimal Init Command */
        INIT0: begin
            OLED_DC <= 0;      // command
            data <= 8'hAE;     // Display OFF
            bit_cnt <= 0;
            state <= SEND;
        end

        INIT1: begin
            state <= IDLE;
        end

        IDLE: begin
            if (done)
                state <= LOAD;
        end

        LOAD: begin
            OLED_DC <= 1;  // data mode

            case (disp_state)
                2'b00: data <= "X";
                2'b01: data <= "Y";
                2'b10: data <= "K";
                2'b11: begin
                    if (class_out)
                        data <= "1";
                    else
                        data <= "0";
                end
            endcase

            bit_cnt <= 0;
            state <= SEND;
        end

        SEND: begin
            OLED_SCLK <= 0;
            OLED_SDIN <= data[7-bit_cnt];
            OLED_SCLK <= 1;

            if (bit_cnt == 7)
                state <= NEXT;
            else
                bit_cnt <= bit_cnt + 1;
        end

        NEXT: begin
            state <= IDLE;
        end

        default: state <= IDLE;

        endcase
    end
end

endmodule