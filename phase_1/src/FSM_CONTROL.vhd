--------------------------------------------------------------------------------
-- Project     : ELE792-h21-projet_1
--------------------------------------------------------------------------------
-- File        : FSM_CONTROL.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Sat Jan 30 13:56:46 2021
-- Last update : Tue Feb  2 12:53:38 2021
--------------------------------------------------------------------------------
-- Copyright (c) Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: This module is responsible for synchronizing the effect of 
-- hardware input stimulus changes on the behaviour of each light fsm
--		


--------------------------------------------------------------------------------
-- entity of the module
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.pk_INPUT_INTERFACE.all;
use work.pk_FSM_CONTROL.all;
use work.pk_seq_code.all;
--------------------------------------------------------------------------------

--! This module is responsible for synchronizing the effect of hardware input 
--! stimulus changes on the behaviour of each light fsm.
entity FSM_CONTROL is
    generic(
        constant g_clk_freq_mhz:real:=100.0;
        constant g_time_pbn_s:real:=0.5
    );
	Port (
		i_clk          : in std_logic;                     --! clock
		i_hw_input_slv : in tslv_input;  				   --! serialized trec_input from the basys3 IOs
		i_done_NS      : in std_logic;                     --! NS FSM is ready for transition
		i_done_EW      : in std_logic;                     --! EW FSM is ready for transition
		i_done_PED     : in std_logic;                     --! PED FSM is ready for transition
		i_light_NS     : in std_logic_vector(2 downto 0 ); --! NS FSM Light output
		i_light_EW     : in std_logic_vector(2 downto 0 ); --! EW FSM Light output
		i_light_PED    : in std_logic;                     --! PED FSM Light output
        i_ped_state    : in std_logic_vector(2 downto 0);
		o_ctrl_slv_NS  : out tslv_fsm_ctrl; --! NS light fsm control vectors
		o_ctrl_slv_EW  : out tslv_fsm_ctrl; --! EW light fsm control vectors
		o_ctrl_slv_PED : out tslv_fsm_ctrl; --! PED light fsm control vectors
		o_seq_code_slv : out tslv_seq_code; --! sequence code vector towards ILA
		
		o_input_reset     : out tslv_input; --! for ila
		o_input_sync      : out tslv_input);--! for ila
end FSM_CONTROL;
--------------------------------------------------------------------------------
architecture Behavioral of FSM_CONTROL is
	---------------------------------------------------------------------------
	-- constants
	constant c_MASK_NS    : std_logic_vector(2 downto 0) := "100"; --! mask that activates the next signal for the NS fsm
	constant c_MASK_EW    : std_logic_vector(2 downto 0) := "010"; --! mask that activates the next signal for the EW fsm
	constant c_MASK_PED   : std_logic_vector(2 downto 0) := "001"; --! mask that activates the next signal for the PED fsm
	constant c_MASK_MAINT : std_logic_vector(2 downto 0) := "110"; --! mask that activates the next signal for the fsms involved with the maintenance mode

	---------------------------------------------------------------------------
	-- entity interfaces
	signal w_input                        : trec_input;    --! the synchronized input signals from the interface module
	signal w_reset                        : trec_input;    --! the reset signals towards the input module
	signal w_input_slv , w_reset_slv      : tslv_input;    --! serial format of former
	signal w_seq_code                     : trec_seq_code; --! the sequence code interface from the sequencer
	signal w_seq_code_slv                 : tslv_seq_code; --! serial format of former
	signal w_ctrl_NS,w_ctrl_EW,w_ctrl_PED : trec_fsm_ctrl; --! control interface for controling the light FSMs

	---------------------------------------------------------------------------
	-- control stages related registers and logic signals
	signal r_ctrl            : trec_fsm_ctrl                := (nxt => '0',step => '0',maint => '1'); --! controller control values register
	signal r_light_mask      : std_logic_vector(2 downto 0) := c_MASK_MAINT;                          --! light mask selector's fsm register
	signal r_next_slv        : std_logic_vector(2 downto 0) := "000";                                 --! next-signal's output value register
	signal w_next_light_mask : std_logic_vector(2 downto 0) ;										  --! light mask selector's fsm input state logic
    signal r_next_mask_flag  : std_logic:='0';
