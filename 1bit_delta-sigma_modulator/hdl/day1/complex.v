module complex(
input wire a, 
input wire b,
input wire c,
output wire d);

wire a_or_b;
assign a_or_b = a | b;
assign d = a_or_b & c;

endmodule
