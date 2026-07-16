module debouncer(
input wire swi,
input wire clk,
output reg swo);

localparam COUNT_MAX = 18'd250_000;
reg [17:0] counter;

reg bounce;


always @(posedge clk)
begin
    if (counter <= COUNT_MAX)
        counter <= counter +18'd1;
    else
        counter <= 18'd0;
end

wire sw_flag;
assign sw_flag = (counter == COUNT_MAX)? 1'b1 : 1'b0;

always @(posedge clk)
begin
    if (sw_flag == 1'b1)
    begin
        bounce <= swi;
        swo <= bounce;
    end
end

endmodule
