`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2017 12:26:26 PM
// Design Name: 
// Module Name: video_in_tb
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


module video_in_tb(

    );
    
    reg  [7:0] OV7670_D;
    reg  OV7670_HREF;
    wire OV7670_PCLK;
    wire OV7670_SIOC;
    wire OV7670_SIOD;
    reg  OV7670_VSYNC;
    wire OV7670_XCLK;
    reg  clk;
    reg  clk1;
    reg  resetn;
    //reg  m_axis_video_tready;
    wire pwdn;
    
    initial
    begin
        clk <= 0;
        forever #5 clk <= ~clk;
    end
    
    initial
    begin
        clk1 <= 0;
        forever #20 clk1 <= ~clk1;
    end
    
    initial
    begin
        OV7670_D = 8'h1e;
        #1260 OV7670_D = 8'h78;
    end
    
    initial
    begin
        OV7670_VSYNC <= 1;
        forever #1000 OV7670_VSYNC <= ~OV7670_VSYNC;
    end
    
    initial
    begin
        OV7670_HREF <= 1;
        forever #300 OV7670_HREF <= ~OV7670_HREF;
    end
    
    //initial
    //begin
    //    m_axis_video_tready <= 1;
    //    forever #2000 m_axis_video_tready <= ~m_axis_video_tready;
    //end
    
    initial
    begin
        resetn <= 0;
        #10 resetn <= 1;
    end
    
    assign OV7670_PCLK = clk1;
    
    design_1 design_1_i
           (.LEDS(),
            .OV7670_D(OV7670_D),
            .OV7670_HREF(OV7670_HREF),
            .OV7670_PCLK(OV7670_PCLK),
            .OV7670_RESET(),
            .OV7670_SIOC(OV7670_SIOC),
            .OV7670_SIOD(OV7670_SIOD),
            .OV7670_VSYNC(OV7670_VSYNC),
            .OV7670_XCLK(OV7670_XCLK),
            .clk(clk),
            .config_done(),
            .hsyn(),
            .pwdn(),
            .reset_rtl(resets),
            .resetn(resetn),
            .uart_rtl_rxd(),
            .uart_rtl_txd(),
            .vga444_blue(),
            .vga444_green(),
            .vga444_red(),
            .vga_hsync(),
            .vga_vsync(),
            .vsyn());
endmodule
