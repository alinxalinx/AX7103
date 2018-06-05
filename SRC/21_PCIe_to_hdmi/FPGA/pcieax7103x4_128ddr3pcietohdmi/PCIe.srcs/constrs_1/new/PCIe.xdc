##-----------------------------------------------------------------------------
##
## (c) Copyright 2010-2011 Xilinx, Inc. All rights reserved.
##
## This file contains confidential and proprietary information
## of Xilinx, Inc. and is protected under U.S. and
## international copyright and other intellectual property
## laws.
##
## DISCLAIMER
## This disclaimer is not a license and does not grant any
## rights to the materials distributed herewith. Except as
## otherwise provided in a valid license issued to you by
## Xilinx, and to the maximum extent permitted by applicable
## law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
## WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
## AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
## BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
## INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
## (2) Xilinx shall not be liable (whether in contract or tort,
## including negligence, or under any other theory of
## liability) for any loss or damage of any kind or nature
## related to, arising under or in connection with these
## materials, including for any direct, or any indirect,
## special, incidental, or consequential loss or damage
## (including loss of data, profits, goodwill, or any type of
## loss or damage suffered as a result of any action brought
## by a third party) even if such damage or loss was
## reasonably foreseeable or Xilinx had been advised of the
## possibility of the same.
##
## CRITICAL APPLICATIONS
## Xilinx products are not designed or intended to be fail-
## safe, or for use in any application requiring fail-safe
## performance, such as life-support or safety devices or
## systems, Class III medical devices, nuclear facilities,
## applications related to the deployment of airbags, or any
## other applications that could lead to death, personal
## injury, or severe property or environmental damage
## (individually and collectively, "Critical
## Applications"). Customer assumes the sole risk and
## liability of any use of Xilinx products in Critical
## Applications, subject only to applicable laws and
## regulations governing limitations on product liability.
##
## THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
## PART OF THIS FILE AT ALL TIMES.
##
##-----------------------------------------------------------------------------
## Project    : Series-7 Integrated Block for PCI Express
## File       : xilinx_pcie_7x_ep_x4g2.xdc
## Version    : 3.1
#
###############################################################################
# User Configuration
# Link Width   - x4
# Link Speed   - gen2
# Family       - artix7
# Part         - xc7a100t
# Package      - fgg484
# Speed grade  - -2
# PCIe Block   - X0Y0
###############################################################################
#
###############################################################################
# User Time Names / User Time Groups / Time Specs
###############################################################################

###############################################################################
# User Physical Constraints
###############################################################################


###############################################################################
# Pinout and Related I/O Constraints
###############################################################################

#
# SYS reset (input) signal.  The sys_reset_n signal should be
# obtained from the PCI Express interface if possible.  For
# slot based form factors, a system reset signal is usually
# present on the connector.  For cable based form factors, a
# system reset signal may not be available.  In this case, the
# system reset signal must be generated locally by some form of
# supervisory circuit.  You may change the IOSTANDARD and LOC
# to suit your requirements and VCCO voltage banking rules.
# Some 7 series devices do not have 3.3 V I/Os available.
# Therefore the appropriate level shift is required to operate
# with these devices that contain only 1.8 V banks.
#
set_property PACKAGE_PIN J20 [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]
set_property PULLUP true [get_ports sys_rst_n]
###############################################################################
# Physical Constraints
###############################################################################
#
# SYS clock 100 MHz (input) signal. The sys_clk_p and sys_clk_n
# signals are the PCI Express reference clock. Virtex-7 GT
# Transceiver architecture requires the use of a dedicated clock
# resources (FPGA input pins) associated with each GT Transceiver.
# To use these pins an IBUFDS primitive (refclk_ibuf) is
# instantiated in user's design.
# Please refer to the Virtex-7 GT Transceiver User Guide
# (UG) for guidelines regarding clock resource selection.
#

set_property LOC IBUFDS_GTE2_X0Y2 [get_cells refclk_ibuf]

#############################################################################
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
###############################################################################
# Timing Constraints
###############################################################################
#
##############################################################################
# Tandem Configuration Constraints
###############################################################################

set_false_path -from [get_ports sys_rst_n]

###############################################################################
# End
###############################################################################

create_clock -period 10.000 -name sys_clk [get_ports sys_clk_clk_p]
# PadFunction: IO_L13P_T2_MRCC_34
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_ddr_clk_p]

