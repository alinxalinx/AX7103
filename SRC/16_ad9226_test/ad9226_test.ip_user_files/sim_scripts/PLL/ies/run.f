-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../ad9226_test.srcs/sources_1/ip/PLL/PLL_clk_wiz.v" \
  "../../../../ad9226_test.srcs/sources_1/ip/PLL/PLL.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

