module addr_counter(
    input clk,
    input rst,
    input init,            // reset per classification
    input addr_enable,
    output reg [3:0] addr
);

always @(posedge clk or posedge rst) begin
    if (rst)
        addr <= 4'd0;
    else if (init)
        addr <= 4'd0;
    else if (addr_enable)
        addr <= addr + 1'b1;
end

endmodule