# PadFunction: IO_L13N_T2_MRCC_34
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_ddr_clk_n]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_clk_n]
set_property PACKAGE_PIN R4 [get_ports sys_ddr_clk_p]
set_property PACKAGE_PIN T4 [get_ports sys_ddr_clk_n]
set_property PACKAGE_PIN F10 [get_ports sys_clk_clk_p]
set_property PACKAGE_PIN T6 [get_ports sys_rst]
set_property IOSTANDARD LVCMOS15 [get_ports sys_rst]
 set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets u_PCIe_wrapper/PCIe_i/clk_wiz_0/inst/clk_in1_PCIe_clk_wiz_0_0]
 
 set_property PACKAGE_PIN W5 [get_ports user_lnk_up]
 set_property IOSTANDARD SSTL15 [get_ports user_lnk_up]
 set_property PACKAGE_PIN B13 [get_ports msi_enable]
 set_property IOSTANDARD LVCMOS33 [get_ports msi_enable]
 
 #set_property PACKAGE_PIN C13 [get_ports usr_irq_ack]
 #set_property IOSTANDARD LVCMOS33 [get_ports usr_irq_ack]
 
 #set_property PACKAGE_PIN D14 [get_ports {led[2]}]
 #set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
 
 set_property PACKAGE_PIN D15 [get_ports init_ddr]
 set_property IOSTANDARD LVCMOS33 [get_ports init_ddr]
 
