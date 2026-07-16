module lfsr(
input wire clk,
input wire sw,
input wire xrst,
output reg [3:0] q);

wire cntclk;

debouncer sw_clk(
.swi(sw),
.clk(clk),
.swo(cntclk));

always @(posedge cntclk)
begin
    if (!xrst)
    begin
        q <= 4'b1;
    end
    else
    begin
        q <= {q[2:0], q[3]^q[2]};
    end
end

endmodule
 