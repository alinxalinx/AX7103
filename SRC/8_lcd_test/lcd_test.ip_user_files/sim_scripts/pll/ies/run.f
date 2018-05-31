-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../lcd_test.srcs/sources_1/ip/pll/pll_clk_wiz.v" \
  "../../../../lcd_test.srcs/sources_1/ip/pll/pll.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

