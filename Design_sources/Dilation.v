
module dilation (
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

    function [3:0] max9;
        input [3:0] a,b,c,d,e,f,g,h,i;
        reg [3:0] m;
        begin
            m=a;
            if(b>m)m=b;
            if(c>m)m=c;
            if(d>m)m=d;
            if(e>m)m=e;
            if(f>m)m=f;
            if(g>m)m=g;
            if(h>m)m=h;
            if(i>m)m=i;
            max9=m;
        end
    endfunction

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
                    pixel_out <= {
                        max9(p00[11:8],p01[11:8],p02[11:8],
                             p10[11:8],p11[11:8],p12[11:8],
                             p20[11:8],p21[11:8],p22[11:8]),
                        max9(p00[7:4],p01[7:4],p02[7:4],
                             p10[7:4],p11[7:4],p12[7:4],
                             p20[7:4],p21[7:4],p22[7:4]),
                        max9(p00[3:0],p01[3:0],p02[3:0],
                             p10[3:0],p11[3:0],p12[3:0],
                             p20[3:0],p21[3:0],p22[3:0])
                    };
            end
        end
    end

endmodule
