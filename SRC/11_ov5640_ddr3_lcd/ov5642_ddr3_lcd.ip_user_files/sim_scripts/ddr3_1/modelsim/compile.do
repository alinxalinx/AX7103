vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -incr -sv \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/clocking/mig_7series_v4_0_clk_ibuf.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/clocking/mig_7series_v4_0_infrastructure.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/clocking/mig_7series_v4_0_iodelay_ctrl.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/clocking/mig_7series_v4_0_tempmon.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_arb_mux.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_arb_row_col.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_arb_select.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_cntrl.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_common.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_compare.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_mach.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_queue.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_bank_state.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_col_mach.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_mc.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_rank_cntrl.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_rank_common.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_rank_mach.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/controller/mig_7series_v4_0_round_robin_arb.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ecc/mig_7series_v4_0_ecc_buf.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ecc/mig_7series_v4_0_ecc_dec_fix.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ecc/mig_7series_v4_0_ecc_gen.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ecc/mig_7series_v4_0_ecc_merge_enc.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ecc/mig_7series_v4_0_fi_xor.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ip_top/mig_7series_v4_0_memc_ui_top_std.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ip_top/mig_7series_v4_0_mem_intfc.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_byte_group_io.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_byte_lane.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_calib_top.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_if_post_fifo.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_mc_phy.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_mc_phy_wrapper.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_of_pre_fifo.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_4lanes.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ck_addr_cmd_delay.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_dqs_found_cal.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_dqs_found_cal_hr.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_init.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_cntlr.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_data.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_edge.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_lim.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_mux.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_po_cntlr.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_ocd_samp.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_oclkdelay_cal.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_prbs_rdlvl.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_rdlvl.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_tempmon.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_top.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrcal.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrlvl.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_phy_wrlvl_off_delay.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_prbs_gen.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_ddr_skip_calib_tap.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_cc.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_edge_store.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_meta.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_pd.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_tap_base.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/phy/mig_7series_v4_0_poc_top.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ui/mig_7series_v4_0_ui_cmd.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ui/mig_7series_v4_0_ui_rd_data.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ui/mig_7series_v4_0_ui_top.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ui/mig_7series_v4_0_ui_wr_data.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ddr3_mig_sim.v" \
"../../../../ov5642_ddr3_lcd.srcs/sources_1/ip/ddr3_1/ddr3/user_design/rtl/ddr3.v" \

vlog -work xil_defaultlib \
"glbl.v"

