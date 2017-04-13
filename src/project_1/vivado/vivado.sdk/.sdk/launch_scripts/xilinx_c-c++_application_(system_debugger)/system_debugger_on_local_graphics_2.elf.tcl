connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Nexys4DDR 210292646183A"} -index 0
loadhw W:/ECE532/New1/project_1_1/project_1/vivado/vivado.sdk/design_1_wrapper_hw_platform_2/system.hdf
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Nexys4DDR 210292646183A"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Nexys4DDR 210292646183A"} -index 0
dow W:/ECE532/New1/project_1_1/project_1/vivado/vivado.sdk/graphics_2/Debug/graphics_2.elf
bpadd -addr &main
