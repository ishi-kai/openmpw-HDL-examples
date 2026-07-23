module dds_dac(
input wire clk,
input wire xrst,
input wire [23:0] omega,
output wire pdm_out);

wire signed [9:0] wave_data;
wire [9:0] u_wave_data;

dsm_dac uut(
.clk(clk),
.xrst(xrst),
.data(u_wave_data),
.dsm_out(pdm_out));

rom_sin sin(
.clk(clk),
.xrst(xrst),
.address(address[23:14]),
.data(wave_data)
);

assign u_wave_data = wave_data ^ 10'h200; 
reg [23:0] address;
always @(posedge clk or negedge xrst)
begin
    if (!xrst)
    begin
        address <= 24'd0;
    end
    else
    begin
        address <= address + omega;
    end
end

endmodule