module dds_top(
input wire clk,
input wire xrst,
output pdm_out);

dds_dac dds(
.clk(clk),
.xrst(xrst),
.omega(24'd400),
.pdm_out(pdm_out));

endmodule