begin

	-------------------------------------------------------
	-- input interface instance
	-------------------------------------------------------
	--! Synchronizes the basys3's inputs and manages input latches reset behaviour.
	INPUT_INTERFACE_1 : entity work.INPUT_INTERFACE
	    generic map(
	       g_clk_freq_mhz=>g_clk_freq_mhz,
	       g_time_pbn_s=>g_time_pbn_s
	    )
		port map (
			i_clk          => i_clk,
			i_reset_slv    => w_reset_slv,
			i_hw_input_slv => i_hw_input_slv,
			o_req_slv      => w_input_slv
		);
    
	--	signal routing
	w_input       <= slv2input(w_input_slv);
	w_reset_slv   <= input2slv(w_reset);
	w_reset.nxt   <= w_seq_code.fsm_select;
	w_reset.maint <= w_seq_code.mode_update;
	w_reset.ped   <= i_light_ped;
	w_reset.step  <= '0';
	o_input_reset <=w_reset_slv;
	o_input_sync  <=input2slv(w_input);

	-------------------------------------------------------
	-- input interface instance
	-------------------------------------------------------
	--! Produces the control sequence's stage synchronization signals.
	CTRL_SEQUENCER_1 : entity work.CTRL_SEQUENCER
		port map (
			i_clk          => i_clk,
			i_done_NS      => i_done_NS,
			i_done_EW      => i_done_EW,
			i_done_PED     => i_done_PED,
			i_light_NS     => i_light_NS,
			i_light_EW     => i_light_EW,
			i_light_ped =>i_ped_state,
			o_seq_code_slv => w_seq_code_slv
		);

	-- signal routing
	o_seq_code_slv <= w_seq_code_slv;
	w_seq_code     <= slv2seq_code(w_seq_code_slv);


	-------------------------------------------------------
	--  output routing
	-------------------------------------------------------
	o_ctrl_slv_NS  <= fsm_ctrl2slv(w_ctrl_NS);
	o_ctrl_slv_PED <= fsm_ctrl2slv(w_ctrl_PED);
	o_ctrl_slv_EW  <= fsm_ctrl2slv(w_ctrl_EW);


	-------------------------------------------------------
	-- light fsm control busses output signal routing
	-------------------------------------------------------
	w_ctrl_NS.step  <= r_ctrl.step;
	w_ctrl_EW.step  <= r_ctrl.step;
	w_ctrl_PED.step <= r_ctrl.step;

	w_ctrl_NS.maint  <= r_ctrl.maint;
	w_ctrl_EW.maint  <= r_ctrl.maint;
	w_ctrl_PED.maint <= r_ctrl.maint;


	w_ctrl_NS.nxt  <= r_next_slv(2);
	w_ctrl_EW.nxt  <= r_next_slv(1);
	w_ctrl_PED.nxt <= r_next_slv(0);

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if (w_seq_code.mode_update='1' and ((r_ctrl.step='1' and w_input.nxt='1' ) or r_ctrl.step='0')) then
                r_next_mask_flag<='1';
            else
                r_next_mask_flag<='0';
            end if;
        end if;
    end process;
	---------------------------------------------------------------------------
	-- mode update stage of the control sequence
	---------------------------------------------------------------------------
	--! Clocked process active when the sequencer's seq-code is "1--". During this stage, 
	--! the input interface's step-mode and maintenance-mode signal changes are acknowledged and 
	--! forwarded to the light fsms, and the input latches are resetted.
	p_MODE_UPDATE : process(i_clk) is
	begin
		if rising_edge(i_clk) then
         
			if(w_seq_code.mode_update='1') then
                
				if(w_input.maint='1') then
					r_ctrl.maint <= not r_ctrl.maint;
				else
					r_ctrl.maint <= r_ctrl.maint;
				end if;

				r_ctrl.step <= w_input.step;

			else

				r_ctrl.step  <= r_ctrl.step;
				r_ctrl.maint <= r_ctrl.maint;

			end if;

		end if;
	end process p_MODE_UPDATE;


	---------------------------------------------------------------------------
	--light selector mask update 
	---------------------------------------------------------------------------
	--! Clocked process active when the sequencer's seq-code is "-1-". During this stage,
	--! any next-event from the input interface are acknowledged if the step mode is active and 
	--! the latch of the next-event is resetted. Also, the internal r_light_mask register's value 
	--! is updated to reflect changes in the active priority of the intersection based on any of the following:
	--!
	--! A pedestrian request during a proper priority state of the intersection
	--!	A maintenance mode change during a proper priority state of the intersection
	--!	A normal progression through the priority cycles
	p_FSM_SELECT : process(i_clk) is
	begin
		if rising_edge(i_clk) then
			if w_seq_code.fsm_select='1' and r_next_mask_flag='1' then
                    if r_ctrl.maint='1' then
                        r_light_mask <= c_mask_maint;
                    else
                        case r_light_mask is
                            when c_MASK_MAINT => r_light_mask <= c_mask_ns;
                            when c_mask_ns    => r_light_mask <= c_mask_ew;
                            when c_mask_ew    =>
                                if w_input.ped='1' then
                                    r_light_mask <= c_mask_ped;
                                else
                                    r_light_mask <= c_mask_ns;
                                end if;
                            when c_mask_ped => r_light_mask <= c_mask_ns;
                            when others     => r_light_mask <= r_light_mask;
                        end case;
				end if;
			else
				r_light_mask <= r_light_mask;
			end if;


			if(w_seq_code.fsm_select='1') then
				-- next value update
				if(r_ctrl.step='1') then
					r_ctrl.nxt <= w_input.nxt;
				else
					r_ctrl.nxt <= '1';
				end if;
			else
				r_light_mask <= r_light_mask;
				r_ctrl.nxt<='0';
            end if;
		end if;
	end process p_FSM_SELECT;


	---------------------------------------------------------------------------
	-- next signal trigger and reset process
	---------------------------------------------------------------------------
	--! Clocked process active when the sequencer's seq-code is "--1". During this stage,
	--! the next vector signal is emitted to the state machines if both of the conditions
	--! below are met:
	--! The control register's next value is high.
	--! The light mask register's value is high for a given state machine.
	p_NEXT_EMISSION : process(i_clk) is
	begin
		if rising_edge(i_clk) then

			if(w_seq_code.next_emit='1') then
				if(r_ctrl.nxt='1') then
					r_next_slv <= r_light_mask;
				else
					r_next_slv <= "000";
				end if;
			else
				r_next_slv <= "000";
			end if;

		end if;
	end process p_NEXT_EMISSION;


end Behavioral;
-------------------------------------------------------------------------------------