
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
}


# CHANGE DESIGN NAME HERE
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB

  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -from 0 -to 0 -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 lmb_bram ]
  set_property -dict [ list \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set uart_rtl [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_rtl ]

  # Create ports
  set LEDS [ create_bd_port -dir O -from 7 -to 0 LEDS ]
  set OV7670_D [ create_bd_port -dir I -from 7 -to 0 OV7670_D ]
  set OV7670_HREF [ create_bd_port -dir I OV7670_HREF ]
  set OV7670_PCLK [ create_bd_port -dir I OV7670_PCLK ]
  set OV7670_RESET [ create_bd_port -dir O OV7670_RESET ]
  set OV7670_SIOC [ create_bd_port -dir O OV7670_SIOC ]
  set OV7670_SIOD [ create_bd_port -dir IO OV7670_SIOD ]
  set OV7670_VSYNC [ create_bd_port -dir I OV7670_VSYNC ]
  set OV7670_XCLK [ create_bd_port -dir O OV7670_XCLK ]
  set clk [ create_bd_port -dir I -type clk clk ]
  set config_done [ create_bd_port -dir O config_done ]
  set hsyn [ create_bd_port -dir O hsyn ]
  set pwdn [ create_bd_port -dir O pwdn ]
  set reset_rtl [ create_bd_port -dir I -type rst reset_rtl ]
  set_property -dict [ list \
CONFIG.POLARITY {ACTIVE_LOW} \
 ] $reset_rtl
  set resetn [ create_bd_port -dir I -type rst resetn ]
  set vga444_blue [ create_bd_port -dir O -from 3 -to 0 vga444_blue ]
  set vga444_green [ create_bd_port -dir O -from 3 -to 0 vga444_green ]
  set vga444_red [ create_bd_port -dir O -from 3 -to 0 vga444_red ]
  set vga_hsync [ create_bd_port -dir O vga_hsync ]
  set vga_vsync [ create_bd_port -dir O vga_vsync ]
  set vsyn [ create_bd_port -dir O vsyn ]

  # Create instance: IPU_wrapper_0, and set properties
  set IPU_wrapper_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:IPU_wrapper:1.0 IPU_wrapper_0 ]

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0 ]
  set_property -dict [ list \
CONFIG.DATA_WIDTH {64} \
CONFIG.ECC_TYPE {0} \
CONFIG.PROTOCOL {AXI4} \
CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $axi_uartlite_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $axi_uartlite_0

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_0 ]
  set_property -dict [ list \
CONFIG.Assume_Synchronous_Clk {true} \
CONFIG.Byte_Size {8} \
CONFIG.Enable_32bit_Address {true} \
CONFIG.Enable_B {Use_ENB_Pin} \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.Operating_Mode_A {WRITE_FIRST} \
CONFIG.Operating_Mode_B {WRITE_FIRST} \
CONFIG.Port_B_Clock {100} \
CONFIG.Port_B_Enable_Rate {100} \
CONFIG.Port_B_Write_Rate {50} \
CONFIG.Read_Width_A {64} \
CONFIG.Read_Width_B {64} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
CONFIG.Use_Byte_Write_Enable {true} \
CONFIG.Use_RSTA_Pin {true} \
CONFIG.Use_RSTB_Pin {true} \
CONFIG.Write_Depth_A {4} \
CONFIG.Write_Width_A {64} \
CONFIG.Write_Width_B {64} \
CONFIG.use_bram_block {BRAM_Controller} \
 ] $blk_mem_gen_0

  # Create instance: blk_mem_gen_1, and set properties
  set blk_mem_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_1 ]
  set_property -dict [ list \
CONFIG.Byte_Size {9} \
CONFIG.Enable_32bit_Address {false} \
CONFIG.Enable_B {Use_ENB_Pin} \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.Port_B_Clock {100} \
CONFIG.Port_B_Enable_Rate {100} \
CONFIG.Port_B_Write_Rate {50} \
CONFIG.Read_Width_A {12} \
CONFIG.Read_Width_B {12} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
CONFIG.Register_PortB_Output_of_Memory_Primitives {true} \
CONFIG.Use_Byte_Write_Enable {false} \
CONFIG.Use_RSTA_Pin {false} \
CONFIG.Write_Depth_A {307200} \
CONFIG.Write_Width_A {12} \
CONFIG.Write_Width_B {12} \
CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_1

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.3 clk_wiz_0 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_JITTER {130.958} \
CONFIG.CLKOUT1_PHASE_ERROR {98.575} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {100} \
CONFIG.CLKOUT2_JITTER {175.402} \
CONFIG.CLKOUT2_PHASE_ERROR {98.575} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {25} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.MMCM_CLKFBOUT_MULT_F {10.000} \
CONFIG.MMCM_CLKIN1_PERIOD {10.0} \
CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {10.000} \
CONFIG.MMCM_CLKOUT1_DIVIDE {40} \
CONFIG.MMCM_COMPENSATION {ZHOLD} \
CONFIG.MMCM_DIVCLK_DIVIDE {1} \
CONFIG.NUM_OUT_CLKS {2} \
CONFIG.RESET_PORT {resetn} \
CONFIG.RESET_TYPE {ACTIVE_LOW} \
 ] $clk_wiz_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.MMCM_CLKIN1_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKIN2_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_COMPENSATION.VALUE_SRC {DEFAULT} \
 ] $clk_wiz_0

  # Create instance: comm_0, and set properties
  set comm_0 [ create_bd_cell -type ip -vlnv utoronto.ca:user:comm:1.0 comm_0 ]

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:9.6 microblaze_0 ]
  set_property -dict [ list \
CONFIG.C_DEBUG_ENABLED {1} \
CONFIG.C_D_AXI {1} \
CONFIG.C_D_LMB {1} \
CONFIG.C_I_LMB {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
CONFIG.C_HAS_FAST {1} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {4} \
CONFIG.NUM_SI {1} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: microblaze_0_xlconcat, and set properties
  set microblaze_0_xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 microblaze_0_xlconcat ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {1} \
 ] $microblaze_0_xlconcat

  # Create instance: rst_clk_wiz_0_50M, and set properties
  set rst_clk_wiz_0_50M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_0_50M ]

  # Create instance: v_vid_in_axi4s_0, and set properties
  set v_vid_in_axi4s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:4.0 v_vid_in_axi4s_0 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {11} \
