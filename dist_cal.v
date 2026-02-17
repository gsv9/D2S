module dist_cal(
    input  [7:0] x,
    input  [7:0] y,
    input  [7:0] xi,
    input  [7:0] yi,
    output reg [8:0] dist
);

reg [8:0] abs_x;
reg [8:0] abs_y;

always @(*) begin
    abs_x = (x >= xi) ? (x - xi) : (xi - x);
    abs_y = (y >= yi) ? (y - yi) : (yi - y);
    dist  = abs_x + abs_y;
end

endmodule