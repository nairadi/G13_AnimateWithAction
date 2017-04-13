`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2017 11:02:45 AM
// Design Name: 
// Module Name: video_in
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module video_in     (
                    input                   clk,
                    input                   resetn,
                    input                   OV7670_VSYNC,
                    input                   OV7670_HREF,
                    input                   OV7670_PCLK,
                    input       [7:0]       OV7670_D,
                    inout                   OV7670_SIOD,
                    output                  OV7670_XCLK,
                    output                  OV7670_SIOC,
                    output                  pwdn,
                    output                  config_done,
                    output      [15:0]      vid_data,
                    output                  vid_field_id,
                    output                  vid_active_video,
                    output                  vid_vblank,
                    output                  vid_hblank,
                    output                  vid_vsync,
                    output                  vid_hsync,
                    output                  vid_io_in_clk,
                    output                  vid_io_in_ce,
                    output                  vid_io_in_reset,
                    output                  aclk,
                    output                  aclken,
                    output                  aresetn,
                    output                  axis_enable,
                    output      [7:0]       LEDS
                    );
                    
    wire        [15:0]      data;
    wire                    pclk_out;
    wire                    data_valid;

    assign OV7670_XCLK      = clk;
    
    assign pwdn             = 1'b0;
    
    assign vid_data         = data;
    assign vid_active_video = data_valid;
    assign vid_vsync        = OV7670_VSYNC;
    assign vid_hsync        = OV7670_HREF;
    
    assign vid_io_in_clk    = pclk_out;
    assign vid_io_in_ce     = 1'b1;
    assign vid_io_in_reset  = !resetn;
    
    assign vid_field_id     = 1'b1;
    assign vid_vblank       = 1'b0;
    assign vid_hblank       = 1'b0;
    
    assign aclk             = clk;
    assign aclken           = 1'b1;
    assign aresetn          = resetn;
    assign axis_enable      = 1'b1;
    
    assign LEDS             = data[7:0];
    
    pmod_cam cam    (
                    .pclk       (OV7670_PCLK),
                    .vsync      (OV7670_VSYNC),
                    .href       (OV7670_HREF),
                    .din        (OV7670_D),
                    .pclk_out   (pclk_out),
                    .data_valid (data_valid),
                    .dout       (data)
                    );
    
    I2C_AV_Config IIC   (
                        .iCLK           (clk),    
                        .iRST_N         (1'b1),
                        .Config_Done    (config_done),
                        .I2C_SDAT       (OV7670_SIOD),    
                        .I2C_SCLK       (OV7670_SIOC),
                        .LUT_INDEX      (),
                        .I2C_RDATA      ()
                        );

endmodule
