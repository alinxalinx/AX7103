set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
############## clock define##################
create_clock -period 5 [get_ports sys_clk_p]
set_property PACKAGE_PIN R4 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]

##############reset key define##################
set_property PACKAGE_PIN T6 [get_ports RSTn]
set_property IOSTANDARD LVCMOS15 [get_ports RSTn]


############## USB define##################
set_property IOSTANDARD LVCMOS33 [get_ports SCL]
set_property PACKAGE_PIN F13 [get_ports SCL]

set_property IOSTANDARD LVCMOS33 [get_ports SDA]
set_property PACKAGE_PIN E14 [get_ports SDA]





