--------------------------------------------------------------------------------
-- Title       : Testbench of the controler
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : CONTROLER_tb.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Wed Feb 24 19:08:06 2021
-- Last update : Sat Feb 27 16:21:04 2021
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2021 Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;


library work;
use work.pk_signal_generator.all;
use work.pk_controler.all;
-----------------------------------------------------------

entity CONTROLER_tb is

end entity CONTROLER_tb;

-----------------------------------------------------------

architecture testbench of CONTROLER_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal i_clk              : std_logic;
	signal i_reset_ack_gen    : std_logic;
	signal i_reset_ack_filter : std_logic;
	signal i_input_slv        : tslv_input;
	signal i_filter           : tslv_bus_sortie;
	signal i_generator        : tslv_bus_sortie;
	signal o_ctrl_bus         : tslv_ctrl;
	signal o_mode_led_3       : tslv_mode_led_3;
	signal o_bus_sortie       : tslv_bus_sortie;
	signal o_reset_latch      : tslv_input;

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- 10NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		i_clk <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		i_clk <= '0';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
	end process CLK_GEN;

	RESET_GEN : process
	begin
		reset <= '1',
		         '0' after 20.0*C_CLK_PERIOD * (1 SEC);
		wait;
	end process RESET_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.CONTROLER
		port map (
			i_clk              => i_clk,
			i_reset_ack_gen    => i_reset_ack_gen,
			i_reset_ack_filter => i_reset_ack_filter,
			i_input_slv        => i_input_slv,
			i_filter           => i_filter,
			i_generator        => i_generator,
			o_ctrl_bus         => o_ctrl_bus,
			o_mode_led_3       => o_mode_led_3,
			o_bus_sortie       => o_bus_sortie,
			o_reset_latch      => o_reset_latch
		);

end architecture testbench;