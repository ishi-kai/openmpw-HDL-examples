module sel_if(
input wire [1:0] button,
output reg [1:0] led);

always @(*)
begin
    if (button == 2'b11) led = 2'b11;
    else if (button == 2'b10) led = 2'b10;
    else if (button == 2'b01) led = 2'b01;
    else led = 2'b00;
end

endmodule