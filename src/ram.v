module ram(
    input clk,
    input [3:0] addr,
    output reg [7:0] xi,
    output reg [7:0] yi,
    output reg class_i
);

reg [16:0] memory [0:15];

initial begin
    memory[0]  = {8'd10, 8'd20, 1'b0};
    memory[1]  = {8'd15, 8'd25, 1'b1};
    memory[2]  = {8'd30, 8'd35, 1'b0};
    memory[3]  = {8'd40, 8'd10, 1'b1};
    memory[4]  = {8'd5,  8'd8,  1'b0};
    memory[5]  = {8'd12, 8'd18, 1'b1};
    memory[6]  = {8'd22, 8'd14, 1'b0};
    memory[7]  = {8'd17, 8'd9,  1'b1};
    memory[8]  = {8'd50, 8'd60, 1'b0};
    memory[9]  = {8'd55, 8'd65, 1'b1};
    memory[10] = {8'd70, 8'd75, 1'b0};
    memory[11] = {8'd80, 8'd85, 1'b1};
    memory[12] = {8'd90, 8'd95, 1'b0};
    memory[13] = {8'd33, 8'd44, 1'b1};
    memory[14] = {8'd66, 8'd77, 1'b0};
    memory[15] = {8'd99, 8'd11, 1'b1};
end

always @(posedge clk)
    {xi, yi, class_i} <= memory[addr];

endmodule