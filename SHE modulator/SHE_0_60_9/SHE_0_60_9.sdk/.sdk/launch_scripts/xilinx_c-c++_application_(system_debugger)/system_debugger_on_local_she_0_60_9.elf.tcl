connect -url tcp:127.0.0.1:3121
source C:/Users/USUARIO/Desktop/TFG/Zybo/SHE_0_60_9/SHE_0_60_9.sdk/ZC702_hw_platform/ps7_init.tcl
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zybo 210279759344A"} -index 0
loadhw C:/Users/USUARIO/Desktop/TFG/Zybo/SHE_0_60_9/SHE_0_60_9.sdk/ZC702_hw_platform/system.hdf
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zybo 210279759344A"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zybo 210279759344A"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zybo 210279759344A"} -index 0
dow C:/Users/USUARIO/Desktop/TFG/Zybo/SHE_0_60_9/SHE_0_60_9.sdk/SHE_0_60_9/Debug/SHE_0_60_9.elf
bpadd -addr &main
