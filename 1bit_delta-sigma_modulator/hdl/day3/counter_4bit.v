module counter_4bit(
input wire clk,
input wire xrst,
output reg [3:0] q);

always @(posedge clk)
begin
    if (!xrst)
    begin
        q <= 4'b0;
    end
    else
    begin
        q <= q + 4'b1;
    end
end

endmodule
