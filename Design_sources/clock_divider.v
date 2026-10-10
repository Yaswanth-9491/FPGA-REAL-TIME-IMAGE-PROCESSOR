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
//////////////////////////////////////////////////////////////////////////////////

module clock_divider(
    input clk,
    input reset,
    output reg clk_25
);

    reg [1:0] count;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            count <= 2'd0;
            clk_25 <= 1'b0;
        end

        else begin

            if (count == 2'd1) begin
                count <= 2'd0;
                clk_25 <= ~clk_25;
            end

            else begin
                count <= count + 1'b1;
            end

        end

    end

endmodule