CONFIG.C_HAS_ASYNC_CLK {1} \
CONFIG.C_M_AXIS_VIDEO_FORMAT {0} \
CONFIG.C_NATIVE_COMPONENT_WIDTH {8} \
 ] $v_vid_in_axi4s_0

  # Create instance: vga_ip_0, and set properties
  set vga_ip_0 [ create_bd_cell -type ip -vlnv utoronto.ca:user:vga_ip:1.0 vga_ip_0 ]

  # Create instance: video_in_0, and set properties
  set video_in_0 [ create_bd_cell -type ip -vlnv utoronto.ca:user:video_in:1.0 video_in_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports uart_rtl] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net microblaze_0_axi_dp [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins comm_0/S00_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_intc_axi [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]

  # Create port connections
  connect_bd_net -net IPU_wrapper_0_m_axis_video_tready [get_bd_pins IPU_wrapper_0/m_axis_video_tready] [get_bd_pins v_vid_in_axi4s_0/m_axis_video_tready]
  connect_bd_net -net IPU_wrapper_0_write_to_mem_addr [get_bd_pins IPU_wrapper_0/write_to_mem_addr] [get_bd_pins blk_mem_gen_0/addra]
  connect_bd_net -net IPU_wrapper_0_write_to_mem_data [get_bd_pins IPU_wrapper_0/write_to_mem_data] [get_bd_pins blk_mem_gen_0/dina]
  connect_bd_net -net IPU_wrapper_0_write_to_mem_en [get_bd_pins IPU_wrapper_0/write_to_mem_en] [get_bd_pins blk_mem_gen_0/ena] [get_bd_pins blk_mem_gen_0/wea]
  connect_bd_net -net Net [get_bd_ports OV7670_SIOD] [get_bd_pins video_in_0/OV7670_SIOD]
  connect_bd_net -net OV7670_D_1 [get_bd_ports OV7670_D] [get_bd_pins video_in_0/OV7670_D]
  connect_bd_net -net OV7670_HREF_1 [get_bd_ports OV7670_HREF] [get_bd_ports hsyn] [get_bd_pins video_in_0/OV7670_HREF]
  connect_bd_net -net OV7670_PCLK_1 [get_bd_ports OV7670_PCLK] [get_bd_pins video_in_0/OV7670_PCLK]
  connect_bd_net -net OV7670_VSYNC_1 [get_bd_ports OV7670_VSYNC] [get_bd_ports vsyn] [get_bd_pins video_in_0/OV7670_VSYNC]
  connect_bd_net -net axi_uartlite_0_interrupt [get_bd_pins axi_uartlite_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In0]
  connect_bd_net -net blk_mem_gen_1_doutb [get_bd_pins blk_mem_gen_1/doutb] [get_bd_pins vga_ip_0/pixel_data]
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins vga_ip_0/clk25] [get_bd_pins video_in_0/clk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins rst_clk_wiz_0_50M/dcm_locked]
  connect_bd_net -net col_idx [get_bd_pins IPU_wrapper_0/col_idx]
  connect_bd_net -net comm_0_addra [get_bd_pins blk_mem_gen_1/addra] [get_bd_pins comm_0/addra]
  connect_bd_net -net comm_0_dina [get_bd_pins blk_mem_gen_1/dina] [get_bd_pins comm_0/dina]
  connect_bd_net -net comm_0_dinb [get_bd_pins blk_mem_gen_1/dinb] [get_bd_pins comm_0/dinb]
  connect_bd_net -net comm_0_draw [get_bd_pins comm_0/draw] [get_bd_pins vga_ip_0/draw]
  connect_bd_net -net comm_0_ena [get_bd_pins blk_mem_gen_1/ena] [get_bd_pins comm_0/ena]
  connect_bd_net -net comm_0_enb [get_bd_pins blk_mem_gen_1/enb] [get_bd_pins comm_0/enb]
  connect_bd_net -net comm_0_wea [get_bd_pins blk_mem_gen_1/wea] [get_bd_pins comm_0/wea]
  connect_bd_net -net comm_0_web [get_bd_pins blk_mem_gen_1/web] [get_bd_pins comm_0/web]
  connect_bd_net -net enable_comparison [get_bd_pins IPU_wrapper_0/enable_comparison]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_clk_wiz_0_50M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins blk_mem_gen_0/clka] [get_bd_pins blk_mem_gen_1/clkb] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins comm_0/s00_axi_aclk] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rst_clk_wiz_0_50M/slowest_sync_clk]
  connect_bd_net -net microblaze_0_intr [get_bd_pins microblaze_0_axi_intc/intr] [get_bd_pins microblaze_0_xlconcat/dout]
  connect_bd_net -net reset_rtl_1 [get_bd_ports reset_rtl] [get_bd_pins rst_clk_wiz_0_50M/ext_reset_in]
  connect_bd_net -net resetn_1 [get_bd_ports resetn] [get_bd_pins clk_wiz_0/resetn]
  connect_bd_net -net rst_clk_wiz_0_50M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_clk_wiz_0_50M/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_0_50M_interconnect_aresetn [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins rst_clk_wiz_0_50M/interconnect_aresetn]
  connect_bd_net -net rst_clk_wiz_0_50M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst] [get_bd_pins rst_clk_wiz_0_50M/mb_reset]
  connect_bd_net -net rst_clk_wiz_0_50M_peripheral_aresetn [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins comm_0/s00_axi_aresetn] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins rst_clk_wiz_0_50M/peripheral_aresetn] [get_bd_pins vga_ip_0/aresetn] [get_bd_pins video_in_0/resetn]
  connect_bd_net -net v_vid_in_axi4s_0_m_axis_video_tdata [get_bd_pins IPU_wrapper_0/m_axis_video_tdata] [get_bd_pins v_vid_in_axi4s_0/m_axis_video_tdata]
  connect_bd_net -net v_vid_in_axi4s_0_m_axis_video_tlast [get_bd_pins IPU_wrapper_0/m_axis_video_tlast] [get_bd_pins v_vid_in_axi4s_0/m_axis_video_tlast]
  connect_bd_net -net v_vid_in_axi4s_0_m_axis_video_tuser [get_bd_pins IPU_wrapper_0/m_axis_video_tuser] [get_bd_pins v_vid_in_axi4s_0/m_axis_video_tuser]
  connect_bd_net -net v_vid_in_axi4s_0_m_axis_video_tvalid [get_bd_pins IPU_wrapper_0/valid] [get_bd_pins v_vid_in_axi4s_0/m_axis_video_tvalid]
  connect_bd_net -net vga_ip_0_address [get_bd_pins blk_mem_gen_1/addrb] [get_bd_pins vga_ip_0/address]
  connect_bd_net -net vga_ip_0_blue [get_bd_ports vga444_blue] [get_bd_pins vga_ip_0/blue]
  connect_bd_net -net vga_ip_0_fsync [get_bd_pins comm_0/done] [get_bd_pins vga_ip_0/fsync]
  connect_bd_net -net vga_ip_0_green [get_bd_ports vga444_green] [get_bd_pins vga_ip_0/green]
  connect_bd_net -net vga_ip_0_hsync [get_bd_ports vga_hsync] [get_bd_pins vga_ip_0/hsync]
  connect_bd_net -net vga_ip_0_red [get_bd_ports vga444_red] [get_bd_pins vga_ip_0/red]
  connect_bd_net -net vga_ip_0_vsync [get_bd_ports vga_vsync] [get_bd_pins vga_ip_0/vsync]
  connect_bd_net -net video_in_0_LEDS [get_bd_ports LEDS] [get_bd_pins video_in_0/LEDS]
  connect_bd_net -net video_in_0_OV7670_SIOC [get_bd_ports OV7670_SIOC] [get_bd_pins video_in_0/OV7670_SIOC]
  connect_bd_net -net video_in_0_OV7670_XCLK [get_bd_ports OV7670_XCLK] [get_bd_pins video_in_0/OV7670_XCLK]
  connect_bd_net -net video_in_0_aclk [get_bd_pins IPU_wrapper_0/aclk] [get_bd_pins blk_mem_gen_1/clka] [get_bd_pins v_vid_in_axi4s_0/aclk] [get_bd_pins video_in_0/aclk]
  connect_bd_net -net video_in_0_aclken [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins video_in_0/aclken]
  connect_bd_net -net video_in_0_aresetn [get_bd_pins IPU_wrapper_0/aresetn] [get_bd_pins blk_mem_gen_0/rsta] [get_bd_pins v_vid_in_axi4s_0/aresetn] [get_bd_pins video_in_0/aresetn]
  connect_bd_net -net video_in_0_axis_enable [get_bd_ports OV7670_RESET] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins video_in_0/axis_enable]
  connect_bd_net -net video_in_0_config_done [get_bd_ports config_done] [get_bd_pins video_in_0/config_done]
  connect_bd_net -net video_in_0_pwdn [get_bd_ports pwdn] [get_bd_pins video_in_0/pwdn]
  connect_bd_net -net video_in_0_vid_active_video [get_bd_pins v_vid_in_axi4s_0/vid_active_video] [get_bd_pins video_in_0/vid_active_video]
  connect_bd_net -net video_in_0_vid_data [get_bd_pins v_vid_in_axi4s_0/vid_data] [get_bd_pins video_in_0/vid_data]
  connect_bd_net -net video_in_0_vid_field_id [get_bd_pins v_vid_in_axi4s_0/vid_field_id] [get_bd_pins video_in_0/vid_field_id]
  connect_bd_net -net video_in_0_vid_hblank [get_bd_pins v_vid_in_axi4s_0/vid_hblank] [get_bd_pins video_in_0/vid_hblank]
  connect_bd_net -net video_in_0_vid_hsync [get_bd_pins v_vid_in_axi4s_0/vid_hsync] [get_bd_pins video_in_0/vid_hsync]
  connect_bd_net -net video_in_0_vid_io_in_ce [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce] [get_bd_pins video_in_0/vid_io_in_ce]
  connect_bd_net -net video_in_0_vid_io_in_clk [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk] [get_bd_pins video_in_0/vid_io_in_clk]
  connect_bd_net -net video_in_0_vid_io_in_reset [get_bd_pins v_vid_in_axi4s_0/vid_io_in_reset] [get_bd_pins video_in_0/vid_io_in_reset]
  connect_bd_net -net video_in_0_vid_vblank [get_bd_pins v_vid_in_axi4s_0/vid_vblank] [get_bd_pins video_in_0/vid_vblank]
  connect_bd_net -net video_in_0_vid_vsync [get_bd_pins v_vid_in_axi4s_0/vid_vsync] [get_bd_pins video_in_0/vid_vsync]

  # Create address segments
  create_bd_addr_seg -range 0x00002000 -offset 0xC0000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs comm_0/S00_AXI/S00_AXI_reg] SEG_comm_0_S00_AXI_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00008000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_axi_intc/S_AXI/Reg] SEG_microblaze_0_axi_intc_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port vga_hsync -pg 1 -y 690 -defaultsOSRD
