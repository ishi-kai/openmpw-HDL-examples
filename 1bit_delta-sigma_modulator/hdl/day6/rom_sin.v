module rom_sin
(
    input wire clk,
    input wire xrst,
    input wire [9:0] address,
    output reg [9:0] data
);

    reg [9:0] rom [0:255];
    initial
    begin
        $readmemb("./sin_table.txt", rom);
    end

    /* 
    * 10ビットアドレスから8ビットアドレスへの変換。
    * 上位2ビットで4領域を分ける。
    * 00 : 0から1/2π
    * 01 : 1/2πからπまで
    * 10 : πから3/2πまで
    * 11 : 3/2πから2πまで
    */
    reg [7:0] addr;
    always @(*)
    begin
        case(address[9:8]) // 上位2ビットで条件わけ
            2'b00: addr = address[7:0];
            2'b01: addr = ~address[7:0];
            2'b10: addr = address[7:0];
            2'b11: addr = ~address[7:0];
            default: addr = address[7:0];
        endcase
    end

    /* 
    * π以上の範囲では符号反転する。
    * 一応4領域に分けて書く。
    * 00 : 0から1/2π
    * 01 : 1/2πからπまで
    * 10 : πから3/2πまで
    * 11 : 3/2πから2πまで
    *
    * SRAMを推論させるために,
    * 一旦ROMからデータを取り出して計算。
    * (アドレス入れてからデータ出るまで2クロック遅延)
    *
    */
    reg [9:0] data2;
    reg [1:0] addr2;
    always @(posedge clk or negedge xrst)
    begin
        if (!xrst) data2 <= 10'b0;
        else
        begin 
            addr2 <= address[9:8];
            data2 <= rom[addr];
        end
    end
    
    always @(posedge clk or negedge xrst)
    begin
        if (!xrst) data <= 10'b0;
        else 
        begin
            case(addr2) // 上位2ビットで条件わけ
                2'b00: data <= data2;
                2'b01: data <= data2;
                2'b10: data <= ~data2+1;
                2'b11: data <= ~data2+1;
            endcase
        end
    end

endmodule


