 

/* This module decides which block a bright pixel should be allocated to.
 * Inputs: comparison signals from all blocks, 
 *         enable signal from the IPU block, 
 *		   occupation status of each block(0->block not used yet, 1->block is in use)  
 * Outputs: decision code (1->add the pixel to the block; 0->copy the block to memory), target block  
 */
 
module block_arbiter (
					  input clk,
					  input decision_needed,
					  input [24:0] occupation_vector,
					  input [24:0] comparator_results,
					  input [24:0] is_noise,
					  input [(25*5)-1:0] priority_index,
					  output reg decision_code,
					  output reg [4:0] target_block
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

					  
reg [4:0] block_available_index;

always @ (posedge clk)
begin
	if (decision_needed)
	begin
		if (occupation_vector == 0)
		// All blocks are available for use
		begin
			decision_code <= 1;
			target_block <= 0;
		end
		else
		begin
			if ((comparator_results & occupation_vector) == 0)
			// The current pixel does not fit in any occupied block
			begin
				block_available_index <= available_block(occupation_vector);
				if (available_block(occupation_vector) != MAX_BLOCKS)
				begin
					decision_code <= 1;
					target_block <= available_block(occupation_vector);
				end
				else
				begin
					decision_code <= 0;
					// We need to find out which block needs to be written to memory
					target_block <= noise_block (is_noise, priority_index);
				end
			end
			else
			// The current pixel fits into an occupied block
			begin
				decision_code <= 1;
				target_block <= parent_block (comparator_results, occupation_vector);
			end
		end
	end
end

function [4:0] available_block;
input [MAX_BLOCKS-1:0] vector;
reg [4:0] i;
reg flag;
begin
	for (i=0, flag=0; i<MAX_BLOCKS; i=i+1)
	begin : search_for_1
		if (vector[i] == 0 && flag == 0)
		begin
			available_block = i;
			flag = 1;
			disable search_for_1;
		end
	end
	if (flag == 0)
	begin
	   available_block  = MAX_BLOCKS;
	end
end 
endfunction

function [4:0] noise_block;
input [MAX_BLOCKS-1:0] noise_vector;
input [(MAX_BLOCKS*5)-1:0] priority_vector;
reg [4:0] i;
reg [4:0] j;
reg [4:0] k;
begin
	for (i=0,j=31; i<MAX_BLOCKS; i=i+1)
	begin
	    k = priority_vector >> (i*5);
		if (noise_vector[i] == 1 && k < j)
		begin
			noise_block = i;
			j = k;
		end
	end
end 
endfunction

function [4:0] parent_block;
input [MAX_BLOCKS-1:0] results;
input [MAX_BLOCKS-1:0] vector;
reg [4:0] i;
begin
	for (i=0; i<MAX_BLOCKS; i=i+1)
	begin : search_for_blk
		if ((vector[i] & results[i]) == 1)
		begin
			parent_block = i;
			disable search_for_blk;
		end
	end
end
endfunction

endmodule