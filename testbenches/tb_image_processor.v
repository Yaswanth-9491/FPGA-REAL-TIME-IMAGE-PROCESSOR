`timescale 1ns/1ps

module tb_image_processor;

    reg [23:0] pixel_in;
    reg [2:0] select;

    wire [23:0] pixel_out;

    image_processor uut(
        .pixel_in(pixel_in),
        .select(select),
        .pixel_out(pixel_out)
    );

    initial begin

        pixel_in = 24'h6496C8;

        select = 3'b000;
        #10;

        select = 3'b001;
        #10;

        select = 3'b010;
        #10;

        select = 3'b011;
        #10;

        select = 3'b100;
        #10;

        $finish;

    end

endmodule