preplace port uart_rtl -pg 1 -y 1040 -defaultsOSRD
preplace port OV7670_RESET -pg 1 -y 250 -defaultsOSRD
preplace port pwdn -pg 1 -y 630 -defaultsOSRD
preplace port OV7670_XCLK -pg 1 -y 390 -defaultsOSRD
preplace port OV7670_HREF -pg 1 -y 230 -defaultsOSRD
preplace port OV7670_VSYNC -pg 1 -y 210 -defaultsOSRD
preplace port reset_rtl -pg 1 -y 950 -defaultsOSRD
preplace port OV7670_SIOC -pg 1 -y 60 -defaultsOSRD
preplace port resetn -pg 1 -y 1010 -defaultsOSRD
preplace port OV7670_SIOD -pg 1 -y 40 -defaultsOSRD
preplace port vsyn -pg 1 -y 670 -defaultsOSRD
preplace port OV7670_PCLK -pg 1 -y 250 -defaultsOSRD
preplace port hsyn -pg 1 -y 610 -defaultsOSRD
preplace port config_done -pg 1 -y 120 -defaultsOSRD
preplace port clk -pg 1 -y 1030 -defaultsOSRD
preplace port vga_vsync -pg 1 -y 710 -defaultsOSRD
preplace portBus vga444_blue -pg 1 -y 770 -defaultsOSRD
preplace portBus vga444_red -pg 1 -y 730 -defaultsOSRD
preplace portBus OV7670_D -pg 1 -y 270 -defaultsOSRD
preplace portBus LEDS -pg 1 -y 410 -defaultsOSRD
preplace portBus vga444_green -pg 1 -y 750 -defaultsOSRD
preplace inst IPU_wrapper_0 -pg 1 -lvl 6 -y 180 -defaultsOSRD
preplace inst microblaze_0_axi_periph -pg 1 -lvl 5 -y 880 -defaultsOSRD
preplace inst comm_0 -pg 1 -lvl 6 -y 460 -defaultsOSRD
preplace inst microblaze_0_xlconcat -pg 1 -lvl 2 -y 1200 -defaultsOSRD
preplace inst blk_mem_gen_0 -pg 1 -lvl 7 -y 510 -defaultsOSRD
preplace inst vga_ip_0 -pg 1 -lvl 6 -y 760 -defaultsOSRD
preplace inst blk_mem_gen_1 -pg 1 -lvl 7 -y 200 -defaultsOSRD
preplace inst mdm_1 -pg 1 -lvl 3 -y 970 -defaultsOSRD
preplace inst microblaze_0_axi_intc -pg 1 -lvl 3 -y 1190 -defaultsOSRD
preplace inst video_in_0 -pg 1 -lvl 4 -y 220 -defaultsOSRD
preplace inst v_vid_in_axi4s_0 -pg 1 -lvl 5 -y 240 -defaultsOSRD
preplace inst axi_uartlite_0 -pg 1 -lvl 6 -y 1050 -defaultsOSRD
preplace inst microblaze_0 -pg 1 -lvl 4 -y 970 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 1 -y 1020 -defaultsOSRD
preplace inst axi_bram_ctrl_0 -pg 1 -lvl 6 -y 930 -defaultsOSRD
preplace inst microblaze_0_local_memory -pg 1 -lvl 5 -y 1160 -defaultsOSRD
preplace inst rst_clk_wiz_0_50M -pg 1 -lvl 2 -y 1000 -defaultsOSRD
preplace netloc microblaze_0_axi_periph_M02_AXI 1 5 1 1810
preplace netloc rst_clk_wiz_0_50M_bus_struct_reset 1 2 3 NJ 1060 NJ 1060 NJ
preplace netloc comm_0_addra 1 6 1 2310
preplace netloc OV7670_PCLK_1 1 0 4 NJ 250 NJ 250 NJ 250 NJ
preplace netloc microblaze_0_axi_periph_M03_AXI 1 5 1 N
preplace netloc microblaze_0_axi_periph_M01_AXI 1 5 1 1780
preplace netloc video_in_0_pwdn 1 4 4 NJ 630 NJ 630 NJ 630 NJ
preplace netloc col_idx 1 6 1 N
preplace netloc IPU_wrapper_0_m_axis_video_tready 1 5 1 1810
preplace netloc OV7670_HREF_1 1 0 8 NJ 230 NJ 230 NJ 230 810 -40 NJ -40 NJ -40 NJ -40 NJ
preplace netloc microblaze_0_intc_axi 1 2 4 580 680 NJ 680 NJ 680 1780
preplace netloc microblaze_0_dlmb_1 1 4 1 1350
preplace netloc comm_0_ena 1 6 1 2330
preplace netloc video_in_0_config_done 1 4 4 NJ 0 NJ 0 NJ 0 NJ
preplace netloc video_in_0_vid_io_in_ce 1 4 1 1390
preplace netloc video_in_0_vid_vsync 1 4 1 1370
preplace netloc video_in_0_aclken 1 4 1 1390
preplace netloc comm_0_enb 1 6 1 2410
preplace netloc rst_clk_wiz_0_50M_peripheral_aresetn 1 2 4 560 690 840 690 1360 690 1840
preplace netloc comm_0_dina 1 6 1 2320
preplace netloc vga_ip_0_fsync 1 5 2 1860 330 2300
preplace netloc comm_0_dinb 1 6 1 2380
preplace netloc v_vid_in_axi4s_0_m_axis_video_tdata 1 5 1 1780
preplace netloc video_in_0_vid_vblank 1 4 1 1390
preplace netloc vga_ip_0_green 1 6 2 NJ 750 NJ
preplace netloc vga_ip_0_hsync 1 6 2 NJ 690 NJ
preplace netloc v_vid_in_axi4s_0_m_axis_video_tlast 1 5 1 1790
preplace netloc video_in_0_LEDS 1 4 4 NJ 430 NJ 310 NJ 380 NJ
preplace netloc microblaze_0_ilmb_1 1 4 1 1320
preplace netloc microblaze_0_interrupt 1 3 1 820
preplace netloc mdm_1_debug_sys_rst 1 1 3 210 1090 NJ 1090 810
preplace netloc enable_comparison 1 6 1 N
preplace netloc vga_ip_0_vsync 1 6 2 NJ 710 NJ
preplace netloc vga_ip_0_blue 1 6 2 NJ 770 NJ
preplace netloc axi_bram_ctrl_0_BRAM_PORTA 1 6 1 2450
preplace netloc blk_mem_gen_1_doutb 1 5 2 1850 300 NJ
preplace netloc axi_uartlite_0_UART 1 6 2 NJ 1040 NJ
preplace netloc reset_rtl_1 1 0 2 NJ 950 NJ
preplace netloc resetn_1 1 0 1 NJ
preplace netloc video_in_0_axis_enable 1 4 4 1330 -20 NJ -20 NJ -20 2710
preplace netloc video_in_0_vid_io_in_reset 1 4 1 1390
preplace netloc OV7670_VSYNC_1 1 0 8 NJ 210 NJ 210 NJ 210 820 -30 NJ -30 NJ -30 NJ -30 NJ
preplace netloc microblaze_0_Clk 1 1 6 200 1100 570 1050 840 1050 1390 700 1830 590 2430
preplace netloc OV7670_D_1 1 0 4 NJ 270 NJ 270 NJ 270 N
preplace netloc video_in_0_OV7670_SIOC 1 4 4 NJ 40 NJ 40 NJ 10 NJ
preplace netloc video_in_0_vid_active_video 1 4 1 1310
preplace netloc video_in_0_vid_io_in_clk 1 4 1 1370
preplace netloc Net 1 4 4 NJ 20 NJ 20 NJ 20 NJ
preplace netloc IPU_wrapper_0_write_to_mem_en 1 6 1 2360
preplace netloc rst_clk_wiz_0_50M_interconnect_aresetn 1 2 3 NJ 800 NJ 800 NJ
preplace netloc video_in_0_vid_hblank 1 4 1 1300
preplace netloc IPU_wrapper_0_write_to_mem_addr 1 6 1 2400
preplace netloc vga_ip_0_address 1 6 1 2420
preplace netloc microblaze_0_debug 1 3 1 N
preplace netloc v_vid_in_axi4s_0_m_axis_video_tvalid 1 5 1 1810
preplace netloc microblaze_0_axi_dp 1 4 1 1380
preplace netloc video_in_0_aresetn 1 4 3 1390 450 1820 580 NJ
preplace netloc clk_wiz_0_locked 1 1 1 N
preplace netloc comm_0_draw 1 5 2 1860 600 2290
preplace netloc comm_0_wea 1 6 1 2370
preplace netloc video_in_0_aclk 1 4 3 1360 50 1820 60 2360
preplace netloc comm_0_web 1 6 1 2440
preplace netloc vga_ip_0_red 1 6 2 NJ 730 NJ
preplace netloc video_in_0_vid_field_id 1 4 1 1390
preplace netloc video_in_0_vid_hsync 1 4 1 1350
preplace netloc axi_uartlite_0_interrupt 1 1 6 210 1290 NJ 1290 NJ 1290 NJ 1290 NJ 1290 2290
preplace netloc video_in_0_vid_data 1 4 1 1390
preplace netloc clk_wiz_0_clk_out2 1 1 5 NJ 670 NJ 670 830 670 NJ 670 NJ
preplace netloc video_in_0_OV7670_XCLK 1 4 4 NJ 440 NJ 340 NJ 390 NJ
preplace netloc microblaze_0_intr 1 2 1 NJ
preplace netloc clk_1 1 0 1 NJ
preplace netloc v_vid_in_axi4s_0_m_axis_video_tuser 1 5 1 1800
preplace netloc rst_clk_wiz_0_50M_mb_reset 1 2 2 530 1030 NJ
preplace netloc IPU_wrapper_0_write_to_mem_data 1 6 1 2350
levelinfo -pg 1 0 100 370 700 1080 1610 2100 2560 2750 -top -50 -bot 1300
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


