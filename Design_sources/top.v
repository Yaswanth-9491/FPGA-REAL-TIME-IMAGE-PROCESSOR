`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2026 22:33:18
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top (
    input wire CLK100MHZ,
    input wire BTNC,
    input wire [15:0] SW,

    output wire [3:0] VGA_R,
    output wire [3:0] VGA_G,
    output wire [3:0] VGA_B,
    output wire VGA_HS,
    output wire VGA_VS
);

    wire clk25;
    wire processing_enable;

    wire [9:0] x, y;
    wire hsync, vsync, active_video;

    wire image_valid_now;
    wire [9:0] image_x_now, image_y_now;
    wire [17:0] rom_address;
    wire [11:0] rom_pixel;

    reg valid0;
    reg [9:0] x0, y0;
    reg [3:0] hs_pipe, vs_pipe, active_pipe;

    wire [11:0] pixelwise;
    wire [11:0] blur_pixel, sobel_pixel, dilation_pixel;

    wire valid_blur, valid_sobel, valid_dilation;
    wire [9:0] xb, yb, xs, ys, xd, yd;

    clock_25mhz clkgen (
        .clk100(CLK100MHZ),
        .clk25(clk25)
    );

    reset_control rc (
        .reset_button(BTNC),
        .processing_enable(processing_enable)
    );

    vga_controller vga (
        .clk(clk25),
        .reset(BTNC),
        .x(x),
        .y(y),
        .hsync(hsync),
        .vsync(vsync),
        .active_video(active_video)
    );

    assign image_valid_now =
        active_video &&
        (x >= 80) && (x < 560) &&
        (y >= 60) && (y < 420);

    assign image_x_now =
        image_valid_now ? x - 80 : 0;

    assign image_y_now =
        image_valid_now ? y - 60 : 0;

    assign rom_address =
        image_y_now * 18'd480 + image_x_now;

    image_rom rom (
        .clk(clk25),
        .address(rom_address),
        .pixel(rom_pixel)
    );

    // Align the ROM output with its coordinates and VGA timing.
    always @(posedge clk25) begin
        if (BTNC) begin
            valid0 <= 0;
            x0 <= 0;
            y0 <= 0;
            hs_pipe <= 0;
            vs_pipe <= 0;
            active_pipe <= 0;
        end else begin
            valid0 <= image_valid_now;
            x0 <= image_x_now;
            y0 <= image_y_now;

            hs_pipe <= {hs_pipe[2:0], hsync};
            vs_pipe <= {vs_pipe[2:0], vsync};
            active_pipe <= {active_pipe[2:0], active_video};
        end
    end

    // Pixelwise stages: SW0-SW4, SW8 and SW9.
    image_processor ip (
        .pixel_in(rom_pixel),
        .sw(SW[9:0]),
        .processing_enable(processing_enable),
        .pixel_out(pixelwise)
    );

    // Spatial stages: each stage has its own neighborhood buffers.
    gaussian_blur gb (
        .clk(clk25),
        .reset(BTNC),
        .valid_in(valid0),
        .x(x0), .y(y0),
        .pixel_in(pixelwise),
        .enable(SW[5] && processing_enable),
        .valid_out(valid_blur),
        .x_out(xb), .y_out(yb),
        .pixel_out(blur_pixel)
    );

    sobel_edge se (
        .clk(clk25),
        .reset(BTNC),
        .valid_in(valid_blur),
        .x(xb), .y(yb),
        .pixel_in(blur_pixel),
        .enable(SW[6] && processing_enable),
        .valid_out(valid_sobel),
        .x_out(xs), .y_out(ys),
        .pixel_out(sobel_pixel)
    );

    dilation di (
        .clk(clk25),
        .reset(BTNC),
        .valid_in(valid_sobel),
        .x(xs), .y(ys),
        .pixel_in(sobel_pixel),
        .enable(SW[7] && processing_enable),
        .valid_out(valid_dilation),
        .x_out(xd), .y_out(yd),
        .pixel_out(dilation_pixel)
    );

    // The spatial pipeline has three registered stages.
    assign VGA_HS = hs_pipe[3];
    assign VGA_VS = vs_pipe[3];

    assign VGA_R =
        (active_pipe[3] && valid_dilation)
        ? dilation_pixel[11:8] : 4'b0000;

    assign VGA_G =
        (active_pipe[3] && valid_dilation)
        ? dilation_pixel[7:4] : 4'b0000;

    assign VGA_B =
        (active_pipe[3] && valid_dilation)
        ? dilation_pixel[3:0] : 4'b0000;

endmodule

