
module image_processor (
    input  wire [11:0] pixel_in,
    input  wire [9:0]  sw,
    input  wire        processing_enable,
    output wire [11:0] pixel_out
);

    wire [11:0] s0, s1, s2, s3, s4, s5, s6;

    function [3:0] gray;
        input [11:0] p;
        reg [5:0] sum;
        begin
            sum = {2'b0,p[11:8]} +
                  {2'b0,p[7:4]} +
                  {2'b0,p[3:0]};
            gray = sum / 3;
        end
    endfunction

    function [3:0] bright;
        input [3:0] v;
        begin
            bright = (v >= 13) ? 15 : v + 2;
        end
    endfunction

    function [3:0] contrast;
        input [3:0] v;
        begin
            if (v < 4)
                contrast = 0;
            else if (v > 11)
                contrast = 15;
            else
                contrast = v;
        end
    endfunction

    // SW0: Negative
    assign s0 = (processing_enable && sw[0])
              ? ~pixel_in : pixel_in;

    // SW1: Grayscale
    assign s1 = (processing_enable && sw[1])
              ? {gray(s0), gray(s0), gray(s0)} : s0;

    // SW2: Threshold
    assign s2 = (processing_enable && sw[2])
              ? ((gray(s1) >= 8) ? 12'hFFF : 12'h000) : s1;

    // SW3: Brightness
    assign s3 = (processing_enable && sw[3])
              ? {bright(s2[11:8]), bright(s2[7:4]),
                 bright(s2[3:0])} : s2;

    // SW4: Contrast
    assign s4 = (processing_enable && sw[4])
              ? {contrast(s3[11:8]), contrast(s3[7:4]),
                 contrast(s3[3:0])} : s3;

    // SW8: Highlight red-colored pixels
    wire red_detected =
        (s4[11:8] >= 10) &&
        (s4[7:4] <= 5) &&
        (s4[3:0] <= 5);

    assign s5 = (processing_enable && sw[8])
              ? (red_detected ? 12'hF00 : s4) : s4;

    // SW9: Solarization-style enhancement
    assign s6 = (processing_enable && sw[9])
              ? { (s5[11:8] >= 8 ? ~s5[11:8] : s5[11:8]),
                  (s5[7:4]  >= 8 ? ~s5[7:4]  : s5[7:4]),
                  (s5[3:0]  >= 8 ? ~s5[3:0]  : s5[3:0])}
              : s5;

    assign pixel_out = s6;

endmodule
