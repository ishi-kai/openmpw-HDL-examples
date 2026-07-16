module counter_4bit_debounce(
input wire clk,
input wire sw,
input wire xrst,
output wire [3:0] q);

wire cntclk;

debouncer sw_clk(
.swi(sw),
.clk(clk),
.swo(cntclk));

counter_4bit counter(
.clk(cntclk),
.xrst(xrst),
.q(q));

endmodule
