connect -url tcp:127.0.0.1:3121
source C:/pruebas/Sepsa_full_bridge_comunicacion/IP_pspwm.sdk/Pspwm_wrapper_hw_platform_0/ps7_init.tcl
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zybo 210279759344A"} -index 0
loadhw C:/pruebas/Sepsa_full_bridge_comunicacion/IP_pspwm.sdk/Pspwm_wrapper_hw_platform_0/system.hdf
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zybo 210279759344A"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zybo 210279759344A"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zybo 210279759344A"} -index 0
dow C:/pruebas/Sepsa_full_bridge_comunicacion/IP_pspwm.sdk/Comunicacion1_bsp_xuartps_polled_example_1/Debug/Comunicacion1_bsp_xuartps_polled_example_1.elf
bpadd -addr &main
