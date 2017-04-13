 
 module IPU_wrapper (
						input [15:0] m_axis_video_tdata,
						input aclk,
						input m_axis_video_tlast,
						input valid,
						input m_axis_video_tuser,
						input aresetn,
						
						output m_axis_video_tready,
						output write_to_mem_en,
						output [31:0] write_to_mem_addr,
						output [63:0] write_to_mem_data,
						
						// For testing only, to be deleted later
						output [8:0] row_idx,
						output [9:0] col_idx,
						output enable_comparison,
						output block_updated
					);
					
wire pixel_done, frame_done, legal_pixel;						
assign m_axis_video_tready = 1'b1;
assign legal_pixel = (valid && (((m_axis_video_tdata[7:4] < 9) && (m_axis_video_tdata[11:8] > 9) && (m_axis_video_tdata[3:0] < 9)) && ((m_axis_video_tdata[7:4] - m_axis_video_tdata[3:0] < 2) || (m_axis_video_tdata[3:0] - m_axis_video_tdata[7:4] < 2)))) ? 1 : 0;

IPU_core _IPU  (
					  .clk(aclk),
					  .resetn(aresetn),
					  .frame_data(m_axis_video_tdata[15:0]),
					  .valid(valid),
					  .new_frame_start(m_axis_video_tuser),
					  .curr_col_end(m_axis_video_tlast),
					  .valid_data(legal_pixel),
					  
					  .pixel_done(pixel_done),
					  .frame_done(frame_done),
					  .write_address(write_to_mem_addr),
					  .write_data(write_to_mem_data),
					  .write_enable(write_to_mem_en),
					  
					  .row_idx(row_idx),
                      .col_idx(col_idx),
                      .enable_comparison(enable_comparison),
                      .block_updated(block_updated)
					 );
endmodule