
module line_buffer_3x3 (
    input wire clk,
    input wire reset,
    input wire valid_in,
    input wire [9:0] x,
    input wire [9:0] y,
    input wire [11:0] pixel_in,

    output wire [11:0] p00, p01, p02,
    output wire [11:0] p10, p11, p12,
    output wire [11:0] p20, p21, p22
);

    reg [11:0] row0 [0:479];
    reg [11:0] row1 [0:479];

    reg [11:0] t0, t1;
    reg [11:0] m0, m1;
    reg [11:0] b0, b1;

    wire [11:0] old0 = row0[x];
    wire [11:0] old1 = row1[x];

    assign p00 = t0;
    assign p01 = t1;
    assign p02 = old1;

    assign p10 = m0;
    assign p11 = m1;
    assign p12 = old0;

    assign p20 = b0;
    assign p21 = b1;
    assign p22 = pixel_in;

    always @(posedge clk) begin
        if (reset) begin
            t0 <= 0; t1 <= 0;
            m0 <= 0; m1 <= 0;
            b0 <= 0; b1 <= 0;
        end else if (valid_in && x < 480) begin
            row1[x] <= old0;
            row0[x] <= pixel_in;

            if (x == 0) begin
                t0 <= 0; t1 <= old1;
                m0 <= 0; m1 <= old0;
                b0 <= 0; b1 <= pixel_in;
            end else begin
                t0 <= t1; t1 <= old1;
                m0 <= m1; m1 <= old0;
                b0 <= b1; b1 <= pixel_in;
            end
        end
    end

endmodule
