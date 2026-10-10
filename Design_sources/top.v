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


module top(
    input clk,
    input reset,

    input [2:0] select,

    output hsync,
    output vsync,

    output [3:0] vga_red,
    output [3:0] vga_green,
    output [3:0] vga_blue
);

    wire clk_25;

    wire [18:0] pixel_address;

    wire [23:0] original_pixel;
    wire [23:0] processed_pixel;

    clock_divider clock_inst(
        .clk(clk),
        .reset(reset),
        .clk_25(clk_25)
    );

    image_rom rom_inst(
        .address(pixel_address),
        .pixel_data(original_pixel)
    );

    image_processor processor_inst(
        .pixel_in(original_pixel),
        .select(select),
        .pixel_out(processed_pixel)
    );

    vga_controller vga_inst(
        .clk(clk_25),
        .reset(reset),
        .pixel_data(processed_pixel),

        .hsync(hsync),
        .vsync(vsync),

        .red(vga_red),
        .green(vga_green),
        .blue(vga_blue),

        .pixel_address(pixel_address)
    );

endmodule