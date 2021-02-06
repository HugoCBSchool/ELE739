--------------------------------------------------------------------------------
-- Project     : ele739-h21-projet1
--------------------------------------------------------------------------------
-- File        : FSM_CONTROL_tb.vhd
-- Author      : hugo cusson-bouthillier
-- Created     : Sat Jan 30 15:41:21 2021
-- Last update : Sat Jan 30 17:08:06 2021
--------------------------------------------------------------------------------
-- Copyright (c) hugo cusson-bouthillier
-------------------------------------------------------------------------------
-- Description: 
-- 		Test bench validating independently the functionality of 
-- 		all control stage behaviour.
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
use STD.textio.all;
use ieee.std_logic_textio.all;

library work;
use work.pk_fsm_control.all;
use work.pk_input_interface.all;
-----------------------------------------------------------

entity FSM_CONTROL_tb is

end entity FSM_CONTROL_tb;

-----------------------------------------------------------

architecture testbench of FSM_CONTROL_tb is

	-- Testbench DUT ports
	signal i_clk                                      : std_logic;
	
	signal i_input:trec_input;
	signal i_done_slv:std_logic_vector(2 downto 0);
	signal i_light_slv:std_logic_vector(6 downto 0);
	
	signal o_seq_code_slv                             : std_logic_vector(2 downto 0);
    signal o_ctrl_ns,o_ctrl_ew,o_ctrl_ped:trec_fsm_ctrl;
    signal o_sync_in,o_in_reset                       :tslv_input;
	signal w_hw_input_slv                             : std_logic_vector(3 downto 0);
	signal w_done_NS ,w_done_EW ,w_done_PED           : std_logic;
	signal w_light_NS,w_light_EW                      : std_logic_vector(2 downto 0 );
	signal w_light_PED                                : std_logic;
	signal w_ctrl_slv_NS,w_ctrl_slv_EW,w_ctrl_slv_PED : std_logic_vector(2 downto 0);

    
	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS
    file f:TEXT;

begin

    -- interface routing
    w_hw_input_slv<=input2slv(i_input);
    o_ctrl_ns<=slv2fsm_ctrl(w_ctrl_slv_ns);
    o_ctrl_ew<=slv2fsm_ctrl(w_ctrl_slv_ew);
    o_ctrl_ped<=slv2fsm_ctrl(w_ctrl_slv_ped);
    
    w_done_ns<=i_done_slv(2);
    w_done_ew<=i_done_slv(1);
    w_done_ped<=i_done_slv(0);
    
    w_light_ns<=i_light_slv(6 downto 4);
    w_light_ew<=i_light_slv(3 downto 1);
    w_light_ped<=i_light_slv(0);
    
    
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
        --init
        i_done_slv<="000";
        i_light_slv<="0010010";
        i_input<=slv2input("0000");
        
        --delay
        wait until rising_edge(i_clk);
        wait for c_clk_period/10.0*(1 sec);
        
        --show behaviour for done at off
        wait for c_clk_period*10.0*(2 sec);
        
        --put done on to see maintenance mode
        i_done_slv<="111";
        wait for c_clk_period*10.0*(1 sec);
        
        --put stepmode to on to observe next stopping to emit
        i_input.step<='1';
        wait for c_clk_period*10.0*(1 sec);
        
        --put next button at 1 for 2 clk to observe blocking emission
        i_input.nxt<='1';
        wait for c_clk_period*2.0*(1 sec);
        i_input.nxt<='0';
        wait for c_clk_period*8.0*(1 sec);
        
        --put next button at 1 for 10 clk to observe repetitive emission
        i_input.nxt<='1';
        wait for c_clk_period*10.0*(1 sec);
        i_input.nxt<='0';
        wait for c_clk_period*10.0*(1 sec);
        
        
        --put maint mode to on for 2 clk to observe mode toggle
        i_input.step<='0';
        i_input.maint<='1';
        wait for 2.0*c_clk_period*(1 sec);
        i_input.maint<='0';
        wait for 18.0*c_clk_period*(1 sec);
        
        
        --show a pedestrian request event lasting 3 clk
        i_input.ped<='1';
        wait for 3.0*c_clk_period*(1 sec);
        i_input.ped<='0';
        wait for 18.0*c_clk_period*(1 sec);
        
        
    end process p;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.FSM_CONTROL
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
			o_seq_code_slv => o_seq_code_slv,
			o_input_sync   => o_sync_in,
			o_input_reset  => o_in_reset
		);

    ff:process 
            -- Testbench DUT ports
        variable v_clk: line;
        
        variable v_input_step:line;
        variable v_input_next:line;
        variable v_input_maint:line;
        variable v_input_ped:line;
        variable v_all_done:line;
        variable v_light_all_red:line;
        
        variable v_mode_update:line;
        variable v_fsm_sel:line;
        variable v_nxt_emit:line;
        variable v_ctrl_maint:line;
        variable v_ctrl_step:line;
        variable v_next_ns:line;
        variable v_next_ew:line;
        variable v_next_ped:line;
        variable varcount:integer:=0;
    begin
        file_open(f,"out_txt.txt",write_mode);

        while (varcount<=101) loop
             wait until rising_edge(i_clk);
            varcount:=varcount+1;
            write(v_clk,1);
            write(v_input_step,i_input.step);
            write(v_input_next,i_input.nxt);
            write(v_input_maint,i_input.maint);
            write(v_input_ped,i_input.ped);
            if i_done_slv="111" then  write(v_all_done,1);
            else write(v_all_done,0);
            end if;
            if i_light_slv="--1--10" then write(v_light_all_red,1);
            else write(v_light_all_red,0);
            end if;
            write(v_mode_update,o_seq_code_slv(2));
            write(v_fsm_sel,o_seq_code_slv(1));
            write(v_nxt_emit,o_seq_code_slv(0));
            write(v_ctrl_maint,o_ctrl_ns.maint);
            write(v_ctrl_step,o_ctrl_ns.step);
            write(v_next_ns,o_ctrl_ns.nxt);
            write(v_next_ew,o_ctrl_ew.nxt);
            write(v_next_ped,o_ctrl_ped.nxt);
        end loop;
        writeline(f,v_clk);
        writeline(f,v_input_step);
        writeline(f,v_input_next);
        writeline(f,v_input_maint);
        writeline(f,v_input_ped);
        writeline(f,v_all_done);
        writeline(f,v_light_all_red);
        writeline(f,v_mode_update);
        writeline(f,v_fsm_sel);
        writeline(f,v_nxt_emit);
        writeline(f,v_ctrl_maint);
        writeline(f,v_ctrl_step);
        writeline(f,v_next_ns);
        writeline(f,v_next_ew);
        writeline(f,v_next_ped);
        file_close(f);
        wait;
    end process;

end architecture testbench;
