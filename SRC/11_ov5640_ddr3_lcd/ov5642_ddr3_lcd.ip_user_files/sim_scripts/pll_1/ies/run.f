-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/pll_1/pll_clk_wiz.v" \
  "../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/pll_1/pll.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

