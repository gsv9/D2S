module vote(
    input [2:0]k_in,                 // 0 = 3, 1 = 5
    input c1, c2, c3, c4, c5,
    output reg result
);

wire [1:0] sum3 = c1 + c2 + c3;
wire [2:0] sum5 = c1 + c2 + c3 + c4 + c5;

always @(*) begin
    if (k_in == 3'b011)
        result = (sum3 >= 2);
    else if (k_in == 3'b101)
        result = (sum5 >= 3);
    else 
    result=0;
end

endmodule