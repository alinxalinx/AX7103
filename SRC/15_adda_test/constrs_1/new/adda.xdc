set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
############## clock define##################
create_clock -period 5 [get_ports sys_clk_p]
set_property PACKAGE_PIN R4 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]


############## ADDA define##################
set_property PACKAGE_PIN V17 [get_ports {daclk}]
set_property PACKAGE_PIN W17 [get_ports {dadata[7]}]
set_property PACKAGE_PIN U15 [get_ports {dadata[6]}]
set_property PACKAGE_PIN V15 [get_ports {dadata[5]}]
set_property PACKAGE_PIN AB21 [get_ports {dadata[4]}]
set_property PACKAGE_PIN AB22 [get_ports {dadata[3]}]
set_property PACKAGE_PIN AA21 [get_ports {dadata[2]}]
set_property PACKAGE_PIN AA20 [get_ports {dadata[1]}]
set_property PACKAGE_PIN AB20 [get_ports {dadata[0]}]

set_property PACKAGE_PIN T21 [get_ports {addata[0]}]
set_property PACKAGE_PIN U21 [get_ports {addata[1]}]
set_property PACKAGE_PIN Y21 [get_ports {addata[2]}]
set_property PACKAGE_PIN Y22 [get_ports {addata[3]}]
set_property PACKAGE_PIN W20 [get_ports {addata[4]}]
set_property PACKAGE_PIN W19 [get_ports {addata[5]}]
set_property PACKAGE_PIN Y19 [get_ports {addata[6]}]
set_property PACKAGE_PIN Y18 [get_ports {addata[7]}]
set_property PACKAGE_PIN V22 [get_ports {adclk}]

set_property IOSTANDARD LVCMOS33 [get_ports {daclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {dadata[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dadata[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dadata[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dadata[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dadata[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dadata[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dadata[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dadata[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {addata[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {addata[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {addata[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {addata[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {addata[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {addata[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {addata[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {addata[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adclk}]




