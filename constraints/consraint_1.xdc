## Nexys 4 DDR Rev. C
## Port names must match top.v

## 100 MHz onboard clock
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { clk }]
create_clock -add -name sys_clk_pin -period 10.000 -waveform {0 5} [get_ports { clk }]

## Reset button: BTNC (active high)
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports { reset }]

## Feature selection switches
## select[0] = SW0
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports { select[0] }]

## select[1] = SW1
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports { select[1] }]

## select[2] = SW2
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports { select[2] }]

## VGA Red
set_property -dict { PACKAGE_PIN A3 IOSTANDARD LVCMOS33 } [get_ports { vga_red[0] }]
set_property -dict { PACKAGE_PIN B4 IOSTANDARD LVCMOS33 } [get_ports { vga_red[1] }]
set_property -dict { PACKAGE_PIN C5 IOSTANDARD LVCMOS33 } [get_ports { vga_red[2] }]
set_property -dict { PACKAGE_PIN A4 IOSTANDARD LVCMOS33 } [get_ports { vga_red[3] }]

## VGA Green
set_property -dict { PACKAGE_PIN C6 IOSTANDARD LVCMOS33 } [get_ports { vga_green[0] }]
set_property -dict { PACKAGE_PIN A5 IOSTANDARD LVCMOS33 } [get_ports { vga_green[1] }]
set_property -dict { PACKAGE_PIN B6 IOSTANDARD LVCMOS33 } [get_ports { vga_green[2] }]
set_property -dict { PACKAGE_PIN A6 IOSTANDARD LVCMOS33 } [get_ports { vga_green[3] }]

## VGA Blue
set_property -dict { PACKAGE_PIN B7 IOSTANDARD LVCMOS33 } [get_ports { vga_blue[0] }]
set_property -dict { PACKAGE_PIN C7 IOSTANDARD LVCMOS33 } [get_ports { vga_blue[1] }]
set_property -dict { PACKAGE_PIN D7 IOSTANDARD LVCMOS33 } [get_ports { vga_blue[2] }]
set_property -dict { PACKAGE_PIN D8 IOSTANDARD LVCMOS33 } [get_ports { vga_blue[3] }]

## VGA Synchronization
set_property -dict { PACKAGE_PIN B11 IOSTANDARD LVCMOS33 } [get_ports { hsync }]
set_property -dict { PACKAGE_PIN B12 IOSTANDARD LVCMOS33 } [get_ports { vsync }]