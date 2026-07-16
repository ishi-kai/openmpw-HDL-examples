module seg_disp(
input wire [3:0] code,
output reg [7:0] seg);

always @(*)
begin
    case(code)
        4'h0: seg = 8'b11000000; // a,b,c,d,e,f 点灯
        4'h1: seg = 8'b11111001; // b,c 点灯
        4'h2: seg = 8'b10100100; // a,b,d,e,g 点灯
        4'h3: seg = 8'b10110000; // a,b,c,d,g 点灯 (手元のコードと一致)
        4'h4: seg = 8'b10011001; // b,c,f,g 点灯
        4'h5: seg = 8'b10010010; // a,c,d,f,g 点灯
        4'h6: seg = 8'b10000010; // a,c,d,e,f,g 点灯
        4'h7: seg = 8'b11111000; // a,b,c 点灯 (または 8'b11011000 で f も点灯)
        4'h8: seg = 8'b10000000; // すべて点灯 (dp以外)
        4'h9: seg = 8'b10010000; // a,b,c,d,f,g 点灯
        4'ha: seg = 8'b10001000; // 'A': a,b,c,e,f,g 点灯
        4'hb: seg = 8'b10000011; // 'b': c,d,e,f,g 点灯
        4'hc: seg = 8'b11000110; // 'C': a,d,e,f 点灯
        4'hd: seg = 8'b10100001; // 'd': b,c,d,e,g 点灯
        4'he: seg = 8'b10000110; // 'E': a,d,e,f,g 点灯
        4'hf: seg = 8'b10001110; // 'F': a,e,f,g 点灯
        default: seg = 8'b11111111; // 全消灯
    endcase
end

endmodule
