module complex2(
input wire button1,
input wire button2,
input wire button3,
output wire led);

wire a_or_b;

my_or two_or
(
    .button1(button1),
    .button2(button2),
    .led(a_or_b)
);

my_and two_and
(
    .button1(button3),
    .button2(a_or_b),
    .led(led)
);

endmodule
