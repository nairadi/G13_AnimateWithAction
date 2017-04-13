`timescale 1ns / 1ps

module vga640x480(
	input wire clk25,			//pixel clock: 25MHz
	input wire aresetn,			//asynchronous reset
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [3:0] red,	//red vga output
	output reg [3:0] green, //green vga output
	output reg [3:0] blue,	//blue vga output
	output reg [18:0] address,
	input wire [11:0] pixel_data,
    output reg tready,
    output reg fsync,
    input draw
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

reg [9:0] hc;
reg [9:0] vc;

always @(posedge clk25)
begin
	// reset condition
	if ((~aresetn) | (~draw))
	begin
		hc <= 0;
		vc <= 0;
		address <= 0;
	end
	else
	begin
		if (hc < hpixels - 1)
		begin
			hc <= hc + 1;
			if ((hc >= (hbp-1)) && (hc < (hfp-2)))
			begin
			    address <= address + 1;
			end
	    end
		else
		begin
			hc <= 0;
			if (vc < vlines - 1)
			begin
				vc <= vc + 1;
				if ((vc >= (vbp-1)) && (vc < (vfp-2)))
				begin
                    address <= address + 1;
                end
		    end
			else
			begin
				vc <= 0;
                address <= 0;
		    end
		end
		
	end
end

assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

always @(*)
begin
	if ((vc >= vbp) && (vc < vfp))
	begin
		if ((hc >= hbp) && (hc < hfp))
		begin
			red = pixel_data[11:8];
			green = pixel_data[7:4];
			blue = pixel_data[3:0];
			tready = 1;
		end
		else
		begin
			red = 0;
			green = 0;
			blue = 0;
			tready = 0;
		end
	end
	else
	begin
		red = 0;
		green = 0;
		blue = 0;
		tready = 0;
	end
end

reg vsync_last;

always@ (posedge clk25)
begin
    if ((~aresetn) | (~draw))
    begin
        vsync_last <= 0;
        fsync <= 0;
    end
    else
    begin
        vsync_last <= vsync;
        if (~vsync_last & vsync)
        begin
            fsync <= 1;
        end
        else
        begin
            fsync <= 0;
        end
    end
end

endmodule
