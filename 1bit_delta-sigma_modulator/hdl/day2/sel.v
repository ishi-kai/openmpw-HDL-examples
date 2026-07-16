module sel(
input wire [1:0] button,
output wire led);

assign led = (button[0] == 1'b1)? 1'b0: button[1];

endmodule
