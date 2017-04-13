//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
//Date        : Fri Mar 31 13:50:54 2017
//Host        : SFB520WS30 running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (LEDS,
    OV7670_D,
    OV7670_HREF,
    OV7670_PCLK,
    OV7670_RESET,
    OV7670_SIOC,
    OV7670_SIOD,
    OV7670_VSYNC,
    OV7670_XCLK,
    clk,
    config_done,
    hsyn,
    pwdn,
    reset_rtl,
    resetn,
    uart_rtl_rxd,
    uart_rtl_txd,
    vga444_blue,
    vga444_green,
    vga444_red,
    vga_hsync,
    vga_vsync,
    vsyn);
  output [7:0]LEDS;
  input [7:0]OV7670_D;
  input OV7670_HREF;
  input OV7670_PCLK;
  output OV7670_RESET;
  output OV7670_SIOC;
  inout OV7670_SIOD;
  input OV7670_VSYNC;
  output OV7670_XCLK;
  input clk;
  output config_done;
  output hsyn;
  output pwdn;
  input reset_rtl;
  input resetn;
  input uart_rtl_rxd;
  output uart_rtl_txd;
  output [3:0]vga444_blue;
  output [3:0]vga444_green;
  output [3:0]vga444_red;
  output vga_hsync;
  output vga_vsync;
  output vsyn;

  wire [7:0]LEDS;
  wire [7:0]OV7670_D;
  wire OV7670_HREF;
  wire OV7670_PCLK;
  wire OV7670_RESET;
  wire OV7670_SIOC;
  wire OV7670_SIOD;
  wire OV7670_VSYNC;
  wire OV7670_XCLK;
  wire clk;
  wire config_done;
  wire hsyn;
  wire pwdn;
  wire reset_rtl;
  wire resetn;
  wire uart_rtl_rxd;
  wire uart_rtl_txd;
  wire [3:0]vga444_blue;
  wire [3:0]vga444_green;
  wire [3:0]vga444_red;
  wire vga_hsync;
  wire vga_vsync;
  wire vsyn;

  design_1 design_1_i
       (.LEDS(LEDS),
        .OV7670_D(OV7670_D),
        .OV7670_HREF(OV7670_HREF),
        .OV7670_PCLK(OV7670_PCLK),
        .OV7670_RESET(OV7670_RESET),
        .OV7670_SIOC(OV7670_SIOC),
        .OV7670_SIOD(OV7670_SIOD),
        .OV7670_VSYNC(OV7670_VSYNC),
        .OV7670_XCLK(OV7670_XCLK),
        .clk(clk),
        .config_done(config_done),
        .hsyn(hsyn),
        .pwdn(pwdn),
        .reset_rtl(reset_rtl),
        .resetn(resetn),
        .uart_rtl_rxd(uart_rtl_rxd),
        .uart_rtl_txd(uart_rtl_txd),
        .vga444_blue(vga444_blue),
        .vga444_green(vga444_green),
        .vga444_red(vga444_red),
        .vga_hsync(vga_hsync),
        .vga_vsync(vga_vsync),
        .vsyn(vsyn));
endmodule
