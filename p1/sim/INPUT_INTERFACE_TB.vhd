--------------------------------------------------------------------------------
-- Project     : ELE792-h21-projet_1
--------------------------------------------------------------------------------
-- File        : INPUT_INTERFACE_TB.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Sat Jan 30 13:56:46 2021
-- Last update : Mon Feb  1 14:28:32 2021
--------------------------------------------------------------------------------
-- Copyright (c) Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: test bench
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library work;
use work.pk_input_interface.all;
-----------------------------------------------------------

entity INPUT_INTERFACE_tb is

end entity INPUT_INTERFACE_tb;

-----------------------------------------------------------

architecture testbench of INPUT_INTERFACE_tb is
	-- Testbench DUT ports
	signal i_clk          : std_logic;
	signal w_reset_slv    : std_logic_vector(3 downto 0);
	signal w_hw_input_slv : std_logic_vector(3 downto 0);
	signal w_req_slv      : std_logic_vector(3 downto 0);
	signal i_reset,i_hw_input,o_req:trec_input;
	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

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

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	p:process
	begin
		-- init 
		i_reset<=slv2input("0000");
		i_hw_input<=slv2input("0000");

		-- delay
		wait until rising_edge(i_clk);
		wait for C_CLK_PERIOD/10.0*(1 sec);

		--fire all inputs
		i_hw_input<=slv2input("1111");
		wait for C_CLK_PERIOD*2.0*(1 sec);
		
		-- set all off
		i_hw_input<=slv2input("0000");
		wait for C_CLK_PERIOD*2.0*(1 sec);

		--reset the next input for 1 clock cycle
		i_reset.ped<='1';
		wait for C_CLK_PERIOD*1.0*(1 sec);
		i_reset<=slv2input("0000");
		wait for C_CLK_PERIOD*1.0*(1 sec);

		--reset the ped request input for 1 cycle
		i_reset.nxt<='1';
		wait for C_CLK_PERIOD*1.0*(1 sec);
		i_reset<=slv2input("0000");
		wait for C_CLK_PERIOD*1.0*(1 sec);

		-- reset the maint mode request for 1 cycle
		i_reset.maint<='1';
		wait for C_CLK_PERIOD*1.0*(1 sec);
		i_reset<=slv2input("0000");
		wait for C_CLK_PERIOD*1.0*(1 sec);

	end process p;


	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	w_hw_input_slv<=input2slv(i_hw_input);
	w_reset_slv<=input2slv(i_reset);
	o_req<=slv2input(w_req_slv);
    
	DUT : entity work.INPUT_INTERFACE
		port map (
			i_clk          => i_clk,
			i_reset_slv    => w_reset_slv,
			i_hw_input_slv => w_hw_input_slv,
			o_req_slv      => w_req_slv
		);

end architecture testbench;
