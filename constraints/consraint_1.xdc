
## =========================================================
## Nexys 4 DDR Rev. C - FPGA Image Processing
## Top module ports: CLK100MHZ, BTNC, SW, VGA_R, VGA_G,
##                   VGA_B, VGA_HS, VGA_VS
## =========================================================

## 1. 100 MHz System Clock
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {CLK100MHZ}]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}]

## 2. Slide Switches SW0-SW7
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports {SW[0]}]
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports {SW[1]}]
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports {SW[2]}]
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports {SW[3]}]
set_property -dict { PACKAGE_PIN R17 IOSTANDARD LVCMOS33 } [get_ports {SW[4]}]
set_property -dict { PACKAGE_PIN T18 IOSTANDARD LVCMOS33 } [get_ports {SW[5]}]
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports {SW[6]}]
set_property -dict { PACKAGE_PIN R13 IOSTANDARD LVCMOS33 } [get_ports {SW[7]}]

## 3. Slide Switches SW8-SW9
set_property -dict { PACKAGE_PIN T8 IOSTANDARD LVCMOS18 } [get_ports {SW[8]}]
set_property -dict { PACKAGE_PIN U8 IOSTANDARD LVCMOS18 } [get_ports {SW[9]}]

## 4. Remaining Slide Switches SW10-SW15
set_property -dict { PACKAGE_PIN R16 IOSTANDARD LVCMOS33 } [get_ports {SW[10]}]
set_property -dict { PACKAGE_PIN T13 IOSTANDARD LVCMOS33 } [get_ports {SW[11]}]
set_property -dict { PACKAGE_PIN H6 IOSTANDARD LVCMOS33 } [get_ports {SW[12]}]
set_property -dict { PACKAGE_PIN U12 IOSTANDARD LVCMOS33 } [get_ports {SW[13]}]
set_property -dict { PACKAGE_PIN U11 IOSTANDARD LVCMOS33 } [get_ports {SW[14]}]
set_property -dict { PACKAGE_PIN V10 IOSTANDARD LVCMOS33 } [get_ports {SW[15]}]

## 5. Center Push Button - Reset
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports {BTNC}]

## 6. VGA Red Outputs
set_property -dict { PACKAGE_PIN A3 IOSTANDARD LVCMOS33 } [get_ports {VGA_R[0]}]
set_property -dict { PACKAGE_PIN B4 IOSTANDARD LVCMOS33 } [get_ports {VGA_R[1]}]
set_property -dict { PACKAGE_PIN C5 IOSTANDARD LVCMOS33 } [get_ports {VGA_R[2]}]
set_property -dict { PACKAGE_PIN A4 IOSTANDARD LVCMOS33 } [get_ports {VGA_R[3]}]

## 7. VGA Green Outputs
set_property -dict { PACKAGE_PIN C6 IOSTANDARD LVCMOS33 } [get_ports {VGA_G[0]}]
set_property -dict { PACKAGE_PIN A5 IOSTANDARD LVCMOS33 } [get_ports {VGA_G[1]}]
set_property -dict { PACKAGE_PIN B6 IOSTANDARD LVCMOS33 } [get_ports {VGA_G[2]}]
set_property -dict { PACKAGE_PIN A6 IOSTANDARD LVCMOS33 } [get_ports {VGA_G[3]}]

## 8. VGA Blue Outputs
set_property -dict { PACKAGE_PIN B7 IOSTANDARD LVCMOS33 } [get_ports {VGA_B[0]}]
set_property -dict { PACKAGE_PIN C7 IOSTANDARD LVCMOS33 } [get_ports {VGA_B[1]}]
set_property -dict { PACKAGE_PIN D7 IOSTANDARD LVCMOS33 } [get_ports {VGA_B[2]}]
set_property -dict { PACKAGE_PIN D8 IOSTANDARD LVCMOS33 } [get_ports {VGA_B[3]}]

## 9. VGA Synchronization
set_property -dict { PACKAGE_PIN B11 IOSTANDARD LVCMOS33 } [get_ports {VGA_HS}]
set_property -dict { PACKAGE_PIN B12 IOSTANDARD LVCMOS33 } [get_ports {VGA_VS}]
