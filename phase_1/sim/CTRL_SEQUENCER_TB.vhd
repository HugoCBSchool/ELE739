--------------------------------------------------------------------------------
-- Project     : ELE739-H2021-Projet_1
--------------------------------------------------------------------------------
-- File        : CTRL_SEQUENCER_tb.vhd
-- Author      : Hugo Cusson Bouthillier
-- Created     : Fri Jan 29 19:42:17 2021
-- Last update : Sat Jan 30 13:56:27 2021
-- Platform    : Basys3
--------------------------------------------------------------------------------
-- Copyright (c) 2021 Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: 
--	This test bench verifies that the sequencer operates in the appropriate maner
--  regardless of the input. To further understand the test cases, refer to the
--  process called validation_process further down.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.textio.all;
use ieee.std_logic_textio.all;
library work;
use work.pk_seq_code.all;
-----------------------------------------------------------

entity CTRL_SEQUENCER_tb is

end entity CTRL_SEQUENCER_tb;

-----------------------------------------------------------

architecture testbench of CTRL_SEQUENCER_tb is
	-- Testbench DUT ports
	signal i_clk                            : std_logic;
	signal i_done_NS ,i_done_EW ,i_done_PED : std_logic;
	signal i_light_NS,i_light_EW            : std_logic_vector(2 downto 0 );
	signal i_light_PED                      : std_logic;
	signal o_MODE_UPDATE_en                 : std_logic;
	signal o_FSM_SELECT_en                  : std_logic;
	signal o_NEXT_EMIT_en                   : std_logic;
	signal w_seq_code:trec_seq_code;
    signal w_seq_code_slv:std_logic_vector(2 downto 0);
    
	-- stimulus
	signal u_done      : unsigned(2 downto 0) := to_unsigned(0,3);
	signal u_not_red   : unsigned(3 downto 0) := to_unsigned(0,4);
	signal u_red       : unsigned(2 downto 0) := to_unsigned(0,3);
	signal slv_done    : std_logic_vector(2 downto 0);
	signal slv_not_red : std_logic_vector(3 downto 0);
	signal slv_red     : std_logic_vector(2 downto 0);

	-- test points and sequential test constructs
	signal w_all_done,w_all_red,w_max_one_active : std_logic;
	signal r_mode_update_fifo                    : std_logic_vector(1 downto 0) := "00";
	signal r_fsm_select_fifo                     : std_logic                    := '0';
	signal r_next_emit_fifo                      : std_logic                    := '0';
	signal slv_act                               : std_logic_vector(3 downto 0);
    signal s_clk:std_logic;
    signal r_all_done_fifo:std_logic:='0';
    signal r_all_red_fifo:std_logic:='0';
	-- Other constants
	constant C_CLK_PERIOD           : real := 10.0e-9; -- NS
	constant c_done_value_domain    : real := 8.0;
	constant c_sequence_throughput  : real := 4.0;
	constant c_not_red_value_domain : real := 32.0;
	constant c_red_value_domain     : real := 8.0;

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		i_clk <= '0';
		s_clk<='1';
		wait for C_CLK_PERIOD / 10.0 * (1 SEC);
		i_clk <= '1';
		wait for 9.0*C_CLK_PERIOD / 10.0 * (1 SEC);
        s_clk<='0';
        wait for C_CLK_PERIOD / 10.0 * (1 SEC);
        i_clk <= '0';
		wait for 9.0*C_CLK_PERIOD / 10.0 * (1 SEC);
	end process CLK_GEN;
    
	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	--generation du signal done avec un unsigned
	done_gen : process
	begin
	   wait for c_clk_period*4.0*(1 sec);
	   u_done <= u_done+1;
	end process done_gen;

	--generation des lumieres vert-jaune avec un unsigned
	not_red_gen : process
	begin
	    wait for c_clk_period*4.0*8.0*(1 sec);
		u_not_red <= u_not_red+1;
	end process not_red_gen;

	-- generation des autres lumieres avec un unsigned
	red_gen : process
	begin
	    wait for c_clk_period*4.0*8.0*16.0*(1 sec);
		u_red <= u_red+1;
	end process red_gen;


	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.CTRL_SEQUENCER
		port map (
			i_clk            => i_clk,
			i_done_NS        => i_done_NS,
			i_done_EW        => i_done_EW,
			i_done_PED       => i_done_PED,
			i_light_NS       => i_light_NS,
			i_light_EW       => i_light_EW,
			i_light_PED      => i_light_PED,
			o_seq_code_slv=>w_seq_code_slv
		);
	-- routing
    w_seq_code<=slv2seq_code(w_seq_code_slv);
    o_mode_update_en<=w_seq_code.mode_update;
    o_fsm_select_en<=w_seq_code.fsm_select;
    o_next_emit_en<=w_seq_code.next_emit;
	-----------------------------------------------------------
	-- signaux de test
	-----------------------------------------------------------
	w_all_done <= '1' when slv_done="111" else '0';
	w_all_red  <= '1' when slv_red="110" else '0';

	-- generate the test point to assert that only 0 or one sequence state is active at once
	slv_act          <= (o_MODE_UPDATE_en & o_FSM_SELECT_en & o_NEXT_EMIT_en & r_next_emit_fifo);
	w_max_one_active <=
		'1' when slv_act="0000" else
		'1' when slv_act="0001" else
		'1' when slv_act="0010" else
		'1' when slv_act="0100" else
		'1' when slv_act="1000" else
		'0';


	-- generate fifos for sequence validation
	validation_fifos : process
	begin
		wait until rising_edge(i_clk);
		r_mode_update_fifo <= r_mode_update_fifo(0)&o_mode_update_en;
		r_fsm_select_fifo  <= o_fsm_select_en;
		r_next_emit_fifo   <= o_next_emit_en;
		r_all_done_fifo<=w_all_done;
		r_all_red_fifo<=w_all_red;
	end process validation_fifos;

	----------------------------------------------------------------------------
	-- here we validate all test cases
	----------------------------------------------------------------------------
	validation_process : process(i_clk)
	begin
		----------------------------------------------
		-- invalid-state validation
		---------------------------------------------
		if rising_edge(i_clk) then

			if r_all_done_fifo='1' then

				if not(r_all_red_fifo='1') then
					-- make sure mode update is never active without both all done and all red
					assert(not(o_mode_update_en='1'))
						report "false activation"
						severity failure;
				end if;

			else

				-- make sure we do not exit idle when we are not done counting on all lights
				assert not ((o_mode_update_en or (o_fsm_select_en and r_mode_update_fifo(0)))='1')
					report "false activation"
					severity failure;

			end if;

			-- make sure no invalid state is met
			assert w_max_one_active='1'
				report "invalid state generated"
				severity failure;

		end if;
		------------------------------------------------
		-- mode-update stage validation
		------------------------------------------------
		--make sure we never get 2 mode updates in a row
		assert not(r_mode_update_fifo="11")
			report "invalid sequence"
			severity failure;

		if o_mode_update_en='1' then
			assert r_mode_update_fifo="00"
				report "invalid sequence"
				severity failure;
		end if;
		-----------------------------------------------
		-- fsm_select stage validation
		------------------------------------------------
		if o_fsm_select_en='1' then

			-- make sure we dont get 2 select in a row
			assert r_fsm_select_fifo='0'
				report "invalid sequence"
				severity failure;

			if r_all_red_fifo='1' then
				-- make sure we come from the mode update
				assert r_mode_update_fifo="01"
					report "invalid sequence"
					severity failure;
			else
				-- make sure we skiped the mode update
				assert r_mode_update_fifo="00"
					report "invalid sequence"
					severity failure;
			end if;

		end if;
		------------------------------------------------
		-- next-emit stage validation
		------------------------------------------------
		if o_next_emit_en='1' then
			--make sure we come from the next selection
			assert r_fsm_select_fifo='1'
				report "invalid sequence"
				severity failure;

			-- validate the sequence
			assert (r_mode_update_fifo="10" or r_mode_update_fifo="00")
				report "invalid sequence"
				severity failure;
		end if;
	end process validation_process;


	----------------------------------------------------------------------------
	-- signal routing
	----------------------------------------------------------------------------
	slv_red     <= std_logic_vector(u_red);
	slv_not_red <= std_logic_vector(u_not_red);
	slv_done    <= std_logic_vector(u_done);
	i_done_NS   <= slv_done(2);
	i_done_EW   <= slv_done(1);
	i_done_ped  <= slv_done(0);
	i_light_ns  <= slv_not_red(3 downto 2)&slv_red(2);
	i_light_ew  <= slv_not_red(1 downto 0)&slv_red(1);
	i_light_ped <= slv_red(0);



end architecture testbench;
--------------------------------------------------------------------------------