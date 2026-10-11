
module sobel_edge (
    input wire clk,
    input wire reset,
    input wire valid_in,
    input wire [9:0] x, y,
    input wire [11:0] pixel_in,
    input wire enable,

    output reg valid_out,
    output reg [9:0] x_out, y_out,
    output reg [11:0] pixel_out
);

    wire [11:0] p00,p01,p02,p10,p11,p12,p20,p21,p22;

    line_buffer_3x3 lb (
        .clk(clk), .reset(reset), .valid_in(valid_in),
        .x(x), .y(y), .pixel_in(pixel_in),
        .p00(p00), .p01(p01), .p02(p02),
        .p10(p10), .p11(p11), .p12(p12),
        .p20(p20), .p21(p21), .p22(p22)
    );

    function integer gray_value;
        input [11:0] p;
        begin
            gray_value = (p[11:8] + p[7:4] + p[3:0]) / 3;
        end
    endfunction

    integer gx, gy, ax, ay, magnitude;
    reg [3:0] edge_value;

    always @* begin
        gx = -gray_value(p00) + gray_value(p02)
             - 2*gray_value(p10) + 2*gray_value(p12)
             - gray_value(p20) + gray_value(p22);

        gy = gray_value(p00) + 2*gray_value(p01) + gray_value(p02)
             - gray_value(p20) - 2*gray_value(p21) - gray_value(p22);

        ax = (gx < 0) ? -gx : gx;
        ay = (gy < 0) ? -gy : gy;
        magnitude = ax + ay;

        if (magnitude > 15)
            edge_value = 4'd15;
        else
            edge_value = magnitude[3:0];
    end

    always @(posedge clk) begin
        if (reset) begin
            valid_out <= 0;
            x_out <= 0;
            y_out <= 0;
            pixel_out <= 0;
        end else begin
            valid_out <= valid_in;
            x_out <= x;
            y_out <= y;

            if (valid_in) begin
                if (!enable || x < 2 || y < 2)
                    pixel_out <= pixel_in;
                else
                    pixel_out <= {edge_value, edge_value, edge_value};
            end
        end
    end

endmodule
