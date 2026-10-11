
`timescale 1ns / 1ps

module tb_top;

    reg CLK100MHZ;
    reg BTNC;
    reg [15:0] SW;

    wire [3:0] VGA_R, VGA_G, VGA_B;
    wire VGA_HS, VGA_VS;

    top dut (
        .CLK100MHZ(CLK100MHZ),
        .BTNC(BTNC),
        .SW(SW),
        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS)
    );

    initial CLK100MHZ = 0;
    always #5 CLK100MHZ = ~CLK100MHZ;

    initial begin
        BTNC = 1;
        SW = 0;

        #200;
        BTNC = 0;

        // Original image
        #500000;

        // Negative
        SW[0] = 1;
        #500000;

        // Negative + grayscale
        SW[1] = 1;
        #500000;

        // Add brightness and Gaussian blur
        SW[3] = 1;
        SW[5] = 1;
        #500000;

        // Add Sobel and dilation
        SW[6] = 1;
        SW[7] = 1;
        #500000;

        // Reset and select original image
        BTNC = 1;
        SW = 0;
        #200;
        BTNC = 0;

        // Allow approximately one complete VGA frame
        #17000000;

        $finish;
    end

endmodule
