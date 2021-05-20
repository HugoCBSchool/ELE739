----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2021 10:27:43 AM
-- Design Name: 
-- Module Name: CLK_TEST - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

library work;

use work.pk_small_fir_filter.all;

entity CLK_TEST is
  Port (
    i_average   :          IN STD_LOGIC_VECTOR(g_i_vec_size-1 downto 0);
    i_clk       :          IN STD_LOGIC;
    i_reset     :          IN STD_LOGIC;
    i_signal_rdy:          in std_logic;
    i_small_filter_active: IN STD_LOGIC;
    o_reset_ack :          OUT STD_LOGIC;
    o_filter_rdy:          OUT STD_LOGIC;
    o_small_filter:        OUT STD_LOGIC_VECTOR(15 downto 0)
  );
end CLK_TEST;

architecture Behavioral of CLK_TEST is
	component clk_wiz_0
	port(
		clk_100M          : out    std_logic;
		clk_12_5M         : out    std_logic;
		clk_in1           : in     std_logic
	);
	end component;
    signal w_clk_100 :std_logic;
    signal w_clk_12_5:std_logic;
begin
   mmcm_1 : clk_wiz_0
       port map ( 
           clk_100M => w_clk_100,
           clk_12_5M => w_clk_12_5,
           clk_in1 => i_clk
       );
   SMALL_FIR_FILTER_1 : entity work.SMALL_FIR_FILTER
		port map (
			i_average             => i_average,
			i_clk                 => w_clk_12_5,
			i_clk_fast            => w_clk_100,
			i_signal_rdy          => i_signal_rdy,
			i_reset               => i_reset,
			i_small_filter_active => i_small_filter_active,
			o_reset_ack           => o_reset_ack,
			o_filter_rdy          => o_filter_rdy,
			o_small_filter        => o_small_filter
		);
end Behavioral;
