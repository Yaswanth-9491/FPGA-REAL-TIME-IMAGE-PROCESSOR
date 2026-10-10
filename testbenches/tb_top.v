`timescale 1ns/1ps

module tb_top;

    reg clk;
    reg reset;
    reg [2:0] select;

    wire hsync;
    wire vsync;

    wire [3:0] vga_red;
    wire [3:0] vga_green;
    wire [3:0] vga_blue;

    top uut(
        .clk(clk),
        .reset(reset),
        .select(select),

        .hsync(hsync),
        .vsync(vsync),

        .vga_red(vga_red),
        .vga_green(vga_green),
        .vga_blue(vga_blue)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin

        reset = 1'b1;
        select = 3'b000;

        #100;

        reset = 1'b0;

        // Original
        select = 3'b000;
        #1000;

        // Negative
        select = 3'b001;
        #1000;

        // Grayscale
        select = 3'b010;
        #1000;

        // Threshold
        select = 3'b011;
        #1000;

        // Brightness
        select = 3'b100;
        #1000;

        $finish;

    end

endmodule
