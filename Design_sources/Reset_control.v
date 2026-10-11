
module reset_control (
    input wire reset_button,
    output wire processing_enable
);
    assign processing_enable = ~reset_button;
endmodule
