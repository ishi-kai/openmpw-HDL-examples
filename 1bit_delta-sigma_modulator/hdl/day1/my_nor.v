module my_nor(
input wire button1,
input wire button2,
output wire led);

assign led = ~(button1 | button2);

endmodule
