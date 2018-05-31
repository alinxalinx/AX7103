vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_addr_decode.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_read.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_reg.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_reg_bank.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_top.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_ctrl_write.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_ar_channel.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_aw_channel.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_b_channel.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_cmd_arbiter.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_cmd_fsm.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_cmd_translator.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_fifo.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_incr_cmd.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_r_channel.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_simple_fifo.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_wrap_cmd.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_wr_cmd_fsm.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_axi_mc_w_channel.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_axic_register_slice.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_axi_register_slice.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_axi_upsizer.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_a_upsizer.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_carry_and.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_carry_latch_and.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_carry_latch_or.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_carry_or.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_command_fifo.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_comparator.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_comparator_sel.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_comparator_sel_static.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_r_upsizer.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_0_ddr_w_upsizer.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/clocking/mig_7series_v4_0_clk_ibuf.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/clocking/mig_7series_v4_0_infrastructure.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/clocking/mig_7series_v4_0_iodelay_ctrl.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/clocking/mig_7series_v4_0_tempmon.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_arb_mux.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_arb_row_col.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_arb_select.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_cntrl.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_common.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_compare.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_mach.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_queue.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_state.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_col_mach.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_mc.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_rank_cntrl.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_rank_common.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_rank_mach.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_0_round_robin_arb.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ecc/mig_7series_v4_0_ecc_buf.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ecc/mig_7series_v4_0_ecc_dec_fix.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ecc/mig_7series_v4_0_ecc_gen.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ecc/mig_7series_v4_0_ecc_merge_enc.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ecc/mig_7series_v4_0_fi_xor.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ip_top/mig_7series_v4_0_memc_ui_top_axi.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ip_top/mig_7series_v4_0_mem_intfc.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_byte_group_io.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_byte_lane.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_calib_top.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_if_post_fifo.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_mc_phy.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_mc_phy_wrapper.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_of_pre_fifo.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_4lanes.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ck_addr_cmd_delay.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_dqs_found_cal.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_dqs_found_cal_hr.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_init.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_cntlr.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_data.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_edge.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_lim.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_mux.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_po_cntlr.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_samp.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_oclkdelay_cal.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_prbs_rdlvl.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_rdlvl.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_tempmon.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_top.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrcal.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrlvl.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrlvl_off_delay.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_prbs_gen.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_skip_calib_tap.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_cc.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_edge_store.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_meta.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_pd.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_tap_base.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_top.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ui/mig_7series_v4_0_ui_cmd.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ui/mig_7series_v4_0_ui_rd_data.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ui/mig_7series_v4_0_ui_top.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ui/mig_7series_v4_0_ui_wr_data.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ddr3_mig_sim.v" \
"../../../../dual_ov5640_an5642_hdmi.srcs/sources_1/ip/ddr3/ddr3/user_design/rtl/ddr3.v" \

vlog -work xil_defaultlib \
"glbl.v"

