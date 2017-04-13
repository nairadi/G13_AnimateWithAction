`ifndef _ipu_params_
`define _ipu_params_

parameter FRAME_WIDTH = 640;
parameter FRAME_HEIGHT = 480;
parameter MAX_BRIGHT_PIXELS = 10000;				// Assume that at most half of the frame is bright
parameter COL_DAT_WIDTH = 10;
parameter ROW_DAT_WIDTH = 9;
parameter LUMINOSITY_THRESHOLD = 200;
parameter PRECISION = 5;
parameter MAX_BLOCKS = 25;							    // Assume that the picture has maximum of 100 blocks
parameter AREA_TO_FILL_RATIO = 1.2;
parameter NOISE_THRESHOLD = 90;
parameter NOISE = 1;
parameter CIRCLE = 2;
parameter LINE = 3;
parameter PI = 3;

`endif