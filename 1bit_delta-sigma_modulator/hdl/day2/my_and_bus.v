module my_and_bus(
input wire [1:0] button,
output wire led);

assign led = &button;

endmodule
