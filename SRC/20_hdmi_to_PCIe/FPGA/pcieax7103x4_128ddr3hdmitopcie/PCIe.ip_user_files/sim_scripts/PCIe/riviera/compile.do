vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/util_ds_buf_v2_01_a
vlib riviera/blk_mem_gen_v8_3_6
vlib riviera/fifo_generator_v13_1_4
vlib riviera/xdma_v3_1_1
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_11
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_register_slice_v2_1_13
vlib riviera/axi_data_fifo_v2_1_12
vlib riviera/axi_crossbar_v2_1_14
vlib riviera/axi_clock_converter_v2_1_12
vlib riviera/axi_protocol_converter_v2_1_13
vlib riviera/axi_dwidth_converter_v2_1_13

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap util_ds_buf_v2_01_a riviera/util_ds_buf_v2_01_a
vmap blk_mem_gen_v8_3_6 riviera/blk_mem_gen_v8_3_6
vmap fifo_generator_v13_1_4 riviera/fifo_generator_v13_1_4
vmap xdma_v3_1_1 riviera/xdma_v3_1_1
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_11 riviera/proc_sys_reset_v5_0_11
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_13 riviera/axi_register_slice_v2_1_13
vmap axi_data_fifo_v2_1_12 riviera/axi_data_fifo_v2_1_12
vmap axi_crossbar_v2_1_14 riviera/axi_crossbar_v2_1_14
vmap axi_clock_converter_v2_1_12 riviera/axi_clock_converter_v2_1_12
vmap axi_protocol_converter_v2_1_13 riviera/axi_protocol_converter_v2_1_13
vmap axi_dwidth_converter_v2_1_13 riviera/axi_dwidth_converter_v2_1_13

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work util_ds_buf_v2_01_a -93 \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/1e84/hdl/vhdl/util_ds_buf.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/PCIe/ip/PCIe_util_ds_buf_0_0/sim/PCIe_util_ds_buf_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pipe_clock.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pipe_eq.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pipe_drp.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pipe_rate.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pipe_reset.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pipe_sync.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_gtp_pipe_rate.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_gtp_pipe_drp.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_gtp_pipe_reset.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pipe_user.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pipe_wrapper.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_qpll_drp.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_qpll_reset.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_qpll_wrapper.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_rxeq_scan.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pcie_top.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_core_top.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_axi_basic_rx_null_gen.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_axi_basic_rx_pipeline.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_axi_basic_rx.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_axi_basic_top.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_axi_basic_tx_pipeline.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_axi_basic_tx_thrtl_ctl.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_axi_basic_tx.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pcie_7x.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pcie_bram_7x.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pcie_bram_top_7x.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pcie_brams_7x.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pcie_pipe_lane.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pcie_pipe_misc.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pcie_pipe_pipeline.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_gt_top.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_gt_common.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_gtp_cpllpd_ovrd.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_gtx_cpllpd_ovrd.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_gt_rx_valid_filter_7x.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_gt_wrapper.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/source/PCIe_xdma_0_1_pcie2_ip_pcie2_top.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_0/sim/PCIe_xdma_0_1_pcie2_ip.v" \

vlog -work blk_mem_gen_v8_3_6  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/4158/simulation/blk_mem_gen_v8_3.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_1/sim/xdma_v3_1_1_blk_mem_64_reg_be.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_2/sim/xdma_v3_1_1_blk_mem_64_noreg_be.v" \

vlog -work fifo_generator_v13_1_4  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/ebc2/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_4 -93 \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/ebc2/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_4  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/ebc2/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_3/sim/pcie2_fifo_generator_dma_cpl.v" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/ip_4/sim/pcie2_fifo_generator_tgt_brdg.v" \

