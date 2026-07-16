module cat(
input wire [1:0] button,
output wire [1:0] led);

assign led = {button[0], button[1]};

endmodule
