-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Sun Apr  4 12:28:40 2021
-- Host        : DESKTOP-KU48GBD running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/.uni/e739/project_3/project_3.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.vhdl
-- Design      : clk_wiz_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz_0 is
  Port ( 
    clk_100M : out STD_LOGIC;
    clk_12_5M : out STD_LOGIC;
    clk_ila : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_wiz_0;

architecture stub of clk_wiz_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_100M,clk_12_5M,clk_ila,clk_in1";
begin
end;
