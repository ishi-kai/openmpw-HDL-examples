module dsm_adc(
input wire clk,
input wire xrst,
input wire dsm_in,
output reg dsm_fb,
output reg pdm_out,
output wire data_en,
output wire [15:0] data_out);

always @(posedge clk or negedge xrst)
begin
    if (!xrst)
    begin
        dsm_fb <= 1'b0;
        pdm_out <= 1'b0;
    end
    else
    begin
        dsm_fb <= ~dsm_in;
        pdm_out <= dsm_in;
    end
end

wire [15:0] dout;
assign data_out = dout;

cic_filter filt(
.clk(clk),
.xrst(xrst),
.dsm_signal(pdm_out),
.data_en(data_en),
.data(dout));

endmodule
