module dsm_dac(
input wire clk,
input wire xrst,
input wire [9:0] data,
output reg dsm_out);

wire [11:0] delta_add;
wire [11:0] delta_fb;
reg [11:0] sigma;

assign delta_fb = {sigma[11], sigma[11], 10'd0};
assign delta_add = data + delta_fb;

always @(posedge clk or negedge xrst)
begin
    if (!xrst)
    begin
        sigma <= 12'd0;
    end
    else
    begin
        sigma <= sigma + delta_add;
    end
end

always @(posedge clk or negedge xrst)
begin
    if (!xrst)
        dsm_out <= 1'b0;
    else
        dsm_out <= sigma[11];
end

endmodule
