module ctrl_adc(
input wire clk,
input wire xrst,
input wire dsm_in,
output wire dsm_fb,
output reg [9:0] code);

wire [9:0] data_out;
wire data_en;

dsm_adc uut(
.clk(clk),
.xrst(xrst),
.dsm_in(dsm_in),
.dsm_fb(dsm_fb),
.pdm_out(),
.data_en(data_en),
.data_out(data_out));

always @(posedge clk or negedge xrst)
begin
    if (!xrst)
    begin
        code <= 10'd0;
    end
    else
    begin
        if (data_en == 1'b1)
            code <= data_out;
    end
end

endmodule
