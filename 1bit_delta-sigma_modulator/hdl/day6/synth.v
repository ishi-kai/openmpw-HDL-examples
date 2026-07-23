module synth(
input wire clk,
input wire xrst,
input wire dsm_adc_in,
output wire dsm_adc_fb,
output wire pdm_out);

wire [15:0] omega;

dds_dac out_dac(
.clk(clk),
.xrst(xrst),
.omega({13'd0,omega[15:5]}),
.pdm_out(pdm_out));


ctrl_adc in_adc(
.clk(clk),
.xrst(xrst),
.dsm_in(dsm_adc_in),
.dsm_fb(dsm_adc_fb),
.code(omega));


endmodule
