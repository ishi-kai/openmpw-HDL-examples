module dac_tb(
input wire clk,
input wire xrst,
output wire pdm_out);

dsm_dac uut(
.clk(clk),
.xrst(xrst),
.data(data),
.dsm_out(pdm_out));

reg [9:0] data;
reg [9:0] counter;
always @(posedge clk or negedge xrst)
begin
    if (!xrst)
    begin
        counter <= 10'd0;
        data <= 10'd0;
    end
    else
    begin
        counter <= counter + 10'd1;
        if (counter == 10'd1023) data <= data + 10'd1;
    end
end

endmodule
