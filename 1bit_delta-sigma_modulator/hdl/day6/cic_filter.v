module cic_filter(
    input wire clk,
    input wire xrst,
    input wire dsm_signal, // 1ビットΔΣ入力 (0: -1 に対応, 1: +1 に対応)
    output reg data_en,
    output reg [15:0] data // 16ビット符号なし出力
);

    /* 1. Input shaping (2-bit signed: +1 or -1) */
    // 2の補数表現で、2'sb01 は +1、2'sb11 は -1 を表します。
    wire signed [1:0] un_2b;
    assign un_2b = (dsm_signal == 1'b0) ? 2'sb11 : 2'sb01;

    // 内部レジスタ幅の26ビットに符号拡張
    wire signed [31:0] un;
    assign un = $signed(un_2b);

    /* 2. Integrator part (26-bit) */
    reg signed [31:0] acc1;
    reg signed [31:0] acc2;
    reg signed [31:0] acc3;

    always @(posedge clk or negedge xrst) begin
        if (!xrst) begin
            acc1 <= 31'sd0;
            acc2 <= 31'sd0;
            acc3 <= 31'sd0;
        end else begin
            acc1 <= acc1 + un;
            acc2 <= acc2 + acc1;
            acc3 <= acc3 + acc2;
        end
    end

    /* 3. Decimator part (Rate = 256) */
    reg [9:0] counter;
    reg dec_en;
    always @(posedge clk or negedge xrst) begin
        if (!xrst) begin
            counter <= 10'd0;
            dec_en  <= 1'b0;
        end else begin
            counter <= counter + 10'd1;
            if (counter == 10'd1023) begin
                dec_en <= 1'b1;
            end else begin
                dec_en <= 1'b0;
            end
        end
    end

    /* 4. Differentiator (Comb) part (26-bit) */
    reg signed [31:0] diff1_d;
    reg signed [31:0] diff2_d;
    reg signed [31:0] diff3_d;
    
    reg signed [31:0] diff1;
    reg signed [31:0] diff2;
    reg signed [31:0] diff3;

    always @(posedge clk or negedge xrst) begin
        if (!xrst) begin
            diff1_d <= 31'sd0;
            diff2_d <= 31'sd0;
            diff3_d <= 31'sd0;
            diff1   <= 31'sd0;
            diff2   <= 31'sd0;
            diff3   <= 31'sd0;
            data_en <= 1'b0;
            data    <= 16'd0;
        end else begin
            if (dec_en == 1'b1) begin
                // Comb段の差分演算
                diff1   <= acc3 - diff1_d;
                diff1_d <= acc3;

                diff2   <= diff1 - diff2_d;
                diff2_d <= diff1;

                diff3   <= diff2 - diff3_d;
                diff3_d <= diff2;

                // 5. 出力切り出し & 符号なし変換
                // 入力が ±1 のとき、CICの最大出力振幅は ±2^24 ≒ ±16,777,216 となります。
                // 26ビット幅の中でデータが動くため、diff3[25]が符号（MSB）になります。
                // 符号なし16ビットとして出力するため、[25:10]の16ビットを切り出し、MSBを反転します。
                data    <= { ~diff3[31], diff3[30:16] };
                data_en <= 1'b1;
            end else begin
                data_en <= 1'b0;
            end
        end
    end

endmodule