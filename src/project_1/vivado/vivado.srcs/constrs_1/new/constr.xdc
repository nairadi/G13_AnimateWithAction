## Configured for ov7670_top on the NEXYS4 DDR board

## Clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## Resetn
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports resetn]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports reset_rtl]

##USB-RS232 Interface

set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports uart_rtl_rxd]
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports uart_rtl_txd]

## Powerdown
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports pwdn]

##Pmod Headers
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports OV7670_VSYNC]
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports OV7670_HREF]
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports OV7670_PCLK]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets OV7670_PCLK]

set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports {OV7670_RESET}]
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports {OV7670_D[0]}]
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {OV7670_D[1]}]
set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS33} [get_ports {OV7670_D[2]}]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {OV7670_D[3]}]
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {OV7670_D[4]}]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {OV7670_D[5]}]
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports {OV7670_D[6]}]
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports {OV7670_D[7]}]
set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports OV7670_SIOC]
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports OV7670_XCLK]

set_property PACKAGE_PIN H16 [get_ports OV7670_SIOD]
set_property IOSTANDARD LVCMOS33 [get_ports OV7670_SIOD]
set_property PULLUP true [get_ports OV7670_SIOD]


##VGA Connector

set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {vga444_red[0]}]
set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {vga444_red[1]}]
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports {vga444_red[2]}]
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {vga444_red[3]}]

set_property -dict {PACKAGE_PIN C6 IOSTANDARD LVCMOS33} [get_ports {vga444_green[0]}]
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {vga444_green[1]}]
set_property -dict {PACKAGE_PIN B6 IOSTANDARD LVCMOS33} [get_ports {vga444_green[2]}]
set_property -dict {PACKAGE_PIN A6 IOSTANDARD LVCMOS33} [get_ports {vga444_green[3]}]

set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {vga444_blue[0]}]
set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {vga444_blue[1]}]
set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVCMOS33} [get_ports {vga444_blue[2]}]
set_property -dict {PACKAGE_PIN D8 IOSTANDARD LVCMOS33} [get_ports {vga444_blue[3]}]

set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports vga_hsync]
set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports vga_vsync]

#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[0]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[1]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[2]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[3]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[4]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[5]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[6]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[7]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[8]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[9]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[10]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[11]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[12]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[13]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[14]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[15]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[16]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[17]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[18]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[19]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[20]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[21]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[22]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[23]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[24]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[25]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[26]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[27]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[28]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[29]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[30]]
#set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports addrb[31]]
#set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports enb]

set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {LEDS[0]}]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {LEDS[1]}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {LEDS[2]}]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {LEDS[3]}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {LEDS[4]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {LEDS[5]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {LEDS[6]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {LEDS[7]}]
#set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {row_idx[8]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {config_done}]
#set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {row_idx[10]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {hsyn}]
#set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {row_idx[12]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {vsyn}]
#set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {row_idx[14]}]
#set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports {row_idx[15]}]


