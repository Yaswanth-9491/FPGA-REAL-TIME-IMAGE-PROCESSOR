`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2026 22:31:36
// Design Name: 
// Module Name: image_rom
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

module image_rom(
    input [18:0] address,
    output reg [23:0] pixel_data
);

    reg [23:0] memory [0:307199];

    initial begin
        $readmemh("../image/image.mem", memory);
    end

    always @(*) begin
        pixel_data = memory[address];
    end

endmodule
