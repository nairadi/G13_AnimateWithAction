`timescale 1ns / 1ps

module pmod_cam (
                input                   pclk,
                input                   vsync,
                input                   href,
                input       [7:0]       din,
                output reg              pclk_out,
                output reg              data_valid,
                output reg  [15:0]      dout
                );
                        
    reg     [1:0]   wr_hold;
    reg     [1:0]   href_latch;
    reg     [15:0]  d_latch;
    
    initial
    begin
        wr_hold <= 2'b0;
        d_latch <= 16'b0;
        dout <= 16'b0;
        pclk_out <= 1'b0;
        href_latch <= 2'b0;
        data_valid <= 0;
    end
    
    always @ (posedge pclk)
    begin 
        if (vsync == 1)
        begin
            wr_hold <= 2'b0;
            dout <= 16'b0;
            d_latch <= 16'b0;
            href_latch <= 2'b0;
            data_valid <= 0;
        end
        else
        begin
            wr_hold <= {wr_hold[0], (href && (!wr_hold[0]))};
            d_latch <= {d_latch[7:0], din[7:0]};
            href_latch <= {href_latch[0], href};
            data_valid <= href_latch[1];
            
            if (wr_hold[1] == 1)
            begin
                dout <= d_latch;
            end
        end
    end
    
    always @ (negedge pclk)
    begin
        pclk_out = !pclk_out;
    end
endmodule

