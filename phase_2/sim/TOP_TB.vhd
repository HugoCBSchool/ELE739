--------------------------------------------------------------------------------
-- Title       : Test Bench of TOP.vhd
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : TOP_tb.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Wed Feb 24 19:08:06 2021
-- Last update : Sat Feb 27 16:18:32 2021
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2021 Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity TOP_tb is

end entity TOP_tb;

-----------------------------------------------------------

architecture testbench of TOP_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal i_clk            : STD_LOGIC;
	signal i_pbn_RESET_G    : STD_LOGIC;
	signal i_pbn_RESTART    : STD_LOGIC;
	signal i_pbn_NEXT_MODE  : STD_LOGIC;
	signal o_bus_sortie     : tslv_bus_sortie;
	signal o_led_bank_state : std_logic_vector(2 downto 0);
	signal o_bus_sortie_rdy : std_logic;

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		clk <= '0';
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
	DUT : entity work.TOP
		port map (
			i_clk            => i_clk,
			i_pbn_RESET_G    => i_pbn_RESET_G,
			i_pbn_RESTART    => i_pbn_RESTART,
			i_pbn_NEXT_MODE  => i_pbn_NEXT_MODE,
			o_bus_sortie     => o_bus_sortie,
			o_led_bank_state => o_led_bank_state,
			o_bus_sortie_rdy => o_bus_sortie_rdy
		);

end architecture testbench;