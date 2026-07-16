module sel_switch(
input wire [1:0] button,
output reg [1:0] led);

always @(*)
begin
    case(button)
        2'b00: led = 2'b00;
        2'b10: led = 2'b10;
        2'b01: led = 2'b01;
        2'b11: led = 2'b11;
        default: led = 2'b11;
    endcase
end

endmodule