set_property PACKAGE_PIN M13 [get_ports vout_clk]
 set_property PACKAGE_PIN V14 [get_ports {vout_data[0]}]
 set_property PACKAGE_PIN H14 [get_ports {vout_data[1]}]
 set_property PACKAGE_PIN J14 [get_ports {vout_data[2]}]
 set_property PACKAGE_PIN K13 [get_ports {vout_data[3]}]
 set_property PACKAGE_PIN K14 [get_ports {vout_data[4]}]
 set_property PACKAGE_PIN L13 [get_ports {vout_data[5]}]
 set_property PACKAGE_PIN L19 [get_ports {vout_data[6]}]
 set_property PACKAGE_PIN L20 [get_ports {vout_data[7]}]
 set_property PACKAGE_PIN K17 [get_ports {vout_data[8]}]
 set_property PACKAGE_PIN J17 [get_ports {vout_data[9]}]
 set_property PACKAGE_PIN L16 [get_ports {vout_data[10]}]
 set_property PACKAGE_PIN K16 [get_ports {vout_data[11]}]
 set_property PACKAGE_PIN L14 [get_ports {vout_data[12]}]
 set_property PACKAGE_PIN L15 [get_ports {vout_data[13]}]
 set_property PACKAGE_PIN M15 [get_ports {vout_data[14]}]
 set_property PACKAGE_PIN M16 [get_ports {vout_data[15]}]
 set_property PACKAGE_PIN L18 [get_ports {vout_data[16]}]
 set_property PACKAGE_PIN M18 [get_ports {vout_data[17]}]
 set_property PACKAGE_PIN N18 [get_ports {vout_data[18]}]
 set_property PACKAGE_PIN N19 [get_ports {vout_data[19]}]
 set_property PACKAGE_PIN M20 [get_ports {vout_data[20]}]
 set_property PACKAGE_PIN N20 [get_ports {vout_data[21]}]
 set_property PACKAGE_PIN L21 [get_ports {vout_data[22]}]
 set_property PACKAGE_PIN M21 [get_ports {vout_data[23]}]
 set_property PACKAGE_PIN V13 [get_ports vout_de]
 set_property PACKAGE_PIN T15 [get_ports vout_hs]
 set_property PACKAGE_PIN J19 [get_ports hdmi_nreset]
 set_property PACKAGE_PIN T14 [get_ports vout_vs]
 set_property PACKAGE_PIN E16 [get_ports hdmi_scl]
 set_property PACKAGE_PIN F16 [get_ports hdmi_sda]
 
 set_property IOSTANDARD LVCMOS33 [get_ports vout_clk]
 set_property IOSTANDARD LVCMOS33 [get_ports {vout_data[*]}]
 set_property IOSTANDARD LVCMOS33 [get_ports vout_de]
 set_property IOSTANDARD LVCMOS33 [get_ports vout_hs]
 set_property IOSTANDARD LVCMOS33 [get_ports hdmi_nreset]
 set_property IOSTANDARD LVCMOS33 [get_ports vout_vs]
 set_property IOSTANDARD LVCMOS33 [get_ports hdmi_scl]
 set_property IOSTANDARD LVCMOS33 [get_ports hdmi_sda]
 
 
 
 
 set_property IOB TRUE [get_ports {vout_data[*]}]
 set_property IOB TRUE [get_ports vout_de]
 set_property IOB TRUE [get_ports vout_hs]
 set_property IOB TRUE [get_ports vout_vs]
 
 set_property SLEW FAST [get_ports {vout_data[*]}]
 set_property SLEW FAST [get_ports vout_de]
 set_property SLEW FAST [get_ports vout_hs]
 set_property SLEW FAST [get_ports vout_vs]
 
 
 set_property PACKAGE_PIN K21 [get_ports vin_clk]
 set_property PACKAGE_PIN H18 [get_ports {vin_data[0]}]
 set_property PACKAGE_PIN N22 [get_ports {vin_data[1]}]
 set_property PACKAGE_PIN M22 [get_ports {vin_data[2]}]
 set_property PACKAGE_PIN K22 [get_ports {vin_data[3]}]
 set_property PACKAGE_PIN J22 [get_ports {vin_data[4]}]
 set_property PACKAGE_PIN H22 [get_ports {vin_data[5]}]
 set_property PACKAGE_PIN H20 [get_ports {vin_data[6]}]
 set_property PACKAGE_PIN G20 [get_ports {vin_data[7]}]
 set_property PACKAGE_PIN G22 [get_ports {vin_data[8]}]
 set_property PACKAGE_PIN G21 [get_ports {vin_data[9]}]
 set_property PACKAGE_PIN D22 [get_ports {vin_data[10]}]
 set_property PACKAGE_PIN E22 [get_ports {vin_data[11]}]
 set_property PACKAGE_PIN D21 [get_ports {vin_data[12]}]
 set_property PACKAGE_PIN E21 [get_ports {vin_data[13]}]
 set_property PACKAGE_PIN B21 [get_ports {vin_data[14]}]
 set_property PACKAGE_PIN A21 [get_ports {vin_data[15]}]
 set_property PACKAGE_PIN F21 [get_ports {vin_data[16]}]
 set_property PACKAGE_PIN M17 [get_ports {vin_data[17]}]
 set_property PACKAGE_PIN J16 [get_ports {vin_data[18]}]
 set_property PACKAGE_PIN F15 [get_ports {vin_data[19]}]
 set_property PACKAGE_PIN G17 [get_ports {vin_data[20]}]
 set_property PACKAGE_PIN G18 [get_ports {vin_data[21]}]
 set_property PACKAGE_PIN G15 [get_ports {vin_data[22]}]
 set_property PACKAGE_PIN G16 [get_ports {vin_data[23]}]
 set_property PACKAGE_PIN H17 [get_ports vin_de]
 set_property PACKAGE_PIN K19 [get_ports vin_hs]
 set_property PACKAGE_PIN H19 [get_ports hdmi_in_nreset]
 set_property PACKAGE_PIN K18 [get_ports vin_vs]
 
 set_property IOSTANDARD LVCMOS33 [get_ports vin_clk]
 set_property IOSTANDARD LVCMOS33 [get_ports {vin_data[*]}]
 set_property IOSTANDARD LVCMOS33 [get_ports vin_de]
 set_property IOSTANDARD LVCMOS33 [get_ports vin_hs]
 set_property IOSTANDARD LVCMOS33 [get_ports vin_vs]
 set_property IOSTANDARD LVCMOS33 [get_ports hdmi_in_nreset]
 
 set_property IOB TRUE [get_ports {vin_data[*]}]
 set_property IOB TRUE [get_ports vin_de]
 set_property IOB TRUE [get_ports vin_hs]
 set_property IOB TRUE [get_ports vin_vs]
 
 set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets vin_clk_IBUF]
 
 
 set_property DRIVE 12 [get_ports {vout_data[12]}]
 set_property DRIVE 16 [get_ports vout_clk]
 set_property DRIVE 12 [get_ports vout_de]
 set_property DRIVE 12 [get_ports vout_hs]
 
 create_clock -period 6.734 -name vin_clk -waveform {0.000 3.367} [get_ports vin_clk]
 set_input_delay -clock [get_clocks vin_clk] -min -add_delay 1.010 [get_ports {vin_data[*]}]
 set_input_delay -clock [get_clocks vin_clk] -max -add_delay 3.500 [get_ports {vin_data[*]}]
 set_input_delay -clock [get_clocks vin_clk] -min -add_delay 1.010 [get_ports vin_de]
 set_input_delay -clock [get_clocks vin_clk] -max -add_delay 3.500 [get_ports vin_de]
 set_input_delay -clock [get_clocks vin_clk] -min -add_delay 1.010 [get_ports vin_hs]
 set_input_delay -clock [get_clocks vin_clk] -max -add_delay 3.500 [get_ports vin_hs]
 set_input_delay -clock [get_clocks vin_clk] -min -add_delay 1.010 [get_ports vin_vs]
 set_input_delay -clock [get_clocks vin_clk] -max -add_delay 3.500 [get_ports vin_vs]

