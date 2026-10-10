module image_processor(
    input [23:0] pixel_in,
    input [2:0] select,
    output reg [23:0] pixel_out
);

    wire [7:0] r;
    wire [7:0] g;
    wire [7:0] b;

    wire [9:0] sum;
    wire [7:0] gray;

    wire [8:0] bright_r;
    wire [8:0] bright_g;
    wire [8:0] bright_b;

    assign r = pixel_in[23:16];
    assign g = pixel_in[15:8];
    assign b = pixel_in[7:0];

    assign sum = {2'b00,r} + {2'b00,g} + {2'b00,b};
    assign gray = sum / 3;

    assign bright_r = {1'b0,r} + 9'd32;
    assign bright_g = {1'b0,g} + 9'd32;
    assign bright_b = {1'b0,b} + 9'd32;

    always @(*) begin
        case(select)

            3'b000: begin
                pixel_out = pixel_in;
            end

            3'b001: begin
                pixel_out[23:16] = 8'd255 - r;
                pixel_out[15:8]  = 8'd255 - g;
                pixel_out[7:0]   = 8'd255 - b;
            end

            3'b010: begin
                pixel_out = {gray,gray,gray};
            end

            3'b011: begin
                if (gray >= 8'd128)
                    pixel_out = 24'hFFFFFF;
                else
                    pixel_out = 24'h000000;
            end

            3'b100: begin

                if (bright_r > 9'd255)
                    pixel_out[23:16] = 8'd255;
                else
                    pixel_out[23:16] = bright_r[7:0];

                if (bright_g > 9'd255)
                    pixel_out[15:8] = 8'd255;
                else
                    pixel_out[15:8] = bright_g[7:0];

                if (bright_b > 9'd255)
                    pixel_out[7:0] = 8'd255;
                else
                    pixel_out[7:0] = bright_b[7:0];

            end

            default: begin
                pixel_out = pixel_in;
            end

        endcase
    end

endmodule