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
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_controller(
    input clk,
    input reset,
    input [23:0] pixel_data,

    output reg hsync,
    output reg vsync,

    output reg [3:0] red,
    output reg [3:0] green,
    output reg [3:0] blue,

    output reg [18:0] pixel_address
);

    reg [9:0] h_count;
    reg [9:0] v_count;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            h_count <= 10'd0;
            v_count <= 10'd0;
        end

        else begin

            if (h_count == 10'd799) begin

                h_count <= 10'd0;

                if (v_count == 10'd524)
                    v_count <= 10'd0;
                else
                    v_count <= v_count + 1'b1;

            end

            else begin
                h_count <= h_count + 1'b1;
            end

        end

    end

    always @(*) begin

        hsync = ~((h_count >= 10'd656) &&
                  (h_count < 10'd752));

        vsync = ~((v_count >= 10'd490) &&
                  (v_count < 10'd492));

        red = 4'd0;
        green = 4'd0;
        blue = 4'd0;

        pixel_address = 19'd0;

        if ((h_count < 640) && (v_count < 480)) begin

            red = pixel_data[23:20];
            green = pixel_data[15:12];
            blue = pixel_data[7:4];

            pixel_address = v_count * 640 + h_count;

        end

    end

endmodule
