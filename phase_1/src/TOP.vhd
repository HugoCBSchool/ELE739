--------------------------------------------------------------------------------
-- Project     : ELE792-h21-projet_1
--------------------------------------------------------------------------------
-- File        : TOP.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Sat Jan 30 13:56:46 2021
-- Last update : Fri Feb 12 14:37:15 2021
--------------------------------------------------------------------------------
-- Copyright (c) Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: top level signal routing
--		
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library work;
use work.pk_seq_code.all;
use work.pk_input_interface.all;
use work.pk_FSM_CONTROL.all;
use work.pk_ila_interface.all;
use work.pk_time_cst.all;
use work.pk_time.all;
--------------------------------------------------------------------------------
--! Description: top level signal routing
entity TOP is
	generic(
		constant g_clk_freq_mhz         : real    := c_clk_freq_mhz;
		constant g_time_strobe_PED_s    : real    := c_time_strobe_PED_s;
		constant g_nb_strobe_toggle_PED : natural := c_nb_strobe_toggle_PED;
		constant g_time_go_PED_s        : real    := c_time_go_PED_s;
		constant g_time_G_NS_s          : real    := c_time_G_NS_s;
		constant g_time_Y_NS_s          : real    := c_time_Y_NS_s;
		constant g_time_R_strobe_s      : real    := c_time_R_strobe_s ;
		constant g_time_G_ew_s          : real    := c_time_G_ew_s;
		constant g_time_Y_ew_s          : real    := c_time_Y_ew_s;
		constant g_time_pbn_s 			: real 	  := c_time_pbn_s
	);
	port(
		i_clk            : in std_logic; --! clock
		i_pbn_ped_req    : in std_logic; --! button for pedestrian priority request
		i_pbn_maint_mode : in std_logic; --! button for toggling between maintenance mode and normal
		i_sw_step_mode   : in std_logic; --! switch for activation of step mode
		i_pbn_next       : in std_logic; --! button to advance 1 step in step mode

		o_red_ns,o_red_ew       : out std_logic; --! red lights
		o_green_ns,o_green_ew   : out std_logic; --! green lights
		o_yellow_ns,o_yellow_ew : out std_logic; --! yellow lights
		o_light_ped             : out std_logic  --! pedestrian light
	);
	end TOP;

	architecture Behavioral of TOP is
		signal ila             : trec_busila_ila_side; --! ila-side interface for ila
		signal busila_top_side : trec_busila_top_side; --! design-side interface for ila

		signal w_light_ns,w_light_ew          : std_logic_vector(2 downto 0); --! car lights feedback
		signal w_light_ped                    : std_logic;                    --! pedestrian light feedback
		signal w_done_NS,w_done_EW,w_done_ped : std_logic;                    --! done signals feedback

		signal w_hw_input_slv : std_logic_vector(3 downto 0); --! hardware inputs interface
		signal w_hw_input     : trec_input;                   --! hardware inputs interface

		signal w_ctrl_slv_NS,w_ctrl_slv_ew,w_ctrl_slv_ped : std_logic_vector(2 downto 0); --! control busses towards light-fsms
		signal w_ctrl_ns , w_ctrl_ew , w_ctrl_ped         : trec_fsm_ctrl;                --! interface

		signal w_seq_code_slv               : std_logic_vector(2 downto 0); --! sequence code interface
		signal w_in_reset_slv,w_sync_in_slv : tslv_input;                   --! testpoints for ila
		signal w_ped_state                  : std_logic_vector(2 downto 0); --! testpoint for ila
	begin
		----------------------------------------------------------------------------
		-- signal routing
		----------------------------------------------------------------------------
		w_ctrl_ns  <= slv2fsm_ctrl(w_ctrl_slv_NS);
		w_ctrl_ew  <= slv2fsm_ctrl(w_ctrl_slv_ew);
		w_ctrl_ped <= slv2fsm_ctrl(w_ctrl_slv_ped);

		w_hw_input.nxt   <= i_pbn_next;
		w_hw_input.ped   <= i_pbn_ped_req;
		w_hw_input.step  <= i_sw_step_mode;
		w_hw_input.maint <= i_pbn_maint_mode;
		w_hw_input_slv   <= input2slv(w_hw_input);

		o_light_ped <= w_light_ped;
		o_red_ns    <= w_light_ns(0);
		o_red_ew    <= w_light_ew(0);
		o_yellow_ns <= w_light_ns(1);
		o_yellow_ew <= w_light_ew(1);
		o_green_ns  <= w_light_ns(2);
		o_green_ew  <= w_light_ew(2);

		ila                       <= top2ila(busila_top_side);
		busila_top_side.hw_in     <= w_hw_input;
		busila_top_side.sync_in   <= slv2input(w_sync_in_slv);
		busila_top_side.in_reset  <= slv2input(w_in_reset_slv);
		busila_top_side.seq_code  <= slv2seq_code(w_seq_code_slv);
		busila_top_side.ctrl_ns   <= w_ctrl_ns;
		busila_top_side.ctrl_ew   <= w_ctrl_ew;
		busila_top_side.ctrl_ped  <= w_ctrl_ped;
		busila_top_side.done_slv  <= w_done_NS&w_done_EW&w_done_ped;
		busila_top_side.light_ns  <= w_light_ns;
		busila_top_side.light_ew  <= w_light_ew;
		busila_top_side.light_ped <= w_light_ped;
		busila_top_side.ped_state <= w_ped_state;

		--------------------------------------------------------------------------------
		-- instances
		--------------------------------------------------------------------------------
		U_ila : ila_0
			port map (
				clk     => i_clk,
				probe0  => ila.probe0,
				probe1  => ila.probe1,
				probe2  => ila.probe2,
				probe3  => ila.probe3,
				probe4  => ila.probe4,
				probe5  => ila.probe5,
				probe6  => ila.probe6,
				probe7  => ila.probe7,
				probe8  => ila.probe8,
				probe9  => ila.probe9,
				probe10 => ila.probe10,
				probe11 => ila.probe11
			);

		FSM_CONTROL_1 : entity work.FSM_CONTROL
			generic map(
				g_clk_freq_mhz=>g_clk_freq_mhz,
				g_time_pbn_s=>g_time_pbn_s	
			)
			port map (
				i_clk          => i_clk,
				i_hw_input_slv => w_hw_input_slv,
				i_done_NS      => w_done_NS,
				i_done_EW      => w_done_EW,
				i_done_PED     => w_done_PED,
				i_light_NS     => w_light_NS,
				i_light_EW     => w_light_EW,
				i_light_PED    => w_light_PED,
				o_ctrl_slv_NS  => w_ctrl_slv_NS,
				o_ctrl_slv_EW  => w_ctrl_slv_EW,
				o_ctrl_slv_PED => w_ctrl_slv_PED,
				o_seq_code_slv => w_seq_code_slv,
				o_input_reset  => w_in_reset_slv,
				o_input_sync   => w_sync_in_slv,
				i_ped_state    => w_ped_state
			);

		FSM_LIGHT_NS_1 : entity work.FSM_LIGHT_NS(Behavioral)
			generic map (
				g_clk_freq_mhz    => g_clk_freq_mhz,
				g_time_G_NS_s     => g_time_G_ns_s,
				g_time_Y_NS_s     => g_time_Y_ns_s,
				g_time_R_strobe_s => g_time_R_strobe_s
			)
			port map (
				i_clk        => i_clk,
				i_next       => w_ctrl_ns.nxt,
				i_maint_mode => w_ctrl_ns.maint,
				i_step_mode  => w_ctrl_ns.step,
				o_count_done => w_done_NS,
				o_light      => w_light_NS
			);
		FSM_LIGHT_NS_3 : entity work.FSM_LIGHT_NS
			generic map (
				g_clk_freq_mhz    => g_clk_freq_mhz,
				g_time_G_NS_s     => g_time_G_ew_s,
				g_time_Y_NS_s     => g_time_Y_ew_s,
				g_time_R_strobe_s => g_time_R_strobe_s
			)
			port map (
				i_clk        => i_clk,
				i_maint_mode => w_ctrl_ew.maint,
				i_next       => w_ctrl_ew.nxt,
				i_step_mode  => w_ctrl_ew.step,
				o_count_done => w_done_ew,
				o_light      => w_light_ew
			);
		FSM_PED_2 : entity work.FSM_PED
			generic map (
				g_time_strobe_PED_s    => g_time_strobe_PED_s,
				g_nb_strobe_toggle_PED => g_nb_strobe_toggle_PED,
				g_time_go_PED_s        => g_time_go_PED_s,
				g_clk_freq_mhz         => g_clk_freq_mhz
			)
			port map (
				i_clk        => i_clk,
				i_ctrl_slv   => w_ctrl_slv_ped,
				o_state      => w_ped_state,
				o_light      => w_light_ped,
				o_count_done => w_done_ped
			);


	end Behavioral;
