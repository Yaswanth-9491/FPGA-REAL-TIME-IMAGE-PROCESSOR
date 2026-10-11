`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2026 22:29:59
// Design Name: 
// Module Name: clock_divider
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

module clock_25mhz (
    input wire clk100,
    output reg clk25
);
    reg [1:0] count;

    initial begin
        count = 0;
        clk25 = 0;
    end

    always @(posedge clk100) begin
        if (count == 1) begin
            count <= 0;
            clk25 <= ~clk25;
        end else begin
            count <= count + 1'b1;
        end
    end
endmodule

