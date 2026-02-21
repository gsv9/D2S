module kclass(
input clk,
input rst,
input init,          // NEW
input update,
input [8:0] dist,
input c_in,
output reg c1,
output reg c2,
output reg c3,
output reg c4,
output reg c5
);

reg [8:0] min1,min2,min3,min4,min5;

wire cmp1,cmp2,cmp3,cmp4,cmp5;
wire ins1,ins2,ins3,ins4,ins5;

/* ---- Comparators ---- */
assign cmp1 = (dist < min1);
assign cmp2 = (dist < min2);
assign cmp3 = (dist < min3);
assign cmp4 = (dist < min4);
assign cmp5 = (dist < min5);

/* ---- Insert Position Logic ---- */
assign ins1 = cmp1;
assign ins2 = ~cmp1 & cmp2;
assign ins3 = ~cmp1 & ~cmp2 & cmp3;
assign ins4 = ~cmp1 & ~cmp2 & ~cmp3 & cmp4;
assign ins5 = ~cmp1 & ~cmp2 & ~cmp3 & ~cmp4 & cmp5;

/* ---- Sequential Update ---- */
always @(posedge clk or posedge rst) begin
    if (rst) begin
        min1<=9'd511;
        min2<=9'd511;
        min3<=9'd511;
        min4<=9'd511;
        min5<=9'd511;
        c1<=0; c2<=0; c3<=0; c4<=0; c5<=0;
    end

    else if (init) begin        // NEW RESET PER CLASSIFICATION
        min1<=9'd511;
        min2<=9'd511;
        min3<=9'd511;
        min4<=9'd511;
        min5<=9'd511;
        c1<=0; c2<=0; c3<=0; c4<=0; c5<=0;
    end

    else if (update) begin

        if(ins1) begin
            min5<=min4; c5<=c4;
            min4<=min3; c4<=c3;
            min3<=min2; c3<=c2;
            min2<=min1; c2<=c1;
            min1<=dist; c1<=c_in;
        end
        else if(ins2) begin
            min5<=min4; c5<=c4;
            min4<=min3; c4<=c3;
            min3<=min2; c3<=c2;
            min2<=dist; c2<=c_in;
        end
        else if(ins3) begin
            min5<=min4; c5<=c4;
            min4<=min3; c4<=c3;
            min3<=dist; c3<=c_in;
        end
        else if(ins4) begin
            min5<=min4; c5<=c4;
            min4<=dist; c4<=c_in;
        end
        else if(ins5) begin
            min5<=dist; 
            c5<=c_in;
        end
    end
end

endmodule