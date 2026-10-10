`timescale 1ns/1ps

module tb_image_rom;

    reg [18:0] address;
    wire [23:0] pixel_data;

    image_rom uut(
        .address(address),
        .pixel_data(pixel_data)
    );

    initial begin

        address = 19'd0;
        #10;

        address = 19'd1;
        #10;

        address = 19'd2;
        #10;

        address = 19'd100;
        #10;

        address = 19'd1000;
        #10;

        $finish;

    end

endmodule
