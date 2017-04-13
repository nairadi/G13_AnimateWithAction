@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 8e3c7ad6ff57454a8bca029b482c62eb -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L xpm -L fifo_generator_v13_0_3 -L v_vid_in_axi4s_v4_0_3 -L blk_mem_gen_v8_3_3 -L microblaze_v9_6_1 -L lmb_v10_v3_0_8 -L lmb_bram_if_cntlr_v4_0_9 -L axi_lite_ipif_v3_0_4 -L axi_intc_v4_1_7 -L mdm_v3_2_6 -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_9 -L lib_pkg_v1_0_2 -L lib_srl_fifo_v1_0_2 -L axi_uartlite_v2_0_13 -L generic_baseblocks_v2_1_0 -L axi_infrastructure_v1_1_0 -L axi_register_slice_v2_1_9 -L fifo_generator_v13_1_1 -L axi_data_fifo_v2_1_8 -L axi_crossbar_v2_1_10 -L axi_bram_ctrl_v4_0_8 -L axi_protocol_converter_v2_1_9 -L axi_clock_converter_v2_1_8 -L axi_dwidth_converter_v2_1_9 -L unisims_ver -L unimacro_ver -L secureip --snapshot video_in_tb_behav xil_defaultlib.video_in_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0