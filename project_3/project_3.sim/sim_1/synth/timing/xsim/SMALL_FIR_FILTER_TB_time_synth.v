// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Mon Mar 29 14:55:18 2021
// Host        : DESKTOP-KU48GBD running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/.uni/e739/project_3/project_3.sim/sim_1/synth/timing/xsim/SMALL_FIR_FILTER_TB_time_synth.v
// Design      : CLK_TEST
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* NotValidForBitStream *)
module CLK_TEST
   (i_average,
    i_clk,
    i_reset,
    i_signal_rdy,
    i_small_filter_active,
    o_reset_ack,
    o_filter_rdy,
    o_small_filter);
  input [7:0]i_average;
  input i_clk;
  input i_reset;
  input i_signal_rdy;
  input i_small_filter_active;
  output o_reset_ack;
  output o_filter_rdy;
  output [15:0]o_small_filter;

  wire [7:0]i_average;
  wire [7:0]i_average_IBUF;
  (* IBUF_LOW_PWR *) wire i_clk;
  wire i_reset;
  wire i_reset_IBUF;
  wire i_signal_rdy;
  wire i_signal_rdy_IBUF;
  wire i_small_filter_active;
  wire i_small_filter_active_IBUF;
  wire o_filter_rdy;
  wire o_filter_rdy_OBUF;
  wire o_reset_ack;
  wire o_reset_ack_OBUF;
  wire [15:0]o_small_filter;
  wire [15:0]o_small_filter_OBUF;
  wire w_clk_100;
  wire w_clk_12_5;

initial begin
 $sdf_annotate("SMALL_FIR_FILTER_TB_time_synth.sdf",,,,"tool_control");
end
  SMALL_FIR_FILTER SMALL_FIR_FILTER_1
       (.CLK(w_clk_12_5),
        .D(i_average_IBUF),
        .E(i_small_filter_active_IBUF),
        .Q(o_small_filter_OBUF),
        .SR(i_reset_IBUF),
        .clk_100M(w_clk_100),
        .i_signal_rdy(i_signal_rdy_IBUF),
        .o_filter_rdy(o_filter_rdy_OBUF),
        .o_reset_ack(o_reset_ack_OBUF));
  IBUF \i_average_IBUF[0]_inst 
       (.I(i_average[0]),
        .O(i_average_IBUF[0]));
  IBUF \i_average_IBUF[1]_inst 
       (.I(i_average[1]),
        .O(i_average_IBUF[1]));
  IBUF \i_average_IBUF[2]_inst 
       (.I(i_average[2]),
        .O(i_average_IBUF[2]));
  IBUF \i_average_IBUF[3]_inst 
       (.I(i_average[3]),
        .O(i_average_IBUF[3]));
  IBUF \i_average_IBUF[4]_inst 
       (.I(i_average[4]),
        .O(i_average_IBUF[4]));
  IBUF \i_average_IBUF[5]_inst 
       (.I(i_average[5]),
        .O(i_average_IBUF[5]));
  IBUF \i_average_IBUF[6]_inst 
       (.I(i_average[6]),
        .O(i_average_IBUF[6]));
  IBUF \i_average_IBUF[7]_inst 
       (.I(i_average[7]),
        .O(i_average_IBUF[7]));
  IBUF i_reset_IBUF_inst
       (.I(i_reset),
        .O(i_reset_IBUF));
  IBUF i_signal_rdy_IBUF_inst
       (.I(i_signal_rdy),
        .O(i_signal_rdy_IBUF));
  IBUF i_small_filter_active_IBUF_inst
       (.I(i_small_filter_active),
        .O(i_small_filter_active_IBUF));
  (* IMPORTED_FROM = "c:/.uni/e739/project_3/project_3.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp" *) 
  (* IMPORTED_TYPE = "CHECKPOINT" *) 
  (* IS_IMPORTED *) 
  (* syn_black_box = "TRUE" *) 
  clk_wiz_0 mmcm_1
       (.clk_100M(w_clk_100),
        .clk_12_5M(w_clk_12_5),
        .clk_in1(i_clk));
  OBUF o_filter_rdy_OBUF_inst
       (.I(o_filter_rdy_OBUF),
        .O(o_filter_rdy));
  OBUF o_reset_ack_OBUF_inst
       (.I(o_reset_ack_OBUF),
        .O(o_reset_ack));
  OBUF \o_small_filter_OBUF[0]_inst 
       (.I(o_small_filter_OBUF[0]),
        .O(o_small_filter[0]));
  OBUF \o_small_filter_OBUF[10]_inst 
       (.I(o_small_filter_OBUF[10]),
        .O(o_small_filter[10]));
  OBUF \o_small_filter_OBUF[11]_inst 
       (.I(o_small_filter_OBUF[11]),
        .O(o_small_filter[11]));
  OBUF \o_small_filter_OBUF[12]_inst 
       (.I(o_small_filter_OBUF[12]),
        .O(o_small_filter[12]));
  OBUF \o_small_filter_OBUF[13]_inst 
       (.I(o_small_filter_OBUF[13]),
        .O(o_small_filter[13]));
  OBUF \o_small_filter_OBUF[14]_inst 
       (.I(o_small_filter_OBUF[14]),
        .O(o_small_filter[14]));
  OBUF \o_small_filter_OBUF[15]_inst 
       (.I(o_small_filter_OBUF[15]),
        .O(o_small_filter[15]));
  OBUF \o_small_filter_OBUF[1]_inst 
       (.I(o_small_filter_OBUF[1]),
        .O(o_small_filter[1]));
  OBUF \o_small_filter_OBUF[2]_inst 
       (.I(o_small_filter_OBUF[2]),
        .O(o_small_filter[2]));
  OBUF \o_small_filter_OBUF[3]_inst 
       (.I(o_small_filter_OBUF[3]),
        .O(o_small_filter[3]));
  OBUF \o_small_filter_OBUF[4]_inst 
       (.I(o_small_filter_OBUF[4]),
        .O(o_small_filter[4]));
  OBUF \o_small_filter_OBUF[5]_inst 
       (.I(o_small_filter_OBUF[5]),
        .O(o_small_filter[5]));
  OBUF \o_small_filter_OBUF[6]_inst 
       (.I(o_small_filter_OBUF[6]),
        .O(o_small_filter[6]));
  OBUF \o_small_filter_OBUF[7]_inst 
       (.I(o_small_filter_OBUF[7]),
        .O(o_small_filter[7]));
  OBUF \o_small_filter_OBUF[8]_inst 
       (.I(o_small_filter_OBUF[8]),
        .O(o_small_filter[8]));
  OBUF \o_small_filter_OBUF[9]_inst 
       (.I(o_small_filter_OBUF[9]),
        .O(o_small_filter[9]));
endmodule

