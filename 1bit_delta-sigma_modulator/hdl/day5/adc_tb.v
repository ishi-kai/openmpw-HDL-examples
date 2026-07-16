module adc_tb(
input wire clk,
input wire xrst,
input wire dsm_in,
output wire dsm_fb,
output wire [7:0] seg);

wire [9:0] data_out;
wire data_en;
reg [3:0] code;

dsm_adc uut(
.clk(clk),
.xrst(xrst),
.dsm_in(dsm_in),
.dsm_fb(dsm_fb),
.pdm_out(),
.data_en(data_en),
.data_out(data_out));

seg_disp code_to_seg(
.code(code),
.seg(seg));

always @(posedge clk or negedge xrst)
begin
    if (!xrst)
    begin
        code <= 4'd0;
    end
    else
    begin
        if (data_en == 1'b1)
            code <= data_out[9:6];
    end
end

endmodule

