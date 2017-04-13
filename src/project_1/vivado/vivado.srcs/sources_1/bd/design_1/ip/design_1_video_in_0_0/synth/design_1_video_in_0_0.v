// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: utoronto.ca:user:video_in:1.0
// IP Revision: 45

(* X_CORE_INFO = "video_in,Vivado 2016.2" *)
(* CHECK_LICENSE_TYPE = "design_1_video_in_0_0,video_in,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_video_in_0_0 (
  clk,
  resetn,
  OV7670_VSYNC,
  OV7670_HREF,
  OV7670_PCLK,
  OV7670_D,
  OV7670_SIOD,
  OV7670_XCLK,
  OV7670_SIOC,
  pwdn,
  config_done,
  vid_data,
  vid_field_id,
  vid_active_video,
  vid_vblank,
  vid_hblank,
  vid_vsync,
  vid_hsync,
  vid_io_in_clk,
  vid_io_in_ce,
  vid_io_in_reset,
  aclk,
  aclken,
  aresetn,
  axis_enable,
  LEDS
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 resetn RST" *)
input wire resetn;
input wire OV7670_VSYNC;
input wire OV7670_HREF;
input wire OV7670_PCLK;
input wire [7 : 0] OV7670_D;
inout wire OV7670_SIOD;
output wire OV7670_XCLK;
output wire OV7670_SIOC;
output wire pwdn;
output wire config_done;
output wire [15 : 0] vid_data;
output wire vid_field_id;
output wire vid_active_video;
output wire vid_vblank;
output wire vid_hblank;
output wire vid_vsync;
output wire vid_hsync;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 vid_io_in_clk CLK" *)
output wire vid_io_in_clk;
output wire vid_io_in_ce;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 vid_io_in_reset RST" *)
output wire vid_io_in_reset;
output wire aclk;
output wire aclken;
output wire aresetn;
output wire axis_enable;
output wire [7 : 0] LEDS;

  video_in inst (
    .clk(clk),
    .resetn(resetn),
    .OV7670_VSYNC(OV7670_VSYNC),
    .OV7670_HREF(OV7670_HREF),
    .OV7670_PCLK(OV7670_PCLK),
    .OV7670_D(OV7670_D),
    .OV7670_SIOD(OV7670_SIOD),
    .OV7670_XCLK(OV7670_XCLK),
    .OV7670_SIOC(OV7670_SIOC),
    .pwdn(pwdn),
    .config_done(config_done),
    .vid_data(vid_data),
    .vid_field_id(vid_field_id),
    .vid_active_video(vid_active_video),
    .vid_vblank(vid_vblank),
    .vid_hblank(vid_hblank),
    .vid_vsync(vid_vsync),
    .vid_hsync(vid_hsync),
    .vid_io_in_clk(vid_io_in_clk),
    .vid_io_in_ce(vid_io_in_ce),
    .vid_io_in_reset(vid_io_in_reset),
    .aclk(aclk),
    .aclken(aclken),
    .aresetn(aresetn),
    .axis_enable(axis_enable),
    .LEDS(LEDS)
  );
endmodule
