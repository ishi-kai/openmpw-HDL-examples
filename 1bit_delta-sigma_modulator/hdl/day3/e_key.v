module e_key(
input wire clk,
input wire [2:0] b,
input wire xrst,
output reg [3:0] led);

localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;
localparam S3 = 2'b11;

wire [2:0] b_debounce;
wire [2:0] b_edge;
reg [2:0] b_prev;

debouncer b0
(
.swi(b[0]),
.clk(clk),
.swo(b_debounce[0])
);

debouncer b1
(
.swi(b[1]),
.clk(clk),
.swo(b_debounce[1])
);

debouncer b2
(
.swi(b[2]),
.clk(clk),
.swo(b_debounce[2])
);

always @(posedge clk)
begin
    b_prev <= b_debounce;
end

assign b_edge = b_prev & (~b_debounce);

reg [1:0] next_state, current_state;

always @(posedge clk)
begin
    if (!xrst) current_state <= S0;
    else current_state <= next_state;
end

always @(*)
begin
    if (!xrst)
    begin
        next_state = S0;
    end
    else
    begin
        case(current_state)
            S0:begin
                if (b_edge == 3'b000) next_state = S0;
                else if (b_edge == 3'b100) next_state = S1;
                else next_state = S0;
            end
            S1:begin
                if (b_edge == 3'b000) next_state = S1;
                else if (b_edge == 3'b010) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (b_edge == 3'b000) next_state = S2;
                else if (b_edge == 3'b001) next_state = S3;
                else next_state = S0;
            end
            S3: begin
                if (!xrst) next_state = S0;
                else next_state = S3;
            end
            default: next_state = S0;
        endcase
    end
end

always @(posedge clk)
begin
    if (!xrst) led <= 4'b1111;
    else
    begin
        case(current_state)
            S0: led <= 4'b1111;
            S1: led <= 4'b0111;
            S2: led <= 4'b0011;
            S3: led <= 4'b0110;
            default: led <= 4'b1111;
        endcase
    end
end

endmodule
