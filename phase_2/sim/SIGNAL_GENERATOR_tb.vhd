--------------------------------------------------------------------------------
-- Title       : signal generator module test bench
-- Project     : ELE739 - PHASE 2
--------------------------------------------------------------------------------
-- File        : SIGNAL_GENERATOR_tb.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Wed Feb 24 19:08:06 2021
-- Last update : Wed Feb 24 19:12:12 2021
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
library work;
use work.pk_SIGNAL_GENERATOR.all;
use work.pk_CONTROLER.all;
-----------------------------------------------------------

entity SIGNAL_GENERATOR_tb is

end entity SIGNAL_GENERATOR_tb;

-----------------------------------------------------------

architecture testbench of SIGNAL_GENERATOR_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal i_clk           : std_logic;
	signal i_ctrl          : trec_ctrl;
	signal o_signal_probe  : std_logic_vector(2*C_SAMPLE_W-1 downto 0);
	signal o_cos           : std_logic_vector(c_SAMPLE_W-1 downto 0);
	signal o_reset_ack     : std_logic;
	signal o_signal_rdy    : std_logic;

	-- Other constants
	constant C_CLK_PERIOD : real := 1.0; -- NS
	signal w_in : std_logic_vector(2 downto 0);
	signal wslv_ctrl:tslv_ctrl:=ctrl2slv(i_ctrl);
	constant c_time_per:real:=C_CLK_PERIOD*16.0;

begin
	i_ctrl<=slv2ctrl(w_in);
	w_in<="000";
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
	pp:process
	begin
		w_in<="000";
		wait until rising_edge(i_clk);
		wait for C_CLK_PERIOD*0.1*(1 sec);
		wait for c_time_per*(1 sec);
        w_in<="100";
        wait for c_clk_period*(1 sec);
        w_in<="010";
        wait for c_time_per*2.0*(1 sec);
        w_in<="011";
        
        wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="010";
        
        wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="001";
        
        wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="011";
        
        wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="001";
        
        
        
        
        wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="110";
        
        wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="111";
        
        wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="101";
		
		wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="001";
        
        wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="011";
        
        wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="111";
        
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1 sec);
        w_in<="011";
        
		wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="101";
        
        wait for c_time_per*1.5*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period*0.1*(1sec);
        w_in<="001";
		wait;
		
		
		
		
	end process pp;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.SIGNAL_GENERATOR
		port map (
			i_clk           => i_clk,
			i_ctrl_slv      => wslv_ctrl,
			o_signal_probe  => o_signal_probe,
			o_cos           => o_cos,
			o_reset_ack     => o_reset_ack,
			o_signal_rdy    => o_signal_rdy
		);

end architecture testbench;