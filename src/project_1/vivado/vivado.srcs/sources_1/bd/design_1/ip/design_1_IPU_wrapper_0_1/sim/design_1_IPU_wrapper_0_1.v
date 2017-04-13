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


// IP VLNV: xilinx.com:user:IPU_wrapper:1.0
// IP Revision: 27

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_IPU_wrapper_0_1 (
  m_axis_video_tdata,
  aclk,
  m_axis_video_tlast,
  valid,
  m_axis_video_tuser,
  aresetn,
  m_axis_video_tready,
  write_to_mem_en,
  write_to_mem_addr,
  write_to_mem_data,
  row_idx,
  col_idx,
  enable_comparison,
  block_updated
);

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TDATA" *)
input wire [15 : 0] m_axis_video_tdata;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
input wire aclk;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TLAST" *)
input wire m_axis_video_tlast;
input wire valid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TUSER" *)
input wire m_axis_video_tuser;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *)
input wire aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TREADY" *)
output wire m_axis_video_tready;
output wire write_to_mem_en;
output wire [31 : 0] write_to_mem_addr;
output wire [63 : 0] write_to_mem_data;
output wire [8 : 0] row_idx;
output wire [9 : 0] col_idx;
output wire enable_comparison;
output wire block_updated;

  IPU_wrapper inst (
    .m_axis_video_tdata(m_axis_video_tdata),
    .aclk(aclk),
    .m_axis_video_tlast(m_axis_video_tlast),
    .valid(valid),
    .m_axis_video_tuser(m_axis_video_tuser),
    .aresetn(aresetn),
    .m_axis_video_tready(m_axis_video_tready),
    .write_to_mem_en(write_to_mem_en),
    .write_to_mem_addr(write_to_mem_addr),
    .write_to_mem_data(write_to_mem_data),
    .row_idx(row_idx),
    .col_idx(col_idx),
    .enable_comparison(enable_comparison),
    .block_updated(block_updated)
  );
endmodule
