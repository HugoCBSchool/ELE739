// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Fri Feb  5 11:15:06 2021
// Host        : DESKTOP-KU48GBD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub c:/.uni/e739/p1/p1.srcs/sources_1/ip/ila_0/ila_0_stub.v
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "ila,Vivado 2019.2" *)
module ila_0(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6, probe7, probe8, probe9, probe10, probe11)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[3:0],probe1[3:0],probe2[3:0],probe3[2:0],probe4[2:0],probe5[2:0],probe6[2:0],probe7[2:0],probe8[2:0],probe9[2:0],probe10[0:0],probe11[2:0]" */;
  input clk;
  input [3:0]probe0;
  input [3:0]probe1;
  input [3:0]probe2;
  input [2:0]probe3;
  input [2:0]probe4;
  input [2:0]probe5;
  input [2:0]probe6;
  input [2:0]probe7;
  input [2:0]probe8;
  input [2:0]probe9;
  input [0:0]probe10;
  input [2:0]probe11;
endmodule
