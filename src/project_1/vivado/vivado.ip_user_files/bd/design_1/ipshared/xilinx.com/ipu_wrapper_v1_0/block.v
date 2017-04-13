

/* This module stores information about a block of bright pixels.
 * Inputs: row and column coordinates
 *         enable signals to generate comparison checks and writing/updating data,
 *  	   current maximum priority  
 * Outputs: results from comparison operation, noise check operation
 *          updated priority of the block  
 */

module block (
			  input[8:0] row,
			  input[9:0] col,
			  input enable_comparison,
			  input update_parameters,
			  input first_blk_pixel,
			  input [4:0] highest_priority,
			  input update_priority,
			  input [4:0] ref_priority,
			  
			  output reg comparison_result,
			  output reg is_noise,
			  output reg [4:0] priority_index,
			  output reg [8:0] top,
			  output reg [8:0] bottom,
			  output reg [8:0] left_row,
			  output reg [9:0] left_col,
			  output reg [9:0] right,
			  output reg [31:0] area,
			  output reg [31:0] fill
			  );
			  

              
parameter FRAME_WIDTH = 320;
parameter FRAME_HEIGHT = 240;
parameter MAX_BRIGHT_PIXELS = 10000;                // Assume that at most half of the frame is bright
parameter COL_DAT_WIDTH = 10;
parameter ROW_DAT_WIDTH = 9;
parameter LUMINOSITY_THRESHOLD = 200;
parameter PRECISION = 5;
parameter MAX_BLOCKS = 25;                                // Assume that the picture has maximum of 100 blocks
parameter AREA_TO_FILL_RATIO = 1.2;
parameter NOISE_THRESHOLD = 90;
parameter NOISE = 1;
parameter CIRCLE = 2;
parameter LINE = 3;
parameter PI = 3;
              

					 
always @ (*)
begin	
	if (enable_comparison)
	begin
		comparison_result = ((row <= (bottom + PRECISION)) && ((col >= (left_col - PRECISION))) && (col <= (right + PRECISION)));
		is_noise = (area < NOISE_THRESHOLD);
	end
	
	if (first_blk_pixel)
	begin
		top = row;
		bottom = row;
		left_row = row;
		left_col = col;
		right = col;
		fill = 1;
		area = 1;
	end
	
	if (update_parameters)
	begin
		fill = fill + (fill>>2);
		bottom = row;
		if (col < left_col)
		begin
			left_row = row;
			left_col = col;
		end
        else
			if (col > right)
				right = col;
		area = (row - top + 1) * (right - left_col + 1);
	end
	
	if (update_priority)
	begin
		if (first_blk_pixel || update_parameters)
			priority_index = highest_priority;
		else
		begin
			if (priority_index > ref_priority)
				priority_index = priority_index - 1;
			else
				priority_index = priority_index;
		end
	end
	
end	
endmodule