module SMALL_FIR_FILTER
   (o_reset_ack,
    o_filter_rdy,
    Q,
    SR,
    E,
    clk_100M,
    CLK,
    i_signal_rdy,
    D);
  output o_reset_ack;
  output o_filter_rdy;
  output [15:0]Q;
  input [0:0]SR;
  input [0:0]E;
  input clk_100M;
  input CLK;
  input i_signal_rdy;
  input [7:0]D;

  wire [13:0]ARG;
  wire ARG__0_carry__0_i_10_n_0;
  wire ARG__0_carry__0_i_11_n_0;
  wire ARG__0_carry__0_i_12_n_0;
  wire ARG__0_carry__0_i_13_n_0;
  wire ARG__0_carry__0_i_14_n_0;
  wire ARG__0_carry__0_i_15_n_0;
  wire ARG__0_carry__0_i_16_n_0;
  wire ARG__0_carry__0_i_17_n_0;
  wire ARG__0_carry__0_i_19_n_0;
  wire ARG__0_carry__0_i_1_n_0;
  wire ARG__0_carry__0_i_20_n_0;
  wire ARG__0_carry__0_i_21_n_0;
  wire ARG__0_carry__0_i_22_n_0;
  wire ARG__0_carry__0_i_23_n_0;
  wire ARG__0_carry__0_i_24_n_0;
  wire ARG__0_carry__0_i_2_n_0;
  wire ARG__0_carry__0_i_3_n_0;
  wire ARG__0_carry__0_i_4_n_0;
  wire ARG__0_carry__0_i_5_n_0;
  wire ARG__0_carry__0_i_6_n_0;
  wire ARG__0_carry__0_i_7_n_0;
  wire ARG__0_carry__0_i_8_n_0;
  wire ARG__0_carry__0_i_9_n_0;
  wire ARG__0_carry__0_n_0;
  wire ARG__0_carry__0_n_1;
  wire ARG__0_carry__0_n_2;
  wire ARG__0_carry__0_n_3;
  wire ARG__0_carry__0_n_4;
  wire ARG__0_carry__0_n_5;
  wire ARG__0_carry__0_n_6;
  wire ARG__0_carry__0_n_7;
  wire ARG__0_carry__1_i_10_n_0;
  wire ARG__0_carry__1_i_11_n_0;
  wire ARG__0_carry__1_i_1_n_0;
  wire ARG__0_carry__1_i_2_n_0;
  wire ARG__0_carry__1_i_3_n_0;
  wire ARG__0_carry__1_i_4_n_0;
  wire ARG__0_carry__1_i_5_n_0;
  wire ARG__0_carry__1_i_8_n_0;
  wire ARG__0_carry__1_i_9_n_0;
  wire ARG__0_carry__1_n_1;
  wire ARG__0_carry__1_n_3;
  wire ARG__0_carry__1_n_6;
  wire ARG__0_carry__1_n_7;
  wire ARG__0_carry_i_10_n_0;
  wire ARG__0_carry_i_11_n_0;
  wire ARG__0_carry_i_18_n_0;
  wire ARG__0_carry_i_19_n_0;
  wire ARG__0_carry_i_1_n_0;
  wire ARG__0_carry_i_20_n_0;
  wire ARG__0_carry_i_21_n_0;
  wire ARG__0_carry_i_22_n_0;
  wire ARG__0_carry_i_24_n_0;
  wire ARG__0_carry_i_25_n_0;
  wire ARG__0_carry_i_26_n_0;
  wire ARG__0_carry_i_27_n_0;
  wire ARG__0_carry_i_28_n_0;
  wire ARG__0_carry_i_29_n_0;
  wire ARG__0_carry_i_2_n_0;
  wire ARG__0_carry_i_30_n_0;
  wire ARG__0_carry_i_31_n_0;
  wire ARG__0_carry_i_32_n_0;
  wire ARG__0_carry_i_3_n_0;
  wire ARG__0_carry_i_4_n_0;
  wire ARG__0_carry_i_5_n_0;
  wire ARG__0_carry_i_6_n_0;
  wire ARG__0_carry_i_7_n_0;
  wire ARG__0_carry_i_8_n_0;
  wire ARG__0_carry_i_9_n_0;
  wire ARG__0_carry_n_0;
  wire ARG__0_carry_n_1;
  wire ARG__0_carry_n_2;
  wire ARG__0_carry_n_3;
  wire ARG__0_carry_n_4;
  wire ARG__30_carry__0_i_11_n_0;
  wire ARG__30_carry__0_i_12_n_0;
  wire ARG__30_carry__0_i_13_n_0;
  wire ARG__30_carry__0_i_14_n_0;
  wire ARG__30_carry__0_i_15_n_0;
  wire ARG__30_carry__0_i_16_n_0;
  wire ARG__30_carry__0_i_17_n_0;
  wire ARG__30_carry__0_i_18_n_0;
  wire ARG__30_carry__0_i_19_n_0;
  wire ARG__30_carry__0_i_1_n_0;
  wire ARG__30_carry__0_i_20_n_0;
  wire ARG__30_carry__0_i_21_n_0;
  wire ARG__30_carry__0_i_22_n_0;
  wire ARG__30_carry__0_i_23_n_0;
  wire ARG__30_carry__0_i_24_n_0;
  wire ARG__30_carry__0_i_25_n_0;
  wire ARG__30_carry__0_i_26_n_0;
  wire ARG__30_carry__0_i_27_n_0;
  wire ARG__30_carry__0_i_28_n_0;
  wire ARG__30_carry__0_i_29_n_0;
  wire ARG__30_carry__0_i_2_n_0;
  wire ARG__30_carry__0_i_30_n_0;
  wire ARG__30_carry__0_i_3_n_0;
  wire ARG__30_carry__0_i_4_n_0;
  wire ARG__30_carry__0_i_5_n_0;
  wire ARG__30_carry__0_i_6_n_0;
  wire ARG__30_carry__0_i_7_n_0;
  wire ARG__30_carry__0_i_8_n_0;
  wire ARG__30_carry__0_n_0;
  wire ARG__30_carry__0_n_1;
  wire ARG__30_carry__0_n_2;
  wire ARG__30_carry__0_n_3;
  wire ARG__30_carry__0_n_4;
  wire ARG__30_carry__0_n_5;
  wire ARG__30_carry__0_n_6;
  wire ARG__30_carry__0_n_7;
  wire ARG__30_carry__1_i_1_n_0;
  wire ARG__30_carry__1_i_2_n_0;
  wire ARG__30_carry__1_i_3_n_0;
  wire ARG__30_carry__1_i_4_n_0;
  wire ARG__30_carry__1_n_2;
  wire ARG__30_carry__1_n_3;
  wire ARG__30_carry__1_n_5;
  wire ARG__30_carry__1_n_6;
  wire ARG__30_carry__1_n_7;
  wire ARG__30_carry_i_13_n_0;
  wire ARG__30_carry_i_1_n_0;
  wire ARG__30_carry_i_2_n_0;
  wire ARG__30_carry_i_3_n_0;
  wire ARG__30_carry_i_4_n_0;
  wire ARG__30_carry_i_5_n_0;
  wire ARG__30_carry_i_6_n_0;
  wire ARG__30_carry_i_7_n_0;
  wire ARG__30_carry_i_8_n_0;
  wire ARG__30_carry_i_9_n_0;
  wire ARG__30_carry_n_0;
  wire ARG__30_carry_n_1;
  wire ARG__30_carry_n_2;
  wire ARG__30_carry_n_3;
  wire ARG__30_carry_n_4;
  wire ARG__30_carry_n_5;
  wire ARG__30_carry_n_6;
  wire ARG__30_carry_n_7;
  wire ARG__59_carry__0_i_1_n_0;
  wire ARG__59_carry__0_i_2_n_0;
  wire ARG__59_carry__0_i_3_n_0;
  wire ARG__59_carry__0_i_4_n_0;
  wire ARG__59_carry__0_i_5_n_0;
  wire ARG__59_carry__0_i_6_n_0;
  wire ARG__59_carry__0_i_7_n_0;
  wire ARG__59_carry__0_i_8_n_0;
  wire ARG__59_carry__0_n_0;
  wire ARG__59_carry__0_n_1;
  wire ARG__59_carry__0_n_2;
  wire ARG__59_carry__0_n_3;
  wire ARG__59_carry__1_i_1_n_0;
  wire ARG__59_carry__1_n_2;
  wire ARG__59_carry__1_n_3;
  wire ARG__59_carry_i_1_n_0;
  wire ARG__59_carry_i_2_n_0;
  wire ARG__59_carry_i_3_n_0;
  wire ARG__59_carry_i_4_n_0;
  wire ARG__59_carry_n_0;
  wire ARG__59_carry_n_1;
  wire ARG__59_carry_n_2;
  wire ARG__59_carry_n_3;
  wire [3:3]C;
  wire CLK;
  wire [7:0]D;
  wire [0:0]E;
  wire \FSM_onehot_r_current_state_reg_n_0_[0] ;
  wire \FSM_onehot_r_current_state_reg_n_0_[1] ;
  wire \FSM_onehot_r_current_state_reg_n_0_[2] ;
  wire \FSM_onehot_r_current_state_reg_n_0_[3] ;
  wire \FSM_onehot_r_current_state_reg_n_0_[4] ;
  wire \FSM_onehot_r_current_state_reg_n_0_[5] ;
  wire \FSM_onehot_r_current_state_reg_n_0_[6] ;
  wire \FSM_onehot_r_current_state_reg_n_0_[7] ;
  wire [15:0]Q;
  wire [0:0]SR;
  wire clk_100M;
  wire [5:0]\coef_n[7]__7 ;
  wire i_signal_rdy;
  wire o_filter_rdy;
  wire o_reset_ack;
  wire p_0_in;
  wire [2:0]r_current_state_reg;
  wire r_fast_rising_detector;
  wire r_filter_rdy;
  wire r_rising_detector;
  wire [15:0]r_small_filter_out;
  wire r_small_filter_out_carry__0_i_1_n_0;
  wire r_small_filter_out_carry__0_i_2_n_0;
  wire r_small_filter_out_carry__0_i_3_n_0;
  wire r_small_filter_out_carry__0_i_4_n_0;
  wire r_small_filter_out_carry__0_n_0;
  wire r_small_filter_out_carry__0_n_1;
  wire r_small_filter_out_carry__0_n_2;
  wire r_small_filter_out_carry__0_n_3;
  wire r_small_filter_out_carry__1_i_1_n_0;
  wire r_small_filter_out_carry__1_i_2_n_0;
  wire r_small_filter_out_carry__1_i_3_n_0;
  wire r_small_filter_out_carry__1_i_4_n_0;
  wire r_small_filter_out_carry__1_n_0;
  wire r_small_filter_out_carry__1_n_1;
  wire r_small_filter_out_carry__1_n_2;
  wire r_small_filter_out_carry__1_n_3;
  wire r_small_filter_out_carry__2_i_1_n_0;
  wire r_small_filter_out_carry__2_i_2_n_0;
  wire r_small_filter_out_carry__2_i_3_n_0;
  wire r_small_filter_out_carry__2_i_4_n_0;
  wire r_small_filter_out_carry__2_i_5_n_0;
  wire r_small_filter_out_carry__2_n_1;
  wire r_small_filter_out_carry__2_n_2;
  wire r_small_filter_out_carry__2_n_3;
  wire r_small_filter_out_carry_i_2_n_0;
  wire r_small_filter_out_carry_i_3_n_0;
  wire r_small_filter_out_carry_i_4_n_0;
  wire r_small_filter_out_carry_i_5_n_0;
  wire r_small_filter_out_carry_n_0;
  wire r_small_filter_out_carry_n_1;
  wire r_small_filter_out_carry_n_2;
  wire r_small_filter_out_carry_n_3;
  wire \w_filter_feedback[0]_i_3_n_0 ;
  wire \w_filter_feedback[0]_i_4_n_0 ;
  wire \w_filter_feedback[0]_i_5_n_0 ;
  wire \w_filter_feedback[0]_i_6_n_0 ;
  wire \w_filter_feedback[12]_i_2_n_0 ;
  wire \w_filter_feedback[12]_i_3_n_0 ;
  wire \w_filter_feedback[12]_i_4_n_0 ;
  wire \w_filter_feedback[12]_i_5_n_0 ;
  wire \w_filter_feedback[4]_i_2_n_0 ;
  wire \w_filter_feedback[4]_i_3_n_0 ;
  wire \w_filter_feedback[4]_i_4_n_0 ;
  wire \w_filter_feedback[4]_i_5_n_0 ;
  wire \w_filter_feedback[8]_i_2_n_0 ;
  wire \w_filter_feedback[8]_i_3_n_0 ;
  wire \w_filter_feedback[8]_i_4_n_0 ;
  wire \w_filter_feedback[8]_i_5_n_0 ;
  wire [15:0]w_filter_feedback_reg;
  wire \w_filter_feedback_reg[0]_i_1_n_0 ;
  wire \w_filter_feedback_reg[0]_i_1_n_1 ;
  wire \w_filter_feedback_reg[0]_i_1_n_2 ;
  wire \w_filter_feedback_reg[0]_i_1_n_3 ;
  wire \w_filter_feedback_reg[0]_i_1_n_4 ;
  wire \w_filter_feedback_reg[0]_i_1_n_5 ;
  wire \w_filter_feedback_reg[0]_i_1_n_6 ;
  wire \w_filter_feedback_reg[0]_i_1_n_7 ;
  wire \w_filter_feedback_reg[12]_i_1_n_1 ;
  wire \w_filter_feedback_reg[12]_i_1_n_2 ;
  wire \w_filter_feedback_reg[12]_i_1_n_3 ;
  wire \w_filter_feedback_reg[12]_i_1_n_4 ;
  wire \w_filter_feedback_reg[12]_i_1_n_5 ;
  wire \w_filter_feedback_reg[12]_i_1_n_6 ;
  wire \w_filter_feedback_reg[12]_i_1_n_7 ;
  wire \w_filter_feedback_reg[4]_i_1_n_0 ;
  wire \w_filter_feedback_reg[4]_i_1_n_1 ;
  wire \w_filter_feedback_reg[4]_i_1_n_2 ;
  wire \w_filter_feedback_reg[4]_i_1_n_3 ;
  wire \w_filter_feedback_reg[4]_i_1_n_4 ;
  wire \w_filter_feedback_reg[4]_i_1_n_5 ;
  wire \w_filter_feedback_reg[4]_i_1_n_6 ;
  wire \w_filter_feedback_reg[4]_i_1_n_7 ;
  wire \w_filter_feedback_reg[8]_i_1_n_0 ;
  wire \w_filter_feedback_reg[8]_i_1_n_1 ;
  wire \w_filter_feedback_reg[8]_i_1_n_2 ;
  wire \w_filter_feedback_reg[8]_i_1_n_3 ;
  wire \w_filter_feedback_reg[8]_i_1_n_4 ;
  wire \w_filter_feedback_reg[8]_i_1_n_5 ;
  wire \w_filter_feedback_reg[8]_i_1_n_6 ;
  wire \w_filter_feedback_reg[8]_i_1_n_7 ;
  wire [7:0]\x_n[7]__55 ;
  wire [7:0]\x_n_reg[0] ;
  wire [7:0]\x_n_reg[1] ;
  wire [7:0]\x_n_reg[2] ;
  wire [7:0]\x_n_reg[3] ;
  wire [7:0]\x_n_reg[4] ;
  wire [7:0]\x_n_reg[5] ;
  wire [7:0]\x_n_reg[6] ;
  wire [7:0]\x_n_reg[7] ;
  wire [3:1]NLW_ARG__0_carry__1_CO_UNCONNECTED;
  wire [3:2]NLW_ARG__0_carry__1_O_UNCONNECTED;
  wire [3:2]NLW_ARG__30_carry__1_CO_UNCONNECTED;
  wire [3:3]NLW_ARG__30_carry__1_O_UNCONNECTED;
  wire [0:0]NLW_ARG__59_carry_O_UNCONNECTED;
  wire [3:2]NLW_ARG__59_carry__1_CO_UNCONNECTED;
  wire [3:3]NLW_ARG__59_carry__1_O_UNCONNECTED;
  wire [3:3]NLW_r_small_filter_out_carry__2_CO_UNCONNECTED;
  wire [3:3]\NLW_w_filter_feedback_reg[12]_i_1_CO_UNCONNECTED ;

  CARRY4 ARG__0_carry
       (.CI(1'b0),
        .CO({ARG__0_carry_n_0,ARG__0_carry_n_1,ARG__0_carry_n_2,ARG__0_carry_n_3}),
        .CYINIT(1'b0),
        .DI({ARG__0_carry_i_1_n_0,ARG__0_carry_i_2_n_0,ARG__0_carry_i_3_n_0,1'b0}),
        .O({ARG__0_carry_n_4,ARG[2:0]}),
        .S({ARG__0_carry_i_4_n_0,ARG__0_carry_i_5_n_0,ARG__0_carry_i_6_n_0,ARG__0_carry_i_7_n_0}));
  CARRY4 ARG__0_carry__0
       (.CI(ARG__0_carry_n_0),
        .CO({ARG__0_carry__0_n_0,ARG__0_carry__0_n_1,ARG__0_carry__0_n_2,ARG__0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({ARG__0_carry__0_i_1_n_0,ARG__0_carry__0_i_2_n_0,ARG__0_carry__0_i_3_n_0,ARG__0_carry__0_i_4_n_0}),
        .O({ARG__0_carry__0_n_4,ARG__0_carry__0_n_5,ARG__0_carry__0_n_6,ARG__0_carry__0_n_7}),
        .S({ARG__0_carry__0_i_5_n_0,ARG__0_carry__0_i_6_n_0,ARG__0_carry__0_i_7_n_0,ARG__0_carry__0_i_8_n_0}));
  LUT3 #(
    .INIT(8'h17)) 
    ARG__0_carry__0_i_1
       (.I0(ARG__0_carry__0_i_9_n_0),
        .I1(ARG__0_carry__0_i_10_n_0),
        .I2(ARG__0_carry__0_i_11_n_0),
        .O(ARG__0_carry__0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h5557)) 
    ARG__0_carry__0_i_10
       (.I0(\x_n[7]__55 [5]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(ARG__0_carry__0_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h57)) 
    ARG__0_carry__0_i_11
       (.I0(\x_n[7]__55 [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .O(ARG__0_carry__0_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__0_carry__0_i_12
       (.I0(\x_n[7]__55 [3]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__0_carry__0_i_12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h5557)) 
    ARG__0_carry__0_i_13
       (.I0(\x_n[7]__55 [4]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(ARG__0_carry__0_i_13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h57)) 
    ARG__0_carry__0_i_14
       (.I0(\x_n[7]__55 [5]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .O(ARG__0_carry__0_i_14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__0_carry__0_i_15
       (.I0(\x_n[7]__55 [2]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__0_carry__0_i_15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h5557)) 
    ARG__0_carry__0_i_16
       (.I0(\x_n[7]__55 [3]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(ARG__0_carry__0_i_16_n_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h57)) 
    ARG__0_carry__0_i_17
       (.I0(\x_n[7]__55 [4]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .O(ARG__0_carry__0_i_17_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    ARG__0_carry__0_i_18
       (.I0(ARG__0_carry__0_i_21_n_0),
        .I1(ARG__0_carry__0_i_22_n_0),
        .I2(r_current_state_reg[2]),
        .I3(ARG__0_carry__0_i_23_n_0),
        .I4(r_current_state_reg[1]),
        .I5(ARG__0_carry__0_i_24_n_0),
        .O(\x_n[7]__55 [7]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h5557)) 
    ARG__0_carry__0_i_19
       (.I0(\x_n[7]__55 [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(ARG__0_carry__0_i_19_n_0));
  LUT3 #(
    .INIT(8'h17)) 
    ARG__0_carry__0_i_2
       (.I0(ARG__0_carry__0_i_12_n_0),
        .I1(ARG__0_carry__0_i_13_n_0),
        .I2(ARG__0_carry__0_i_14_n_0),
        .O(ARG__0_carry__0_i_2_n_0));
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__0_carry__0_i_20
       (.I0(\x_n[7]__55 [5]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__0_carry__0_i_20_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry__0_i_21
       (.I0(\x_n_reg[7] [7]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[6] [7]),
        .O(ARG__0_carry__0_i_21_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry__0_i_22
       (.I0(\x_n_reg[5] [7]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[4] [7]),
        .O(ARG__0_carry__0_i_22_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry__0_i_23
       (.I0(\x_n_reg[3] [7]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[2] [7]),
        .O(ARG__0_carry__0_i_23_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry__0_i_24
       (.I0(\x_n_reg[1] [7]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[0] [7]),
        .O(ARG__0_carry__0_i_24_n_0));
  LUT3 #(
    .INIT(8'h17)) 
    ARG__0_carry__0_i_3
       (.I0(ARG__0_carry__0_i_15_n_0),
        .I1(ARG__0_carry__0_i_16_n_0),
        .I2(ARG__0_carry__0_i_17_n_0),
        .O(ARG__0_carry__0_i_3_n_0));
  LUT3 #(
    .INIT(8'h17)) 
    ARG__0_carry__0_i_4
       (.I0(ARG__0_carry_i_9_n_0),
        .I1(ARG__0_carry_i_8_n_0),
        .I2(ARG__0_carry_i_10_n_0),
        .O(ARG__0_carry__0_i_4_n_0));
  LUT6 #(
    .INIT(64'hA85757A857A8A857)) 
    ARG__0_carry__0_i_5
       (.I0(\x_n[7]__55 [7]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .I3(ARG__0_carry__0_i_1_n_0),
        .I4(ARG__0_carry__0_i_19_n_0),
        .I5(ARG__0_carry__0_i_20_n_0),
        .O(ARG__0_carry__0_i_5_n_0));
  LUT6 #(
    .INIT(64'h17E8E817E81717E8)) 
    ARG__0_carry__0_i_6
       (.I0(ARG__0_carry__0_i_14_n_0),
        .I1(ARG__0_carry__0_i_13_n_0),
        .I2(ARG__0_carry__0_i_12_n_0),
        .I3(ARG__0_carry__0_i_10_n_0),
        .I4(ARG__0_carry__0_i_9_n_0),
        .I5(ARG__0_carry__0_i_11_n_0),
        .O(ARG__0_carry__0_i_6_n_0));
  LUT6 #(
    .INIT(64'h17E8E817E81717E8)) 
    ARG__0_carry__0_i_7
       (.I0(ARG__0_carry__0_i_17_n_0),
        .I1(ARG__0_carry__0_i_16_n_0),
        .I2(ARG__0_carry__0_i_15_n_0),
        .I3(ARG__0_carry__0_i_13_n_0),
        .I4(ARG__0_carry__0_i_12_n_0),
        .I5(ARG__0_carry__0_i_14_n_0),
        .O(ARG__0_carry__0_i_7_n_0));
  LUT6 #(
    .INIT(64'h17E8E817E81717E8)) 
    ARG__0_carry__0_i_8
       (.I0(ARG__0_carry_i_10_n_0),
        .I1(ARG__0_carry_i_8_n_0),
        .I2(ARG__0_carry_i_9_n_0),
        .I3(ARG__0_carry__0_i_16_n_0),
        .I4(ARG__0_carry__0_i_15_n_0),
        .I5(ARG__0_carry__0_i_17_n_0),
        .O(ARG__0_carry__0_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__0_carry__0_i_9
       (.I0(\x_n[7]__55 [4]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__0_carry__0_i_9_n_0));
  CARRY4 ARG__0_carry__1
       (.CI(ARG__0_carry__0_n_0),
        .CO({NLW_ARG__0_carry__1_CO_UNCONNECTED[3],ARG__0_carry__1_n_1,NLW_ARG__0_carry__1_CO_UNCONNECTED[1],ARG__0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,ARG__0_carry__1_i_1_n_0,ARG__0_carry__1_i_2_n_0}),
        .O({NLW_ARG__0_carry__1_O_UNCONNECTED[3:2],ARG__0_carry__1_n_6,ARG__0_carry__1_n_7}),
        .S({1'b0,1'b1,ARG__0_carry__1_i_3_n_0,ARG__0_carry__1_i_4_n_0}));
  LUT5 #(
    .INIT(32'h000001FF)) 
    ARG__0_carry__1_i_1
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I3(\x_n[7]__55 [7]),
        .I4(ARG__0_carry__1_i_5_n_0),
        .O(ARG__0_carry__1_i_1_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry__1_i_10
       (.I0(\x_n_reg[3] [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[2] [6]),
        .O(ARG__0_carry__1_i_10_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry__1_i_11
       (.I0(\x_n_reg[1] [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[0] [6]),
        .O(ARG__0_carry__1_i_11_n_0));
  LUT5 #(
    .INIT(32'h005757FF)) 
    ARG__0_carry__1_i_2
       (.I0(\x_n[7]__55 [7]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .I3(ARG__0_carry__0_i_20_n_0),
        .I4(ARG__0_carry__0_i_19_n_0),
        .O(ARG__0_carry__1_i_2_n_0));
  LUT6 #(
    .INIT(64'h0002FFFF5555FFFF)) 
    ARG__0_carry__1_i_3
       (.I0(\x_n[7]__55 [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\coef_n[7]__7 [2]),
        .I5(\x_n[7]__55 [7]),
        .O(ARG__0_carry__1_i_3_n_0));
  LUT6 #(
    .INIT(64'h8171FC0C1EEE3CCC)) 
    ARG__0_carry__1_i_4
       (.I0(\coef_n[7]__7 [0]),
        .I1(ARG__0_carry__0_i_20_n_0),
        .I2(\x_n[7]__55 [6]),
        .I3(\coef_n[7]__7 [2]),
        .I4(\x_n[7]__55 [7]),
        .I5(\coef_n[7]__7 [1]),
        .O(ARG__0_carry__1_i_4_n_0));
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__0_carry__1_i_5
       (.I0(\x_n[7]__55 [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__0_carry__1_i_5_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    ARG__0_carry__1_i_6
       (.I0(ARG__0_carry__1_i_8_n_0),
        .I1(ARG__0_carry__1_i_9_n_0),
        .I2(r_current_state_reg[2]),
        .I3(ARG__0_carry__1_i_10_n_0),
        .I4(r_current_state_reg[1]),
        .I5(ARG__0_carry__1_i_11_n_0),
        .O(\x_n[7]__55 [6]));
  LUT2 #(
    .INIT(4'hE)) 
    ARG__0_carry__1_i_7
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(\coef_n[7]__7 [0]));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry__1_i_8
       (.I0(\x_n_reg[7] [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[6] [6]),
        .O(ARG__0_carry__1_i_8_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry__1_i_9
       (.I0(\x_n_reg[5] [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[4] [6]),
        .O(ARG__0_carry__1_i_9_n_0));
  LUT3 #(
    .INIT(8'h69)) 
    ARG__0_carry_i_1
       (.I0(ARG__0_carry_i_8_n_0),
        .I1(ARG__0_carry_i_9_n_0),
        .I2(ARG__0_carry_i_10_n_0),
        .O(ARG__0_carry_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h57)) 
    ARG__0_carry_i_10
       (.I0(\x_n[7]__55 [3]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .O(ARG__0_carry_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h5557)) 
    ARG__0_carry_i_11
       (.I0(\x_n[7]__55 [1]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(ARG__0_carry_i_11_n_0));
  MUXF7 ARG__0_carry_i_12
       (.I0(ARG__0_carry_i_18_n_0),
        .I1(ARG__0_carry_i_19_n_0),
        .O(\x_n[7]__55 [0]),
        .S(r_current_state_reg[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    ARG__0_carry_i_13
       (.I0(ARG__0_carry_i_20_n_0),
        .I1(ARG__0_carry_i_21_n_0),
        .I2(r_current_state_reg[2]),
        .I3(ARG__0_carry_i_22_n_0),
        .I4(r_current_state_reg[1]),
        .I5(ARG__0_carry_i_24_n_0),
        .O(\x_n[7]__55 [1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    ARG__0_carry_i_14
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(\coef_n[7]__7 [1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    ARG__0_carry_i_15
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .O(\coef_n[7]__7 [2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    ARG__0_carry_i_16
       (.I0(ARG__0_carry_i_25_n_0),
        .I1(ARG__0_carry_i_26_n_0),
        .I2(r_current_state_reg[2]),
        .I3(ARG__0_carry_i_27_n_0),
        .I4(r_current_state_reg[1]),
        .I5(ARG__0_carry_i_28_n_0),
        .O(\x_n[7]__55 [2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    ARG__0_carry_i_17
       (.I0(ARG__0_carry_i_29_n_0),
        .I1(ARG__0_carry_i_30_n_0),
        .I2(r_current_state_reg[2]),
        .I3(ARG__0_carry_i_31_n_0),
        .I4(r_current_state_reg[1]),
        .I5(ARG__0_carry_i_32_n_0),
        .O(\x_n[7]__55 [3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    ARG__0_carry_i_18
       (.I0(\x_n_reg[3] [0]),
        .I1(\x_n_reg[2] [0]),
        .I2(r_current_state_reg[1]),
        .I3(\x_n_reg[1] [0]),
        .I4(r_current_state_reg[0]),
        .I5(\x_n_reg[0] [0]),
        .O(ARG__0_carry_i_18_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    ARG__0_carry_i_19
       (.I0(\x_n_reg[7] [0]),
        .I1(\x_n_reg[6] [0]),
        .I2(r_current_state_reg[1]),
        .I3(\x_n_reg[5] [0]),
        .I4(r_current_state_reg[0]),
        .I5(\x_n_reg[4] [0]),
        .O(ARG__0_carry_i_19_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAA955555555)) 
    ARG__0_carry_i_2
       (.I0(ARG__0_carry_i_11_n_0),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .I5(\x_n[7]__55 [0]),
        .O(ARG__0_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_20
       (.I0(\x_n_reg[7] [1]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[6] [1]),
        .O(ARG__0_carry_i_20_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_21
       (.I0(\x_n_reg[5] [1]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[4] [1]),
        .O(ARG__0_carry_i_21_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_22
       (.I0(\x_n_reg[3] [1]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[2] [1]),
        .O(ARG__0_carry_i_22_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    ARG__0_carry_i_23
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .O(r_current_state_reg[1]));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_24
       (.I0(\x_n_reg[1] [1]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[0] [1]),
        .O(ARG__0_carry_i_24_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_25
       (.I0(\x_n_reg[7] [2]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[6] [2]),
        .O(ARG__0_carry_i_25_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_26
       (.I0(\x_n_reg[5] [2]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[4] [2]),
        .O(ARG__0_carry_i_26_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_27
       (.I0(\x_n_reg[3] [2]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[2] [2]),
        .O(ARG__0_carry_i_27_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_28
       (.I0(\x_n_reg[1] [2]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[0] [2]),
        .O(ARG__0_carry_i_28_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_29
       (.I0(\x_n_reg[7] [3]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[6] [3]),
        .O(ARG__0_carry_i_29_n_0));
  LUT3 #(
    .INIT(8'hE0)) 
    ARG__0_carry_i_3
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\x_n[7]__55 [1]),
        .O(ARG__0_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_30
       (.I0(\x_n_reg[5] [3]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[4] [3]),
        .O(ARG__0_carry_i_30_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_31
       (.I0(\x_n_reg[3] [3]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[2] [3]),
        .O(ARG__0_carry_i_31_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__0_carry_i_32
       (.I0(\x_n_reg[1] [3]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[0] [3]),
        .O(ARG__0_carry_i_32_n_0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    ARG__0_carry_i_33
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .O(r_current_state_reg[0]));
  LUT6 #(
    .INIT(64'h6696969666666666)) 
    ARG__0_carry_i_4
       (.I0(ARG__0_carry_i_8_n_0),
        .I1(ARG__0_carry_i_10_n_0),
        .I2(\x_n[7]__55 [1]),
        .I3(\coef_n[7]__7 [1]),
        .I4(\x_n[7]__55 [0]),
        .I5(\coef_n[7]__7 [2]),
        .O(ARG__0_carry_i_4_n_0));
  LUT6 #(
    .INIT(64'h7878788787878787)) 
    ARG__0_carry_i_5
       (.I0(\x_n[7]__55 [0]),
        .I1(\coef_n[7]__7 [2]),
        .I2(ARG__0_carry_i_11_n_0),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I5(\x_n[7]__55 [2]),
        .O(ARG__0_carry_i_5_n_0));
  LUT6 #(
    .INIT(64'h37373738C8C8C8C8)) 
    ARG__0_carry_i_6
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .I1(\x_n[7]__55 [1]),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I5(\x_n[7]__55 [0]),
        .O(ARG__0_carry_i_6_n_0));
  LUT3 #(
    .INIT(8'hA8)) 
    ARG__0_carry_i_7
       (.I0(\x_n[7]__55 [0]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .O(ARG__0_carry_i_7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h5557)) 
    ARG__0_carry_i_8
       (.I0(\x_n[7]__55 [2]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(ARG__0_carry_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__0_carry_i_9
       (.I0(\x_n[7]__55 [1]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__0_carry_i_9_n_0));
  CARRY4 ARG__30_carry
       (.CI(1'b0),
        .CO({ARG__30_carry_n_0,ARG__30_carry_n_1,ARG__30_carry_n_2,ARG__30_carry_n_3}),
        .CYINIT(1'b0),
        .DI({ARG__30_carry_i_1_n_0,ARG__30_carry_i_2_n_0,ARG__30_carry_i_3_n_0,1'b0}),
        .O({ARG__30_carry_n_4,ARG__30_carry_n_5,ARG__30_carry_n_6,ARG__30_carry_n_7}),
        .S({ARG__30_carry_i_4_n_0,ARG__30_carry_i_5_n_0,ARG__30_carry_i_6_n_0,ARG__30_carry_i_7_n_0}));
  CARRY4 ARG__30_carry__0
       (.CI(ARG__30_carry_n_0),
        .CO({ARG__30_carry__0_n_0,ARG__30_carry__0_n_1,ARG__30_carry__0_n_2,ARG__30_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({ARG__30_carry__0_i_1_n_0,ARG__30_carry__0_i_2_n_0,ARG__30_carry__0_i_3_n_0,ARG__30_carry__0_i_4_n_0}),
        .O({ARG__30_carry__0_n_4,ARG__30_carry__0_n_5,ARG__30_carry__0_n_6,ARG__30_carry__0_n_7}),
        .S({ARG__30_carry__0_i_5_n_0,ARG__30_carry__0_i_6_n_0,ARG__30_carry__0_i_7_n_0,ARG__30_carry__0_i_8_n_0}));
  LUT6 #(
    .INIT(64'h8FFF088808880888)) 
    ARG__30_carry__0_i_1
       (.I0(r_current_state_reg[2]),
        .I1(\x_n[7]__55 [5]),
        .I2(\coef_n[7]__7 [5]),
        .I3(\x_n[7]__55 [4]),
        .I4(\coef_n[7]__7 [3]),
        .I5(\x_n[7]__55 [6]),
        .O(ARG__30_carry__0_i_1_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    ARG__30_carry__0_i_10
       (.I0(ARG__30_carry__0_i_27_n_0),
        .I1(ARG__30_carry__0_i_28_n_0),
        .I2(r_current_state_reg[2]),
        .I3(ARG__30_carry__0_i_29_n_0),
        .I4(r_current_state_reg[1]),
        .I5(ARG__30_carry__0_i_30_n_0),
        .O(\x_n[7]__55 [4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry__0_i_11
       (.I0(\x_n[7]__55 [4]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry__0_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h5557)) 
    ARG__30_carry__0_i_12
       (.I0(\x_n[7]__55 [3]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(ARG__30_carry__0_i_12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry__0_i_13
       (.I0(\x_n[7]__55 [5]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry__0_i_13_n_0));
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry__0_i_14
       (.I0(\x_n[7]__55 [3]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry__0_i_14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h5557)) 
    ARG__30_carry__0_i_15
       (.I0(\x_n[7]__55 [2]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(ARG__30_carry__0_i_15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry__0_i_16
       (.I0(\x_n[7]__55 [4]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry__0_i_16_n_0));
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry__0_i_17
       (.I0(\x_n[7]__55 [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry__0_i_17_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h5557)) 
    ARG__30_carry__0_i_18
       (.I0(\x_n[7]__55 [4]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(ARG__30_carry__0_i_18_n_0));
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry__0_i_19
       (.I0(\x_n[7]__55 [5]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry__0_i_19_n_0));
  (* HLUTNM = "lutpair1" *) 
  LUT3 #(
    .INIT(8'h4D)) 
    ARG__30_carry__0_i_2
       (.I0(ARG__30_carry__0_i_11_n_0),
        .I1(ARG__30_carry__0_i_12_n_0),
        .I2(ARG__30_carry__0_i_13_n_0),
        .O(ARG__30_carry__0_i_2_n_0));
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry__0_i_20
       (.I0(\x_n[7]__55 [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry__0_i_20_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h5557)) 
    ARG__30_carry__0_i_21
       (.I0(\x_n[7]__55 [5]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .O(ARG__30_carry__0_i_21_n_0));
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry__0_i_22
       (.I0(\x_n[7]__55 [7]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry__0_i_22_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__30_carry__0_i_23
       (.I0(\x_n_reg[7] [5]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[6] [5]),
        .O(ARG__30_carry__0_i_23_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__30_carry__0_i_24
       (.I0(\x_n_reg[5] [5]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[4] [5]),
        .O(ARG__30_carry__0_i_24_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__30_carry__0_i_25
       (.I0(\x_n_reg[3] [5]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[2] [5]),
        .O(ARG__30_carry__0_i_25_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__30_carry__0_i_26
       (.I0(\x_n_reg[1] [5]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[0] [5]),
        .O(ARG__30_carry__0_i_26_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__30_carry__0_i_27
       (.I0(\x_n_reg[7] [4]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[6] [4]),
        .O(ARG__30_carry__0_i_27_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__30_carry__0_i_28
       (.I0(\x_n_reg[5] [4]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[4] [4]),
        .O(ARG__30_carry__0_i_28_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__30_carry__0_i_29
       (.I0(\x_n_reg[3] [4]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[2] [4]),
        .O(ARG__30_carry__0_i_29_n_0));
  (* HLUTNM = "lutpair0" *) 
  LUT3 #(
    .INIT(8'h4D)) 
    ARG__30_carry__0_i_3
       (.I0(ARG__30_carry__0_i_14_n_0),
        .I1(ARG__30_carry__0_i_15_n_0),
        .I2(ARG__30_carry__0_i_16_n_0),
        .O(ARG__30_carry__0_i_3_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
    ARG__30_carry__0_i_30
       (.I0(\x_n_reg[1] [4]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .I5(\x_n_reg[0] [4]),
        .O(ARG__30_carry__0_i_30_n_0));
  LUT6 #(
    .INIT(64'h000055575557FFFF)) 
    ARG__30_carry__0_i_4
       (.I0(\x_n[7]__55 [1]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(ARG__30_carry_i_9_n_0),
        .I5(ARG__30_carry_i_8_n_0),
        .O(ARG__30_carry__0_i_4_n_0));
  LUT6 #(
    .INIT(64'h4DB2B24DB24D4DB2)) 
    ARG__30_carry__0_i_5
       (.I0(ARG__30_carry__0_i_17_n_0),
        .I1(ARG__30_carry__0_i_18_n_0),
        .I2(ARG__30_carry__0_i_19_n_0),
        .I3(ARG__30_carry__0_i_20_n_0),
        .I4(ARG__30_carry__0_i_21_n_0),
        .I5(ARG__30_carry__0_i_22_n_0),
        .O(ARG__30_carry__0_i_5_n_0));
  LUT4 #(
    .INIT(16'h6996)) 
    ARG__30_carry__0_i_6
       (.I0(ARG__30_carry__0_i_2_n_0),
        .I1(ARG__30_carry__0_i_19_n_0),
        .I2(ARG__30_carry__0_i_18_n_0),
        .I3(ARG__30_carry__0_i_17_n_0),
        .O(ARG__30_carry__0_i_6_n_0));
  (* HLUTNM = "lutpair1" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    ARG__30_carry__0_i_7
       (.I0(ARG__30_carry__0_i_11_n_0),
        .I1(ARG__30_carry__0_i_12_n_0),
        .I2(ARG__30_carry__0_i_13_n_0),
        .I3(ARG__30_carry__0_i_3_n_0),
        .O(ARG__30_carry__0_i_7_n_0));
  (* HLUTNM = "lutpair0" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    ARG__30_carry__0_i_8
       (.I0(ARG__30_carry__0_i_14_n_0),
        .I1(ARG__30_carry__0_i_15_n_0),
        .I2(ARG__30_carry__0_i_16_n_0),
        .I3(ARG__30_carry__0_i_4_n_0),
        .O(ARG__30_carry__0_i_8_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    ARG__30_carry__0_i_9
       (.I0(ARG__30_carry__0_i_23_n_0),
        .I1(ARG__30_carry__0_i_24_n_0),
        .I2(r_current_state_reg[2]),
        .I3(ARG__30_carry__0_i_25_n_0),
        .I4(r_current_state_reg[1]),
        .I5(ARG__30_carry__0_i_26_n_0),
        .O(\x_n[7]__55 [5]));
  CARRY4 ARG__30_carry__1
       (.CI(ARG__30_carry__0_n_0),
        .CO({NLW_ARG__30_carry__1_CO_UNCONNECTED[3:2],ARG__30_carry__1_n_2,ARG__30_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,ARG__30_carry__1_i_1_n_0,ARG__30_carry__1_i_2_n_0}),
        .O({NLW_ARG__30_carry__1_O_UNCONNECTED[3],ARG__30_carry__1_n_5,ARG__30_carry__1_n_6,ARG__30_carry__1_n_7}),
        .S({1'b0,1'b1,ARG__30_carry__1_i_3_n_0,ARG__30_carry__1_i_4_n_0}));
  LUT6 #(
    .INIT(64'h0000000355575557)) 
    ARG__30_carry__1_i_1
       (.I0(\x_n[7]__55 [6]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .I5(\x_n[7]__55 [7]),
        .O(ARG__30_carry__1_i_1_n_0));
  LUT3 #(
    .INIT(8'hD4)) 
    ARG__30_carry__1_i_2
       (.I0(ARG__30_carry__0_i_20_n_0),
        .I1(ARG__30_carry__0_i_21_n_0),
        .I2(ARG__30_carry__0_i_22_n_0),
        .O(ARG__30_carry__1_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFF53333333F)) 
    ARG__30_carry__1_i_3
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .I1(\x_n[7]__55 [6]),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I5(\x_n[7]__55 [7]),
        .O(ARG__30_carry__1_i_3_n_0));
  LUT6 #(
    .INIT(64'hDB2B0CFCB4443CCC)) 
    ARG__30_carry__1_i_4
       (.I0(\coef_n[7]__7 [3]),
        .I1(ARG__30_carry__0_i_21_n_0),
        .I2(\x_n[7]__55 [6]),
        .I3(\coef_n[7]__7 [5]),
        .I4(\x_n[7]__55 [7]),
        .I5(r_current_state_reg[2]),
        .O(ARG__30_carry__1_i_4_n_0));
  LUT6 #(
    .INIT(64'h5557AAA8AAA85557)) 
    ARG__30_carry_i_1
       (.I0(\x_n[7]__55 [1]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(ARG__30_carry_i_8_n_0),
        .I5(ARG__30_carry_i_9_n_0),
        .O(ARG__30_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    ARG__30_carry_i_10
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .O(r_current_state_reg[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    ARG__30_carry_i_11
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(\coef_n[7]__7 [5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    ARG__30_carry_i_12
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .O(\coef_n[7]__7 [3]));
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry_i_13
       (.I0(\x_n[7]__55 [1]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry_i_13_n_0));
  LUT6 #(
    .INIT(64'hAAA85557AAAB5557)) 
    ARG__30_carry_i_2
       (.I0(\x_n[7]__55 [0]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\x_n[7]__55 [1]),
        .I5(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .O(ARG__30_carry_i_2_n_0));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    ARG__30_carry_i_3
       (.I0(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I4(\x_n[7]__55 [1]),
        .O(ARG__30_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h6969996969996999)) 
    ARG__30_carry_i_4
       (.I0(ARG__30_carry_i_9_n_0),
        .I1(ARG__30_carry_i_8_n_0),
        .I2(\x_n[7]__55 [1]),
        .I3(r_current_state_reg[2]),
        .I4(\x_n[7]__55 [0]),
        .I5(\coef_n[7]__7 [5]),
        .O(ARG__30_carry_i_4_n_0));
  LUT6 #(
    .INIT(64'h7888877787778777)) 
    ARG__30_carry_i_5
       (.I0(\x_n[7]__55 [0]),
        .I1(\coef_n[7]__7 [5]),
        .I2(\x_n[7]__55 [1]),
        .I3(r_current_state_reg[2]),
        .I4(\coef_n[7]__7 [3]),
        .I5(\x_n[7]__55 [2]),
        .O(ARG__30_carry_i_5_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAA955555555)) 
    ARG__30_carry_i_6
       (.I0(ARG__30_carry_i_13_n_0),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .I5(\x_n[7]__55 [0]),
        .O(ARG__30_carry_i_6_n_0));
  LUT5 #(
    .INIT(32'hAAAAAAA8)) 
    ARG__30_carry_i_7
       (.I0(\x_n[7]__55 [0]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry_i_7_n_0));
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry_i_8
       (.I0(\x_n[7]__55 [3]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry_i_8_n_0));
  LUT5 #(
    .INIT(32'h55555557)) 
    ARG__30_carry_i_9
       (.I0(\x_n[7]__55 [2]),
        .I1(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .I2(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .O(ARG__30_carry_i_9_n_0));
  CARRY4 ARG__59_carry
       (.CI(1'b0),
        .CO({ARG__59_carry_n_0,ARG__59_carry_n_1,ARG__59_carry_n_2,ARG__59_carry_n_3}),
        .CYINIT(1'b0),
        .DI({ARG__30_carry_n_5,ARG__0_carry__0_n_6,ARG__0_carry__0_n_7,ARG__0_carry_n_4}),
        .O({ARG[6:4],NLW_ARG__59_carry_O_UNCONNECTED[0]}),
        .S({ARG__59_carry_i_1_n_0,ARG__59_carry_i_2_n_0,ARG__59_carry_i_3_n_0,ARG__59_carry_i_4_n_0}));
  CARRY4 ARG__59_carry__0
       (.CI(ARG__59_carry_n_0),
        .CO({ARG__59_carry__0_n_0,ARG__59_carry__0_n_1,ARG__59_carry__0_n_2,ARG__59_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({ARG__59_carry__0_i_1_n_0,ARG__59_carry__0_i_2_n_0,ARG__59_carry__0_i_3_n_0,ARG__59_carry__0_i_4_n_0}),
        .O(ARG[10:7]),
        .S({ARG__59_carry__0_i_5_n_0,ARG__59_carry__0_i_6_n_0,ARG__59_carry__0_i_7_n_0,ARG__59_carry__0_i_8_n_0}));
  LUT2 #(
    .INIT(4'h8)) 
    ARG__59_carry__0_i_1
       (.I0(ARG__30_carry__0_n_5),
        .I1(ARG__0_carry__1_n_6),
        .O(ARG__59_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    ARG__59_carry__0_i_2
       (.I0(ARG__30_carry__0_n_6),
        .I1(ARG__0_carry__1_n_7),
        .O(ARG__59_carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    ARG__59_carry__0_i_3
       (.I0(ARG__0_carry__0_n_4),
        .I1(ARG__30_carry__0_n_7),
        .O(ARG__59_carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    ARG__59_carry__0_i_4
       (.I0(ARG__30_carry__0_n_7),
        .I1(ARG__0_carry__0_n_4),
        .O(ARG__59_carry__0_i_4_n_0));
  LUT4 #(
    .INIT(16'h8778)) 
    ARG__59_carry__0_i_5
       (.I0(ARG__0_carry__1_n_6),
        .I1(ARG__30_carry__0_n_5),
        .I2(ARG__30_carry__0_n_4),
        .I3(ARG__0_carry__1_n_1),
        .O(ARG__59_carry__0_i_5_n_0));
  LUT4 #(
    .INIT(16'h8778)) 
    ARG__59_carry__0_i_6
       (.I0(ARG__0_carry__1_n_7),
        .I1(ARG__30_carry__0_n_6),
        .I2(ARG__30_carry__0_n_5),
        .I3(ARG__0_carry__1_n_6),
        .O(ARG__59_carry__0_i_6_n_0));
  LUT4 #(
    .INIT(16'hE11E)) 
    ARG__59_carry__0_i_7
       (.I0(ARG__30_carry__0_n_7),
        .I1(ARG__0_carry__0_n_4),
        .I2(ARG__30_carry__0_n_6),
        .I3(ARG__0_carry__1_n_7),
        .O(ARG__59_carry__0_i_7_n_0));
  LUT4 #(
    .INIT(16'h6999)) 
    ARG__59_carry__0_i_8
       (.I0(ARG__30_carry__0_n_7),
        .I1(ARG__0_carry__0_n_4),
        .I2(ARG__0_carry__0_n_5),
        .I3(ARG__30_carry_n_4),
        .O(ARG__59_carry__0_i_8_n_0));
  CARRY4 ARG__59_carry__1
       (.CI(ARG__59_carry__0_n_0),
        .CO({NLW_ARG__59_carry__1_CO_UNCONNECTED[3:2],ARG__59_carry__1_n_2,ARG__59_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,ARG__30_carry__1_n_7}),
        .O({NLW_ARG__59_carry__1_O_UNCONNECTED[3],ARG[13:11]}),
        .S({1'b0,ARG__30_carry__1_n_5,ARG__30_carry__1_n_6,ARG__59_carry__1_i_1_n_0}));
  LUT3 #(
    .INIT(8'h78)) 
    ARG__59_carry__1_i_1
       (.I0(ARG__0_carry__1_n_1),
        .I1(ARG__30_carry__0_n_4),
        .I2(ARG__30_carry__1_n_7),
        .O(ARG__59_carry__1_i_1_n_0));
  LUT3 #(
    .INIT(8'h96)) 
    ARG__59_carry_i_1
       (.I0(ARG__30_carry_n_5),
        .I1(ARG__30_carry_n_4),
        .I2(ARG__0_carry__0_n_5),
        .O(ARG__59_carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    ARG__59_carry_i_2
       (.I0(ARG__30_carry_n_5),
        .I1(ARG__0_carry__0_n_6),
        .O(ARG__59_carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ARG__59_carry_i_3
       (.I0(ARG__0_carry__0_n_7),
        .I1(ARG__30_carry_n_6),
        .O(ARG__59_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ARG__59_carry_i_4
       (.I0(ARG__0_carry_n_4),
        .I1(ARG__30_carry_n_7),
        .O(ARG__59_carry_i_4_n_0));
  (* FSM_ENCODED_STATES = "coef_0:00000010,coef_1:00000100,coef_2:00001000,coef_3:00010000,coef_4:00100000,coef_5:01000000,coef_6:10000000,coef_7:00000001" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_r_current_state_reg[0] 
       (.C(clk_100M),
        .CE(E),
        .D(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .Q(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .S(SR));
  (* FSM_ENCODED_STATES = "coef_0:00000010,coef_1:00000100,coef_2:00001000,coef_3:00010000,coef_4:00100000,coef_5:01000000,coef_6:10000000,coef_7:00000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_r_current_state_reg[1] 
       (.C(clk_100M),
        .CE(E),
        .D(\FSM_onehot_r_current_state_reg_n_0_[0] ),
        .Q(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .R(SR));
  (* FSM_ENCODED_STATES = "coef_0:00000010,coef_1:00000100,coef_2:00001000,coef_3:00010000,coef_4:00100000,coef_5:01000000,coef_6:10000000,coef_7:00000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_r_current_state_reg[2] 
       (.C(clk_100M),
        .CE(E),
        .D(\FSM_onehot_r_current_state_reg_n_0_[1] ),
        .Q(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .R(SR));
  (* FSM_ENCODED_STATES = "coef_0:00000010,coef_1:00000100,coef_2:00001000,coef_3:00010000,coef_4:00100000,coef_5:01000000,coef_6:10000000,coef_7:00000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_r_current_state_reg[3] 
       (.C(clk_100M),
        .CE(E),
        .D(\FSM_onehot_r_current_state_reg_n_0_[2] ),
        .Q(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .R(SR));
  (* FSM_ENCODED_STATES = "coef_0:00000010,coef_1:00000100,coef_2:00001000,coef_3:00010000,coef_4:00100000,coef_5:01000000,coef_6:10000000,coef_7:00000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_r_current_state_reg[4] 
       (.C(clk_100M),
        .CE(E),
        .D(\FSM_onehot_r_current_state_reg_n_0_[3] ),
        .Q(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .R(SR));
  (* FSM_ENCODED_STATES = "coef_0:00000010,coef_1:00000100,coef_2:00001000,coef_3:00010000,coef_4:00100000,coef_5:01000000,coef_6:10000000,coef_7:00000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_r_current_state_reg[5] 
       (.C(clk_100M),
        .CE(E),
        .D(\FSM_onehot_r_current_state_reg_n_0_[4] ),
        .Q(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .R(SR));
  (* FSM_ENCODED_STATES = "coef_0:00000010,coef_1:00000100,coef_2:00001000,coef_3:00010000,coef_4:00100000,coef_5:01000000,coef_6:10000000,coef_7:00000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_r_current_state_reg[6] 
       (.C(clk_100M),
        .CE(E),
        .D(\FSM_onehot_r_current_state_reg_n_0_[5] ),
        .Q(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .R(SR));
  (* FSM_ENCODED_STATES = "coef_0:00000010,coef_1:00000100,coef_2:00001000,coef_3:00010000,coef_4:00100000,coef_5:01000000,coef_6:10000000,coef_7:00000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_r_current_state_reg[7] 
       (.C(clk_100M),
        .CE(E),
        .D(\FSM_onehot_r_current_state_reg_n_0_[6] ),
        .Q(\FSM_onehot_r_current_state_reg_n_0_[7] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    o_filter_rdy_reg
       (.C(CLK),
        .CE(E),
        .D(r_filter_rdy),
        .Q(o_filter_rdy),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    o_reset_ack_reg
       (.C(CLK),
        .CE(1'b1),
        .D(SR),
        .Q(o_reset_ack),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[0] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[0]),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[10] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[10]),
        .Q(Q[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[11] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[11]),
        .Q(Q[11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[12] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[12]),
        .Q(Q[12]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[13] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[13]),
        .Q(Q[13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[14] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[14]),
        .Q(Q[14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[15] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[15]),
        .Q(Q[15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[1] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[1]),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[2] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[2]),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[3] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[3]),
        .Q(Q[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[4] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[4]),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[5] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[5]),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[6] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[6]),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[7] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[7]),
        .Q(Q[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[8] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[8]),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \o_small_filter_reg[9] 
       (.C(CLK),
        .CE(E),
        .D(r_small_filter_out[9]),
        .Q(Q[9]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    r_fast_rising_detector_reg
       (.C(clk_100M),
        .CE(E),
        .D(r_rising_detector),
        .Q(r_fast_rising_detector),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    r_filter_rdy_reg
       (.C(CLK),
        .CE(E),
        .D(i_signal_rdy),
        .Q(r_filter_rdy),
        .R(SR));
  LUT1 #(
    .INIT(2'h1)) 
    r_rising_detector_i_1
       (.I0(r_rising_detector),
        .O(p_0_in));
  FDRE #(
    .INIT(1'b0)) 
    r_rising_detector_reg
       (.C(CLK),
        .CE(E),
        .D(p_0_in),
        .Q(r_rising_detector),
        .R(SR));
  CARRY4 r_small_filter_out_carry
       (.CI(1'b0),
        .CO({r_small_filter_out_carry_n_0,r_small_filter_out_carry_n_1,r_small_filter_out_carry_n_2,r_small_filter_out_carry_n_3}),
        .CYINIT(1'b0),
        .DI({C,ARG[2:0]}),
        .O(r_small_filter_out[3:0]),
        .S({r_small_filter_out_carry_i_2_n_0,r_small_filter_out_carry_i_3_n_0,r_small_filter_out_carry_i_4_n_0,r_small_filter_out_carry_i_5_n_0}));
  CARRY4 r_small_filter_out_carry__0
       (.CI(r_small_filter_out_carry_n_0),
        .CO({r_small_filter_out_carry__0_n_0,r_small_filter_out_carry__0_n_1,r_small_filter_out_carry__0_n_2,r_small_filter_out_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(ARG[7:4]),
        .O(r_small_filter_out[7:4]),
        .S({r_small_filter_out_carry__0_i_1_n_0,r_small_filter_out_carry__0_i_2_n_0,r_small_filter_out_carry__0_i_3_n_0,r_small_filter_out_carry__0_i_4_n_0}));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry__0_i_1
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[7]),
        .I3(ARG[7]),
        .O(r_small_filter_out_carry__0_i_1_n_0));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry__0_i_2
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[6]),
        .I3(ARG[6]),
        .O(r_small_filter_out_carry__0_i_2_n_0));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry__0_i_3
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[5]),
        .I3(ARG[5]),
        .O(r_small_filter_out_carry__0_i_3_n_0));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry__0_i_4
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[4]),
        .I3(ARG[4]),
        .O(r_small_filter_out_carry__0_i_4_n_0));
  CARRY4 r_small_filter_out_carry__1
       (.CI(r_small_filter_out_carry__0_n_0),
        .CO({r_small_filter_out_carry__1_n_0,r_small_filter_out_carry__1_n_1,r_small_filter_out_carry__1_n_2,r_small_filter_out_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI(ARG[11:8]),
        .O(r_small_filter_out[11:8]),
        .S({r_small_filter_out_carry__1_i_1_n_0,r_small_filter_out_carry__1_i_2_n_0,r_small_filter_out_carry__1_i_3_n_0,r_small_filter_out_carry__1_i_4_n_0}));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry__1_i_1
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[11]),
        .I3(ARG[11]),
        .O(r_small_filter_out_carry__1_i_1_n_0));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry__1_i_2
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[10]),
        .I3(ARG[10]),
        .O(r_small_filter_out_carry__1_i_2_n_0));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry__1_i_3
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[9]),
        .I3(ARG[9]),
        .O(r_small_filter_out_carry__1_i_3_n_0));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry__1_i_4
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[8]),
        .I3(ARG[8]),
        .O(r_small_filter_out_carry__1_i_4_n_0));
  CARRY4 r_small_filter_out_carry__2
       (.CI(r_small_filter_out_carry__1_n_0),
        .CO({NLW_r_small_filter_out_carry__2_CO_UNCONNECTED[3],r_small_filter_out_carry__2_n_1,r_small_filter_out_carry__2_n_2,r_small_filter_out_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,r_small_filter_out_carry__2_i_1_n_0,ARG[13:12]}),
        .O(r_small_filter_out[15:12]),
        .S({r_small_filter_out_carry__2_i_2_n_0,r_small_filter_out_carry__2_i_3_n_0,r_small_filter_out_carry__2_i_4_n_0,r_small_filter_out_carry__2_i_5_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    r_small_filter_out_carry__2_i_1
       (.I0(ARG[13]),
        .O(r_small_filter_out_carry__2_i_1_n_0));
  LUT4 #(
    .INIT(16'hBE7D)) 
    r_small_filter_out_carry__2_i_2
       (.I0(w_filter_feedback_reg[14]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[15]),
        .O(r_small_filter_out_carry__2_i_2_n_0));
  LUT4 #(
    .INIT(16'h69AA)) 
    r_small_filter_out_carry__2_i_3
       (.I0(ARG[13]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[14]),
        .O(r_small_filter_out_carry__2_i_3_n_0));
  LUT4 #(
    .INIT(16'h69AA)) 
    r_small_filter_out_carry__2_i_4
       (.I0(ARG[13]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[13]),
        .O(r_small_filter_out_carry__2_i_4_n_0));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry__2_i_5
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[12]),
        .I3(ARG[12]),
        .O(r_small_filter_out_carry__2_i_5_n_0));
  LUT3 #(
    .INIT(8'h82)) 
    r_small_filter_out_carry_i_1
       (.I0(w_filter_feedback_reg[3]),
        .I1(r_fast_rising_detector),
        .I2(r_rising_detector),
        .O(C));
  LUT5 #(
    .INIT(32'h906F6F90)) 
    r_small_filter_out_carry_i_2
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[3]),
        .I3(ARG__30_carry_n_7),
        .I4(ARG__0_carry_n_4),
        .O(r_small_filter_out_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry_i_3
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[2]),
        .I3(ARG[2]),
        .O(r_small_filter_out_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry_i_4
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[1]),
        .I3(ARG[1]),
        .O(r_small_filter_out_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h6F90)) 
    r_small_filter_out_carry_i_5
       (.I0(r_rising_detector),
        .I1(r_fast_rising_detector),
        .I2(w_filter_feedback_reg[0]),
        .I3(ARG[0]),
        .O(r_small_filter_out_carry_i_5_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    \w_filter_feedback[0]_i_2 
       (.I0(ARG__0_carry_n_4),
        .I1(ARG__30_carry_n_7),
        .O(ARG[3]));
  LUT5 #(
    .INIT(32'h96696666)) 
    \w_filter_feedback[0]_i_3 
       (.I0(ARG__30_carry_n_7),
        .I1(ARG__0_carry_n_4),
        .I2(r_rising_detector),
        .I3(r_fast_rising_detector),
        .I4(w_filter_feedback_reg[3]),
        .O(\w_filter_feedback[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[0]_i_4 
       (.I0(ARG[2]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[2]),
        .O(\w_filter_feedback[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[0]_i_5 
       (.I0(ARG[1]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[1]),
        .O(\w_filter_feedback[0]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[0]_i_6 
       (.I0(ARG[0]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[0]),
        .O(\w_filter_feedback[0]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[12]_i_2 
       (.I0(ARG[13]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[15]),
        .O(\w_filter_feedback[12]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[12]_i_3 
       (.I0(ARG[13]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[14]),
        .O(\w_filter_feedback[12]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[12]_i_4 
       (.I0(ARG[13]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[13]),
        .O(\w_filter_feedback[12]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[12]_i_5 
       (.I0(ARG[12]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[12]),
        .O(\w_filter_feedback[12]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[4]_i_2 
       (.I0(ARG[7]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[7]),
        .O(\w_filter_feedback[4]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[4]_i_3 
       (.I0(ARG[6]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[6]),
        .O(\w_filter_feedback[4]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[4]_i_4 
       (.I0(ARG[5]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[5]),
        .O(\w_filter_feedback[4]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[4]_i_5 
       (.I0(ARG[4]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[4]),
        .O(\w_filter_feedback[4]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[8]_i_2 
       (.I0(ARG[11]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[11]),
        .O(\w_filter_feedback[8]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[8]_i_3 
       (.I0(ARG[10]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[10]),
        .O(\w_filter_feedback[8]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[8]_i_4 
       (.I0(ARG[9]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[9]),
        .O(\w_filter_feedback[8]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h69AA)) 
    \w_filter_feedback[8]_i_5 
       (.I0(ARG[8]),
        .I1(r_rising_detector),
        .I2(r_fast_rising_detector),
        .I3(w_filter_feedback_reg[8]),
        .O(\w_filter_feedback[8]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[0] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[0]_i_1_n_7 ),
        .Q(w_filter_feedback_reg[0]),
        .R(SR));
  CARRY4 \w_filter_feedback_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\w_filter_feedback_reg[0]_i_1_n_0 ,\w_filter_feedback_reg[0]_i_1_n_1 ,\w_filter_feedback_reg[0]_i_1_n_2 ,\w_filter_feedback_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(ARG[3:0]),
        .O({\w_filter_feedback_reg[0]_i_1_n_4 ,\w_filter_feedback_reg[0]_i_1_n_5 ,\w_filter_feedback_reg[0]_i_1_n_6 ,\w_filter_feedback_reg[0]_i_1_n_7 }),
        .S({\w_filter_feedback[0]_i_3_n_0 ,\w_filter_feedback[0]_i_4_n_0 ,\w_filter_feedback[0]_i_5_n_0 ,\w_filter_feedback[0]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[10] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[8]_i_1_n_5 ),
        .Q(w_filter_feedback_reg[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[11] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[8]_i_1_n_4 ),
        .Q(w_filter_feedback_reg[11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[12] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[12]_i_1_n_7 ),
        .Q(w_filter_feedback_reg[12]),
        .R(SR));
  CARRY4 \w_filter_feedback_reg[12]_i_1 
       (.CI(\w_filter_feedback_reg[8]_i_1_n_0 ),
        .CO({\NLW_w_filter_feedback_reg[12]_i_1_CO_UNCONNECTED [3],\w_filter_feedback_reg[12]_i_1_n_1 ,\w_filter_feedback_reg[12]_i_1_n_2 ,\w_filter_feedback_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,ARG[13],ARG[13:12]}),
        .O({\w_filter_feedback_reg[12]_i_1_n_4 ,\w_filter_feedback_reg[12]_i_1_n_5 ,\w_filter_feedback_reg[12]_i_1_n_6 ,\w_filter_feedback_reg[12]_i_1_n_7 }),
        .S({\w_filter_feedback[12]_i_2_n_0 ,\w_filter_feedback[12]_i_3_n_0 ,\w_filter_feedback[12]_i_4_n_0 ,\w_filter_feedback[12]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[13] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[12]_i_1_n_6 ),
        .Q(w_filter_feedback_reg[13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[14] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[12]_i_1_n_5 ),
        .Q(w_filter_feedback_reg[14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[15] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[12]_i_1_n_4 ),
        .Q(w_filter_feedback_reg[15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[1] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[0]_i_1_n_6 ),
        .Q(w_filter_feedback_reg[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[2] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[0]_i_1_n_5 ),
        .Q(w_filter_feedback_reg[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[3] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[0]_i_1_n_4 ),
        .Q(w_filter_feedback_reg[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[4] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[4]_i_1_n_7 ),
        .Q(w_filter_feedback_reg[4]),
        .R(SR));
  CARRY4 \w_filter_feedback_reg[4]_i_1 
       (.CI(\w_filter_feedback_reg[0]_i_1_n_0 ),
        .CO({\w_filter_feedback_reg[4]_i_1_n_0 ,\w_filter_feedback_reg[4]_i_1_n_1 ,\w_filter_feedback_reg[4]_i_1_n_2 ,\w_filter_feedback_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(ARG[7:4]),
        .O({\w_filter_feedback_reg[4]_i_1_n_4 ,\w_filter_feedback_reg[4]_i_1_n_5 ,\w_filter_feedback_reg[4]_i_1_n_6 ,\w_filter_feedback_reg[4]_i_1_n_7 }),
        .S({\w_filter_feedback[4]_i_2_n_0 ,\w_filter_feedback[4]_i_3_n_0 ,\w_filter_feedback[4]_i_4_n_0 ,\w_filter_feedback[4]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[5] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[4]_i_1_n_6 ),
        .Q(w_filter_feedback_reg[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[6] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[4]_i_1_n_5 ),
        .Q(w_filter_feedback_reg[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[7] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[4]_i_1_n_4 ),
        .Q(w_filter_feedback_reg[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[8] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[8]_i_1_n_7 ),
        .Q(w_filter_feedback_reg[8]),
        .R(SR));
  CARRY4 \w_filter_feedback_reg[8]_i_1 
       (.CI(\w_filter_feedback_reg[4]_i_1_n_0 ),
        .CO({\w_filter_feedback_reg[8]_i_1_n_0 ,\w_filter_feedback_reg[8]_i_1_n_1 ,\w_filter_feedback_reg[8]_i_1_n_2 ,\w_filter_feedback_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(ARG[11:8]),
        .O({\w_filter_feedback_reg[8]_i_1_n_4 ,\w_filter_feedback_reg[8]_i_1_n_5 ,\w_filter_feedback_reg[8]_i_1_n_6 ,\w_filter_feedback_reg[8]_i_1_n_7 }),
        .S({\w_filter_feedback[8]_i_2_n_0 ,\w_filter_feedback[8]_i_3_n_0 ,\w_filter_feedback[8]_i_4_n_0 ,\w_filter_feedback[8]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \w_filter_feedback_reg[9] 
       (.C(clk_100M),
        .CE(E),
        .D(\w_filter_feedback_reg[8]_i_1_n_6 ),
        .Q(w_filter_feedback_reg[9]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[0][0] 
       (.C(CLK),
        .CE(E),
        .D(D[0]),
        .Q(\x_n_reg[0] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[0][1] 
       (.C(CLK),
        .CE(E),
        .D(D[1]),
        .Q(\x_n_reg[0] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[0][2] 
       (.C(CLK),
        .CE(E),
        .D(D[2]),
        .Q(\x_n_reg[0] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[0][3] 
       (.C(CLK),
        .CE(E),
        .D(D[3]),
        .Q(\x_n_reg[0] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[0][4] 
       (.C(CLK),
        .CE(E),
        .D(D[4]),
        .Q(\x_n_reg[0] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[0][5] 
       (.C(CLK),
        .CE(E),
        .D(D[5]),
        .Q(\x_n_reg[0] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[0][6] 
       (.C(CLK),
        .CE(E),
        .D(D[6]),
        .Q(\x_n_reg[0] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[0][7] 
       (.C(CLK),
        .CE(E),
        .D(D[7]),
        .Q(\x_n_reg[0] [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[1][0] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[0] [0]),
        .Q(\x_n_reg[1] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[1][1] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[0] [1]),
        .Q(\x_n_reg[1] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[1][2] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[0] [2]),
        .Q(\x_n_reg[1] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[1][3] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[0] [3]),
        .Q(\x_n_reg[1] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[1][4] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[0] [4]),
        .Q(\x_n_reg[1] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[1][5] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[0] [5]),
        .Q(\x_n_reg[1] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[1][6] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[0] [6]),
        .Q(\x_n_reg[1] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[1][7] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[0] [7]),
        .Q(\x_n_reg[1] [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[2][0] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[1] [0]),
        .Q(\x_n_reg[2] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[2][1] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[1] [1]),
        .Q(\x_n_reg[2] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[2][2] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[1] [2]),
        .Q(\x_n_reg[2] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[2][3] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[1] [3]),
        .Q(\x_n_reg[2] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[2][4] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[1] [4]),
        .Q(\x_n_reg[2] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[2][5] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[1] [5]),
        .Q(\x_n_reg[2] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[2][6] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[1] [6]),
        .Q(\x_n_reg[2] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[2][7] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[1] [7]),
        .Q(\x_n_reg[2] [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[3][0] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[2] [0]),
        .Q(\x_n_reg[3] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[3][1] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[2] [1]),
        .Q(\x_n_reg[3] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[3][2] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[2] [2]),
        .Q(\x_n_reg[3] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[3][3] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[2] [3]),
        .Q(\x_n_reg[3] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[3][4] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[2] [4]),
        .Q(\x_n_reg[3] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[3][5] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[2] [5]),
        .Q(\x_n_reg[3] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[3][6] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[2] [6]),
        .Q(\x_n_reg[3] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[3][7] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[2] [7]),
        .Q(\x_n_reg[3] [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[4][0] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[3] [0]),
        .Q(\x_n_reg[4] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[4][1] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[3] [1]),
        .Q(\x_n_reg[4] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[4][2] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[3] [2]),
        .Q(\x_n_reg[4] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[4][3] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[3] [3]),
        .Q(\x_n_reg[4] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[4][4] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[3] [4]),
        .Q(\x_n_reg[4] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[4][5] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[3] [5]),
        .Q(\x_n_reg[4] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[4][6] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[3] [6]),
        .Q(\x_n_reg[4] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[4][7] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[3] [7]),
        .Q(\x_n_reg[4] [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[5][0] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[4] [0]),
        .Q(\x_n_reg[5] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[5][1] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[4] [1]),
        .Q(\x_n_reg[5] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[5][2] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[4] [2]),
        .Q(\x_n_reg[5] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[5][3] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[4] [3]),
        .Q(\x_n_reg[5] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[5][4] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[4] [4]),
        .Q(\x_n_reg[5] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[5][5] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[4] [5]),
        .Q(\x_n_reg[5] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[5][6] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[4] [6]),
        .Q(\x_n_reg[5] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[5][7] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[4] [7]),
        .Q(\x_n_reg[5] [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[6][0] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[5] [0]),
        .Q(\x_n_reg[6] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[6][1] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[5] [1]),
        .Q(\x_n_reg[6] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[6][2] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[5] [2]),
        .Q(\x_n_reg[6] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[6][3] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[5] [3]),
        .Q(\x_n_reg[6] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[6][4] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[5] [4]),
        .Q(\x_n_reg[6] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[6][5] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[5] [5]),
        .Q(\x_n_reg[6] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[6][6] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[5] [6]),
        .Q(\x_n_reg[6] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[6][7] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[5] [7]),
        .Q(\x_n_reg[6] [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[7][0] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[6] [0]),
        .Q(\x_n_reg[7] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[7][1] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[6] [1]),
        .Q(\x_n_reg[7] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[7][2] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[6] [2]),
        .Q(\x_n_reg[7] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[7][3] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[6] [3]),
        .Q(\x_n_reg[7] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[7][4] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[6] [4]),
        .Q(\x_n_reg[7] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[7][5] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[6] [5]),
        .Q(\x_n_reg[7] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[7][6] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[6] [6]),
        .Q(\x_n_reg[7] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \x_n_reg[7][7] 
       (.C(CLK),
        .CE(E),
        .D(\x_n_reg[6] [7]),
        .Q(\x_n_reg[7] [7]),
        .R(SR));
endmodule

module clk_wiz_0
   (clk_100M,
    clk_12_5M,
    clk_in1);
  output clk_100M;
  output clk_12_5M;
  input clk_in1;

  wire clk_100M;
  wire clk_12_5M;
  wire clk_in1;

  clk_wiz_0_clk_wiz_0_clk_wiz inst
       (.clk_100M(clk_100M),
        .clk_12_5M(clk_12_5M),
        .clk_in1(clk_in1));
endmodule

(* ORIG_REF_NAME = "clk_wiz_0_clk_wiz" *) 
module clk_wiz_0_clk_wiz_0_clk_wiz
   (clk_100M,
    clk_12_5M,
    clk_in1);
  output clk_100M;
  output clk_12_5M;
  input clk_in1;

  wire clk_100M;
  wire clk_100M_clk_wiz_0;
  wire clk_12_5M;
  wire clk_12_5M_clk_wiz_0;
  wire clk_in1;
  wire clk_in1_clk_wiz_0;
  wire clkfbout_buf_clk_wiz_0;
  wire clkfbout_clk_wiz_0;
  wire NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED;
  wire NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED;
  wire NLW_mmcm_adv_inst_DRDY_UNCONNECTED;
  wire NLW_mmcm_adv_inst_LOCKED_UNCONNECTED;
  wire NLW_mmcm_adv_inst_PSDONE_UNCONNECTED;
  wire [15:0]NLW_mmcm_adv_inst_DO_UNCONNECTED;

  (* box_type = "PRIMITIVE" *) 
  BUFG clkf_buf
       (.I(clkfbout_clk_wiz_0),
        .O(clkfbout_buf_clk_wiz_0));
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  (* box_type = "PRIMITIVE" *) 
  IBUF #(
    .IOSTANDARD("DEFAULT")) 
    clkin1_ibufg
       (.I(clk_in1),
        .O(clk_in1_clk_wiz_0));
  (* box_type = "PRIMITIVE" *) 
  BUFG clkout1_buf
       (.I(clk_100M_clk_wiz_0),
        .O(clk_100M));
  (* box_type = "PRIMITIVE" *) 
  BUFG clkout2_buf
       (.I(clk_12_5M_clk_wiz_0),
        .O(clk_12_5M));
  (* box_type = "PRIMITIVE" *) 
  MMCME2_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT_F(10.000000),
    .CLKFBOUT_PHASE(0.000000),
    .CLKFBOUT_USE_FINE_PS("FALSE"),
    .CLKIN1_PERIOD(10.000000),
    .CLKIN2_PERIOD(0.000000),
    .CLKOUT0_DIVIDE_F(10.000000),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(0.000000),
    .CLKOUT0_USE_FINE_PS("FALSE"),
    .CLKOUT1_DIVIDE(80),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(0.000000),
    .CLKOUT1_USE_FINE_PS("FALSE"),
    .CLKOUT2_DIVIDE(1),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(0.000000),
    .CLKOUT2_USE_FINE_PS("FALSE"),
    .CLKOUT3_DIVIDE(1),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(0.000000),
    .CLKOUT3_USE_FINE_PS("FALSE"),
    .CLKOUT4_CASCADE("FALSE"),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT4_USE_FINE_PS("FALSE"),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .CLKOUT5_USE_FINE_PS("FALSE"),
    .CLKOUT6_DIVIDE(1),
    .CLKOUT6_DUTY_CYCLE(0.500000),
    .CLKOUT6_PHASE(0.000000),
    .CLKOUT6_USE_FINE_PS("FALSE"),
    .COMPENSATION("ZHOLD"),
    .DIVCLK_DIVIDE(1),
    .IS_CLKINSEL_INVERTED(1'b0),
    .IS_PSEN_INVERTED(1'b0),
    .IS_PSINCDEC_INVERTED(1'b0),
    .IS_PWRDWN_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .REF_JITTER1(0.010000),
    .REF_JITTER2(0.010000),
    .SS_EN("FALSE"),
    .SS_MODE("CENTER_HIGH"),
    .SS_MOD_PERIOD(10000),
    .STARTUP_WAIT("FALSE")) 
    mmcm_adv_inst
       (.CLKFBIN(clkfbout_buf_clk_wiz_0),
        .CLKFBOUT(clkfbout_clk_wiz_0),
        .CLKFBOUTB(NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED),
        .CLKFBSTOPPED(NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED),
        .CLKIN1(clk_in1_clk_wiz_0),
        .CLKIN2(1'b0),
        .CLKINSEL(1'b1),
        .CLKINSTOPPED(NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED),
        .CLKOUT0(clk_100M_clk_wiz_0),
        .CLKOUT0B(NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED),
        .CLKOUT1(clk_12_5M_clk_wiz_0),
        .CLKOUT1B(NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED),
        .CLKOUT2(NLW_mmcm_adv_inst_CLKOUT2_UNCONNECTED),
        .CLKOUT2B(NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED),
        .CLKOUT3(NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED),
        .CLKOUT3B(NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED),
        .CLKOUT4(NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED),
        .CLKOUT5(NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED),
        .CLKOUT6(NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED),
        .DADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DCLK(1'b0),
        .DEN(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(NLW_mmcm_adv_inst_DO_UNCONNECTED[15:0]),
        .DRDY(NLW_mmcm_adv_inst_DRDY_UNCONNECTED),
        .DWE(1'b0),
        .LOCKED(NLW_mmcm_adv_inst_LOCKED_UNCONNECTED),
        .PSCLK(1'b0),
        .PSDONE(NLW_mmcm_adv_inst_PSDONE_UNCONNECTED),
        .PSEN(1'b0),
        .PSINCDEC(1'b0),
        .PWRDWN(1'b0),
        .RST(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
