set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
############## clock define##################
create_clock -period 5 [get_ports sys_clk_p]
set_property PACKAGE_PIN R4 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]

##############reset key define##################
set_property PACKAGE_PIN T6 [get_ports rst_n]
set_property IOSTANDARD LVCMOS15 [get_ports rst_n]


############## SD define##################
set_property IOSTANDARD LVCMOS33 [get_ports SD_clk]
set_property PACKAGE_PIN AB12 [get_ports SD_clk]

set_property IOSTANDARD LVCMOS33 [get_ports SD_cs]
set_property PACKAGE_PIN AA14 [get_ports SD_cs]

set_property IOSTANDARD LVCMOS33 [get_ports SD_datain]
set_property PACKAGE_PIN AB11 [get_ports SD_datain]

set_property IOSTANDARD LVCMOS33 [get_ports SD_dataout]
set_property PACKAGE_PIN AA13 [get_ports SD_dataout]



