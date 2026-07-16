module pwm_top(
input wire clk,
input wire xrst,
output wire led);


pwm_led lll(
.clk(clk),
.xrst(xrst),
.width(width),
.pwm(led));

reg [15:0] counter;
reg [9:0] width;


always @(posedge clk or negedge xrst)
begin
    if (!xrst)
    begin
        counter <= 16'd0;
    end
    else
    begin
        if (counter < 16'd50000) counter <= counter + 16'd1;
        else counter <= 16'd0;
    end
end

always @(posedge clk or negedge xrst)
begin
    if (!xrst)
        width <= 10'd0;
    else
        if (counter == 16'd25000) width <= width + 10'd4;
end
endmodule
