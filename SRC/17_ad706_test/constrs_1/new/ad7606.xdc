set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
############## clock define##################
create_clock -period 5 [get_ports sys_clk_p]
set_property PACKAGE_PIN R4 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]


##############reset key define##################
set_property PACKAGE_PIN T6 [get_ports rst_n]
set_property IOSTANDARD LVCMOS15 [get_ports rst_n]

############## AD7606 define##################
set_property PACKAGE_PIN W17 [get_ports {ad_os[2]}]
set_property PACKAGE_PIN W16 [get_ports {ad_os[1]}]
set_property PACKAGE_PIN W15 [get_ports {ad_os[0]}]
set_property PACKAGE_PIN V17 [get_ports {ad_convstab}]
set_property PACKAGE_PIN U15 [get_ports {ad_rd}]
set_property PACKAGE_PIN V15 [get_ports {ad_reset}]
set_property PACKAGE_PIN AB21 [get_ports {ad_busy}]
set_property PACKAGE_PIN AB22 [get_ports {ad_cs}]
set_property PACKAGE_PIN AA20 [get_ports {first_data}]
set_property PACKAGE_PIN AA18 [get_ports {ad_data[0]}]
set_property PACKAGE_PIN AB18 [get_ports {ad_data[1]}]
set_property PACKAGE_PIN T20 [get_ports {ad_data[2]}]
set_property PACKAGE_PIN Y17 [get_ports {ad_data[3]}]
set_property PACKAGE_PIN W22 [get_ports {ad_data[4]}]
set_property PACKAGE_PIN W21 [get_ports {ad_data[5]}]
set_property PACKAGE_PIN T21 [get_ports {ad_data[6]}]
set_property PACKAGE_PIN U21 [get_ports {ad_data[7]}]
set_property PACKAGE_PIN Y21 [get_ports {ad_data[8]}]
set_property PACKAGE_PIN Y22 [get_ports {ad_data[9]}]
set_property PACKAGE_PIN W20 [get_ports {ad_data[10]}]
set_property PACKAGE_PIN W19 [get_ports {ad_data[11]}]
set_property PACKAGE_PIN Y19 [get_ports {ad_data[12]}]
set_property PACKAGE_PIN Y18 [get_ports {ad_data[13]}]
set_property PACKAGE_PIN V22 [get_ports {ad_data[14]}]
set_property PACKAGE_PIN U22 [get_ports {ad_data[15]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ad_os[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_os[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_os[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_convstab}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_rd}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_busy}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_cs}]
set_property IOSTANDARD LVCMOS33 [get_ports {first_data}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[15]}]



############## usb uart define##################
set_property IOSTANDARD LVCMOS33 [get_ports rx]
set_property PACKAGE_PIN P20 [get_ports rx]

set_property IOSTANDARD LVCMOS33 [get_ports tx]
set_property PACKAGE_PIN N15 [get_ports tx]








