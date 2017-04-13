@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim video_in_tb_time_synth -key {Post-Synthesis:sim_1:Timing:video_in_tb} -tclbatch video_in_tb.tcl -view C:/Users/Tirthak/OneDrive/ECE532/project_1_1/project_1/vivado/video_in_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
