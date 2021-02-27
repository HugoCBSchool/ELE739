--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : FSM_PED_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Fri Feb  5 09:00:35 2021
-- Last update : Sat Feb 13 13:32:06 2021
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2021 User Company Name
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
use work.pk_fsm_control.all;

-----------------------------------------------------------

entity FSM_PED_tb is

end entity FSM_PED_tb;

-----------------------------------------------------------

architecture testbench of FSM_PED_tb is

	-- Testbench DUT ports
	signal i_clk        : STD_LOGIC;
	signal w_ctrl_slv   : tslv_fsm_ctrl;
	signal i_ctrl       : trec_fsm_ctrl;
	signal o_state      : STD_LOGIC_VECTOR(2 downto 0);
	signal o_light      : STD_LOGIC;
	signal o_count_done : STD_LOGIC;

	-- Other constants
	constant C_CLK_PERIOD 				: real := 0.001;
	constant g_clk_freq_mhz    			: real := (1.0/c_clk_period)/(1000.0*1000.0);
	constant g_time_strobe_PED_s    	: real := 10.0*c_clk_period;
	constant g_nb_strobe_toggle_PED     : natural := 6;
	constant g_time_go_PED_s            : real := 60.0*c_clk_period;
   
begin




	FSM_PED_2 : entity work.FSM_PED
		generic map (
		 g_time_strobe_PED_s    =>  g_time_strobe_PED_s,
		 g_nb_strobe_toggle_PED =>  g_nb_strobe_toggle_PED,
		 g_time_go_PED_s        =>  g_time_go_PED_s,
		 g_clk_freq_mhz         =>  g_clk_freq_mhz
			)
        port map (
	        i_clk => i_clk,
	        i_ctrl_slv =>   w_ctrl_slv,
	        o_state =>   o_state,
	        o_light => o_light,
	        o_count_done => o_count_done
         	);


	w_ctrl_slv<=fsm_ctrl2slv(i_ctrl);

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


	process
	begin
		i_ctrl.nxt<='0';
		wait until rising_edge(o_count_done);
		wait until rising_edge(i_clk);wait until rising_edge(i_clk);wait until rising_edge(i_clk);wait until rising_edge(i_clk);
		wait for 0.1*c_clk_period*(1 sec);
		i_ctrl.nxt<='1';
		wait until rising_edge(i_clk);
		wait for 0.1*c_clk_period*(1 sec);
	end process;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	ctrl_gen: process
	begin
		i_ctrl.step<='0';
		i_ctrl.maint<='0';
		wait until rising_edge(i_clk);
		wait for C_CLK_PERIOD/10.0*(1 sec);

		wait;
	end process ctrl_gen;
             
end testbench;