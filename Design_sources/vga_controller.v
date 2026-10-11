`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2026 21:12:02
// Design Name: 
// Module Name: vga_controller
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

module vga_controller (
    input wire clk,
    input wire reset,
    output reg [9:0] x,
    output reg [9:0] y,
    output wire hsync,
    output wire vsync,
    output wire active_video
);

    always @(posedge clk) begin
        if (reset) begin
            x <= 0;
            y <= 0;
        end else if (x == 799) begin
            x <= 0;
            if (y == 524)
                y <= 0;
            else
                y <= y + 1'b1;
        end else begin
            x <= x + 1'b1;
        end
    end

    assign hsync = ~((x >= 656) && (x < 752));
    assign vsync = ~((y >= 490) && (y < 492));
    assign active_video = (x < 640) && (y < 480);

endmodule