vlog -work xdma_v3_1_1  -sv2k12 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/xdma_v3_1_vl_rfs.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_dma_cpl.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_dma_req.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v2_0/hdl/verilog/PCIe_xdma_0_1_rx_destraddler.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_rx_demux.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_tgt_cpl.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_tgt_req.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_tx_mux.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_axi_stream_intf.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_cfg_sideband.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_pcie2_to_pcie3_wrapper.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_dma_bram_wrap.sv" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/xdma_v3_1/hdl/verilog/PCIe_xdma_0_1_core_top.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../bd/PCIe/ip/PCIe_xdma_0_1/sim/PCIe_xdma_0_1.v" \
"../../../bd/PCIe/ip/PCIe_clk_wiz_0_0/PCIe_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/PCIe/ip/PCIe_clk_wiz_0_0/PCIe_clk_wiz_0_0.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_addr_decode.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_read.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_reg.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_reg_bank.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_top.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_write.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_ar_channel.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_aw_channel.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_b_channel.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_cmd_arbiter.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_cmd_fsm.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_cmd_translator.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_fifo.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_incr_cmd.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_r_channel.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_simple_fifo.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_wrap_cmd.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_wr_cmd_fsm.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_axi_mc_w_channel.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_axic_register_slice.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_axi_register_slice.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_axi_upsizer.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_a_upsizer.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_carry_and.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_carry_latch_and.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_carry_latch_or.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_carry_or.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_command_fifo.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_comparator.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_comparator_sel.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_comparator_sel_static.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_r_upsizer.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/axi/mig_7series_v4_0_ddr_w_upsizer.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/clocking/mig_7series_v4_0_clk_ibuf.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/clocking/mig_7series_v4_0_infrastructure.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/clocking/mig_7series_v4_0_iodelay_ctrl.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/clocking/mig_7series_v4_0_tempmon.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_arb_mux.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_arb_row_col.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_arb_select.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_bank_cntrl.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_bank_common.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_bank_compare.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_bank_mach.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_bank_queue.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_bank_state.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_col_mach.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_mc.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_rank_cntrl.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_rank_common.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_rank_mach.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/controller/mig_7series_v4_0_round_robin_arb.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ecc/mig_7series_v4_0_ecc_buf.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ecc/mig_7series_v4_0_ecc_dec_fix.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ecc/mig_7series_v4_0_ecc_gen.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ecc/mig_7series_v4_0_ecc_merge_enc.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ecc/mig_7series_v4_0_fi_xor.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ip_top/mig_7series_v4_0_memc_ui_top_axi.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ip_top/mig_7series_v4_0_mem_intfc.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_byte_group_io.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_byte_lane.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_calib_top.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_if_post_fifo.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_mc_phy.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_mc_phy_wrapper.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_of_pre_fifo.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_4lanes.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ck_addr_cmd_delay.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_dqs_found_cal.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_dqs_found_cal_hr.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_init.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_cntlr.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_data.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_edge.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_lim.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_mux.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_po_cntlr.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_samp.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_oclkdelay_cal.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_prbs_rdlvl.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_rdlvl.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_tempmon.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_top.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrcal.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrlvl.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrlvl_off_delay.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_prbs_gen.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_ddr_skip_calib_tap.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_poc_cc.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_poc_edge_store.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_poc_meta.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_poc_pd.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_poc_tap_base.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/phy/mig_7series_v4_0_poc_top.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ui/mig_7series_v4_0_ui_cmd.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ui/mig_7series_v4_0_ui_rd_data.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ui/mig_7series_v4_0_ui_top.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/ui/mig_7series_v4_0_ui_wr_data.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/PCIe_mig_7series_0_0_mig_sim.v" \
"../../../bd/PCIe/ip/PCIe_mig_7series_0_0/PCIe_mig_7series_0_0/user_design/rtl/PCIe_mig_7series_0_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/52cb/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_11 -93 \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/5db7/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/PCIe/ip/PCIe_rst_mig_7series_0_100M_0/sim/PCIe_rst_mig_7series_0_100M_0.vhd" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/f9c1/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_13  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/55c0/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_data_fifo_v2_1_12  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/95b9/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_14  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/f582/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../bd/PCIe/ip/PCIe_xbar_0/sim/PCIe_xbar_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/PCIe/ip/PCIe_proc_sys_reset_0_0/sim/PCIe_proc_sys_reset_0_0.vhd" \

vlog -work axi_clock_converter_v2_1_12  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/80fd/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../bd/PCIe/ip/PCIe_auto_cc_0/sim/PCIe_auto_cc_0.v" \

vlog -work axi_protocol_converter_v2_1_13  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/f0ae/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work axi_dwidth_converter_v2_1_13  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/3bde/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/bcea/hdl/verilog" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/9c7f" "+incdir+../../../../PCIe.srcs/sources_1/bd/PCIe/ipshared/7e3a/hdl" \
"../../../bd/PCIe/ip/PCIe_auto_us_1/sim/PCIe_auto_us_1.v" \
"../../../bd/PCIe/ip/PCIe_auto_us_0/sim/PCIe_auto_us_0.v" \
"../../../bd/PCIe/ip/PCIe_auto_cc_1/sim/PCIe_auto_cc_1.v" \
"../../../bd/PCIe/hdl/PCIe.v" \

vlog -work xil_defaultlib \
"glbl.v"

