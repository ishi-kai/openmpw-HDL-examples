module clock_div(
input wire f1,
input wire xrst,
output reg f2);

localparam MAX_COUNT = 25000000;
reg [25:0] counter;

always @(posedge f1)
begin
    if (!xrst)
    begin
        counter <= 26'b0;
    end
    else
    begin
        if (counter <= (MAX_COUNT - 1'b1))
        begin
            counter <= counter + 1'b1;
        end
        else
        begin
            counter <= 26'd0;
        end
    end
end

always @(posedge f1)
begin
    if (!xrst)
    begin
        f2 <= 1'b0;
    end
    else
    begin
        if (counter >= (MAX_COUNT >> 1))
        begin
            f2 <= 1'b1;
        end
        else
        begin
            f2 <= 1'b0;
        end
    end
end

endmodule
