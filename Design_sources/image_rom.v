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


module image_rom (
    input wire clk,
    input wire [17:0] address,
    output reg [11:0] pixel
);

    reg [11:0] memory [0:172799];

    initial begin
        $readmemh("image.mem", memory);
    end

    always @(posedge clk) begin
        pixel <= memory[address];
    end

endmodule
