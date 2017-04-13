 

/* Inputs: Clock signal, 
 *         enable signal (high when we valid frame data in the buffer) 
 *		   frame_data (pixel Y value)
 * Output: Frame index, frame done signal, BRAM access address, write_enable
 */					
 
module IPU_core (
					  input clk,
					  input resetn,
					  input [15:0] frame_data,
					  input valid,
					  input new_frame_start,
					  input curr_col_end,
					  input valid_data,
					  
					  output reg frame_done,
					  output reg [31:0] write_address,
					  output reg [63:0] write_data,
					  output reg write_enable,
					  output reg [8:0] row_idx,
                      output reg [9:0] col_idx,
                      output reg enable_comparison,
                      output reg block_updated,
                      output reg pixel_done
					 );
					 
`ifndef _ipu_params_
`define _ipu_params_

parameter BLOCK_MEM_ADDR = 0;
parameter FRAME_WIDTH = 320;
parameter FRAME_HEIGHT = 240;
parameter MAX_BRIGHT_PIXELS = 10000;                // Assume that at most half of the frame is bright
parameter COL_DAT_WIDTH = 9;
parameter ROW_DAT_WIDTH = 8;
parameter LUMINOSITY_THRESHOLD = 200;
parameter PRECISION = 10;
parameter MAX_BLOCKS = 25;                                // Assume that the picture has maximum of 100 blocks
parameter AREA_TO_FILL_RATIO = 1.2;
parameter NOISE_THRESHOLD = 90;
parameter NOISE = 1;
parameter CIRCLE = 2;
parameter LINE = 3;
parameter PI = 3;

`endif


reg [63:0] offset;
wire [7:0] isPart;
reg [2:0] blk_idx;
reg last_col_index;
reg [71:0] ref_col_idx;
reg [63:0] ref_row_idx;
wire result;
reg RGB_valid_stage1, RGB_valid_stage2;

assign result = isPart[0] | isPart[1] | isPart[2] | isPart[3] | isPart[4] | isPart[5] | isPart[6] | isPart[7];

genvar i;
generate
for (i=0; i<8; i=i+1)
begin : blk_buffer
	block _b ( 
				.col_idx (col_idx),
				.row_idx (row_idx),
				.ref_col_idx (ref_col_idx[((i+1)*9)-1:(i*9)]),
				.ref_row_idx (ref_row_idx[((i+1)*8)-1:(i*8)]),
				.result (isPart[i])
			  );
	
end
endgenerate

always @ (posedge clk)
begin
	if (~resetn || new_frame_start)
	// Reset all registers after frame is done or at the very beginning
	begin
		row_idx <= 0;
		col_idx <= 0;
		frame_done <= 0;
		ref_row_idx <= 0;
		ref_col_idx <= 0;
		pixel_done <= 1;
		frame_done <= 0;
		write_enable <= 0;
		last_col_index <= 0;
		write_address <= 0;
		offset <= 0;
		blk_idx <= 0;
	end
	
	/*
	// Write to memory phase
	if (write_enable && ~frame_done)
	begin
		if (offset == 32)
		begin
			write_enable <= 0;
			frame_done <= 1;
		end
		else
		begin
			write_address <= write_address + offset;
			write_data[8:0] <= ref_row_idx [(blk_idx*8)+7:blk_idx*8] << 1;
			write_data[18:9] <= ref_col_idx [(blk_idx*9)+8:blk_idx*9] << 1;
			offset <= offset + 4;
		end
	end
	*/
	
	/*
	if (last_col_idx)
	begin
		row_idx <= row_idx + 1;
		col_idx <= 0;
	end
	*/
	RGB_valid_stage1 <= valid_data;
	RGB_valid_stage2 <= RGB_valid_stage1;
	
	if (RGB_valid_stage2)
	begin
		if (result == 0)	// It is a part of a new block
		begin
			write_enable <= 1;
			write_address <= write_address + offset;
			write_data[8:0] <= row_idx << 1;
			write_data[18:9] <= col_idx << 1;
			offset <= offset + 8;
			blk_idx <= blk_idx + 1;
			if (blk_idx == 0)
			begin
                ref_row_idx [7:0] <= row_idx;
                ref_col_idx [8:0] <= col_idx;
			end
			else if (blk_idx == 1)
			begin
                ref_row_idx [15:8] <= row_idx;
                ref_col_idx [17:9] <= col_idx;
			end
            else if (blk_idx == 2)
            begin
                ref_row_idx [23:16] <= row_idx;
                ref_col_idx [26:18] <= col_idx;
            end
            else if (blk_idx == 3)
            begin
                ref_row_idx [31:24] <= row_idx;
                ref_col_idx [35:27] <= col_idx;
            end
            else if (blk_idx == 4)
            begin
                ref_row_idx [39:32] <= row_idx;
                ref_col_idx [44:36] <= col_idx;
            end
            else if (blk_idx == 5)
            begin
                ref_row_idx [47:40] <= row_idx;
                ref_col_idx [53:45] <= col_idx;
            end
            else if (blk_idx == 6)
            begin
                ref_row_idx [55:48] <= row_idx;
                ref_col_idx [62:54] <= col_idx;
            end
            else if (blk_idx == 7)
            begin
                ref_row_idx [63:56] <= row_idx;
                ref_col_idx [71:63] <= col_idx;
            end
		end
		else
			write_enable <= 0;
	end
	else
		write_enable <= 0;
	
	if (valid)
	begin
		if (curr_col_end)
		begin
			col_idx <= 0;
			row_idx <= row_idx + 1;
		end
		else
		begin
			col_idx <= col_idx + 1;
		end
	end
	/*
	if (valid)							
	begin
		pixel_done <= 1;
		
		if (curr_col_end)
		begin
			last_col_index <= 0;
		end
		else
		begin
			last_col_index <= 1;
		end
		
		col_idx <= col_idx + 1;
		if (valid_data)
		begin
			
		end
	end
	*/
end

endmodule

module block ( 
				input [8:0] col_idx,
				input [7:0] row_idx,
				input [8:0] ref_col_idx,
				input [7:0] ref_row_idx,
				output result
			  );
			  
localparam PRECISION = 60;
// result = 1 means the pixel is a part of the block
assign result = (ref_row_idx == 0 && ref_col_idx ==0) ? 0 : 
				((row_idx - ref_row_idx < PRECISION) &&
				(col_idx - ref_col_idx < PRECISION || ref_col_idx - col_idx < PRECISION)
				? 1 : 0);
endmodule