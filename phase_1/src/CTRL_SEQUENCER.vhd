--------------------------------------------------------------------------------
-- Project     : ELE792-h21-projet_1
--------------------------------------------------------------------------------
-- File        : CTRL_SEQUENCER.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Sat Jan 30 13:56:46 2021
-- Last update : Tue Feb  2 19:26:18 2021
--------------------------------------------------------------------------------
-- Copyright (c) Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: This module is responsible for synchronizing the 4 stages of the 
-- controller sequence which are:
-- 		idle:			initial state of the sequence, in which we wait for:
--						->  all fsm to be done but not red which causes a 
--								transition to the fsm_select stage
--						->  all fsm to be done and red which causes a 
-- 								transition to the mode-update stage.
--
--		mode-update: 	only occures if all lights are done and red.
--							during this stage, any changes in step-mode or 
-- 							maintenance-mode made by the user are acknowledged and 
-- 							forwarded to each light fsm. At the next clock rise, 
-- 							a transition is done to the fsm_select stage.
--
--	    fsm_select:		stage in which the selection of which fsm is to be sensible 
-- 							to a next signal is done. at next clock rise, go to next-emit stage.
--
--		next_emit:		stage during which a next signal is sent to the the selected fsms.
--							at next clock rise, go to idle.
--! Waveform:
--! {
--!		signal:[
--!			{name: "i_clk",       wave: "p.............."},
--!			{name: "i_done_NS",   wave: "01..........0.."},
--!			{name: "i_done_EW",   wave: "0.1.........0.."},
--!			{name: "i_done_PED",  wave: "0..1........0.."},
--!			{name: "i_light_NS",  wave: "x=..=.......=..", data: ["NOT RED","RED","NOT RED"]},
--!			{name: "i_light_EW",  wave: "x=..=.......=..", data: ["NOT RED","RED","NOT RED"]},
--!			{name: "i_light_PED", wave: "x=.....=....=..", data: ["ON","OFF","ON"]},
--!			{name: "o_seq_code",  wave: "=...==========.", data: ["000","010","001","000","010","001","000","100","010","001","000"]},
--!		]
--! }
--!{reg:[
--!        {name: 'next_emit',   bits: 1, type: 1},
--!        {name: 'fsm_select',   bits: 1, type: 2},
--!        {name: 'mode_update',   bits: 1,type: 3},
--!    ],
--! config:{bits:3}
--!}
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- entity of the module
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.pk_seq_code.all;
--------------------------------------------------------------------------------
--! This module is responsible for synchronizing the 4 stages of the controller sequence which are:
--! * **idle**  Initial state of the sequence, in which we wait for:
--!	 - all fsm to be done but not red which causes a transition to the fsm_select stage
--!	 - all fsm to be done and red which causes a transition to the mode-update stage.
--! 
--! * **mode-update**
--! 	Only occures if all lights are done and red. During this stage, any changes in 
--! 	step-mode or maintenance-mode made by the user are acknowledged and forwarded to each light fsm. 
--! 	At the next clock rise, a transition is done to the fsm_select stage.
--!
--! *  **fsm_select:**  Stage in which the selection of which fsm is to be sensible to a next signal is done.
--!    At next clock rise, go to next-emit stage.
--!	* **next_emit:** 
--! Stage during which a next signal is sent to the the selected fsms.
--!	At next clock rise, go to idle.
--! 
entity CTRL_SEQUENCER is
	port(
		i_clk                            : in  std_logic;     --! clock
		i_done_NS ,i_done_EW ,i_done_PED : in  std_logic;     --! done signal from light fsms indicating that they are ready to receive next
		i_light_NS,i_light_EW,i_light_ped: in  tslv_seq_code; --! the fsm lights state
		o_seq_code_slv                   : out tslv_seq_code  --! the sequence control code
	);
end CTRL_SEQUENCER;
--------------------------------------------------------------------------------
architecture Behavioral of CTRL_SEQUENCER is

	------------------------------------------------------------------
	-- enumerated state for the fsm
	type t_state is (s_IDLE,s_MODE_UPDATE,s_FSM_SELECT,s_NEXT_EMIT,s_DELAY);
	constant c_IDLE          : tslv_seq_code := "000"; --! idle seq code
	constant c_MODE_UPDATE   : tslv_seq_code := "100"; --! mode update seq code
	constant c_FSM_SELECT    : tslv_seq_code := "010"; --! fsm_select seq code
	constant c_NEXT_EMISSION : tslv_seq_code := "001"; --! next emit seq code
	-- constants
	constant c_LIGHT_STATE_W : natural                      := 7;	  --! deprecated
	constant c_ALL_RED       : std_logic_vector(2 downto 0) := "111"; --! aggregate value for idle transition
	constant c_ALL_DONE      : std_logic_vector(2 downto 0) := "111"; --! aggregate value for idle transition

	-- signals and regs
	signal w_red_light_slv : std_logic_vector(2 downto 0);           --! signal aggregate
	signal w_done_slv      : std_logic_vector(2 downto 0);           --! signal aggregate
	signal r_ctrl_state    : t_state:=s_IDLE; --! seqence code register
	signal w_seq_code_slv  : tslv_seq_code;
	signal w_seq_code      : trec_seq_code;							 --! the sequence code

begin
	------------------------------------------------------------------
	--  inputs aggregations
	w_red_light_slv <= i_light_NS(0)&i_light_EW(0)&i_light_PED(0);
	w_done_slv      <= i_done_NS&i_done_EW&i_done_PED;
	-- outputs
	o_seq_code_slv <= seq_code2slv(w_seq_code);
	w_seq_code     <= slv2seq_code(w_seq_code_slv);
	with r_ctrl_state select w_seq_code_slv<=
	   c_IDLE when s_IDLE,
	   c_MODE_UPDATE when s_MODE_UPDATE,
	   c_FSM_SELECT when s_FSM_SELECT,
	   c_NEXT_EMISSION when s_NEXT_EMIT,
	   c_IDLE when s_DELAY,
	   c_IDLE when others;
	-----------------------------------------------------------------




	-----------------------------------------------------------------
	-- control sequence FSM
	--! fsm_extract
	--! The fsm implementation driving the sequencer.
	p_ctrl_seq : process(i_clk) is
	begin
		if rising_edge(i_clk) then

			case r_ctrl_state is
				when s_IDLE =>
					if w_done_slv="111" then
						if w_red_light_slv="111" then
							r_ctrl_state <= s_MODE_UPDATE;
						else
							r_ctrl_state <= s_FSM_SELECT;
						end if;
					else
						r_ctrl_state <= s_IDLE;
					end if;
				when s_MODE_UPDATE   => r_ctrl_state <= s_FSM_SELECT;
				when s_FSM_SELECT    => r_ctrl_state <= s_NEXT_EMIT;
				when s_NEXT_EMIT => r_ctrl_state <= s_DELAY;
				when others        => r_ctrl_state <= s_IDLE;
			end case;

		end if;
	end process p_ctrl_seq;
	-----------------------------------------------------------------

end Behavioral;
