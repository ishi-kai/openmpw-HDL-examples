module pwm_led(
input wire clk,
input wire xrst,
input wire [9:0] width,
output reg pwm);

reg [9:0] counter;

always @(posedge clk or negedge xrst)
begin
    if (!xrst) counter <= 10'd0;
    else
    begin
        counter <= counter + 10'd1;
    end
end

always @(posedge clk or negedge xrst)
begin
    if (!xrst) pwm <= 1'b0;
    else
    begin
        if (width <= counter) pwm <= 1'b1;
        else pwm <= 1'b0;
    end
end

endmodule
