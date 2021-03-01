--------------------------------------------------------------------------------
-- Title       : CONTROLER MODULE
-- Project     : ELE739 - PHASE 2
--------------------------------------------------------------------------------
-- File        : CONTROLER.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Wed Feb 24 19:08:06 2021
-- Last update : Wed Feb 24 22:17:05 2021
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2021 Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
--! Description: This module is a small component managing synchronization 
--! of pushbuttons
-------------------------------------------------------------------------------
--! Waveform:
--! {
--!		signal:[
--!			{name: "i_clk",                   wave: "p.................."},
--!			{name: "i_hw_input_slv.ped",      wave: "x01.0.............."},
--!			{name: "i_hw_input_slv.nxt",      wave: "x01.0.............."},
--!			{name: "i_hw_input_slv.step",     wave: "x01.0.............."},
--!			{name: "i_hw_input_slv.maint",    wave: "x01.0.............."},
--!			{name: "i_reset_slv.ped",         wave: "x0....10..........."},
--!			{name: "i_reset_slv.nxt",         wave: "x0......10........."},
--!			{name: "i_reset_slv.step",        wave: "x.................."},
--!			{name: "i_reset_slv.maint",       wave: "x0........10......."},
--!			{name: "o_req_slv.ped",           wave: "x0.........1.0....."},
--!			{name: "o_req_slv.nxt",           wave: "x0.........1...0..."},
--!			{name: "o_req_slv.step",          wave: "x0........1.0......"},
--!			{name: "o_req_slv.maint",         wave: "x0.........1.....0."},
--!		]
--! }

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;


library work;
use work.pk_time.all;



entity INPUT_LATCH is
	generic(
		constant g_clk_freq_mhz:real:=c_clk_freq_mhz; --! the clock frequency in mhz
		constant g_time_rst_s:  real:=0.3          ); --! the reset time in seconds
	port(
		i_async: in  std_logic;          --! the signal to debounce
		i_reset: in  std_logic;          --! reset signal of the latch
		i_clk:   in  std_logic;          --! the clock
		o_done:  out std_logic           --! the debounced button
	);
end INPUT_LATCH;

architecture Behavioral of INPUT_LATCH is
    
	constant c_uvec_w	    :  natural:=uvec_width(nb_tick(g_time_rst_s,g_clk_freq_mhz/2.0)-1);              --! the width of the unsigned for counting
    subtype  t_time_lock	is unsigned(c_uvec_w-1 downto 0);                                                --! type for the time to load in the counter
    type     t_state        is (s_IDLE,s_COUNT,s_LOCK);                                                      --! state type                                               
    constant c_uvec_tck		:  t_time_lock:=to_unsigned(nb_tick(g_time_rst_s,g_clk_freq_mhz/2.0)-1,c_uvec_w);--! the time to load

    signal w_ld_slv     :std_logic_vector(c_uvec_w-1 downto 0);   --! the  time of the counter 
    signal w_ld         :std_logic;                               --! the load interupt of the counter
    signal w_done       :std_logic;                               --! the output of the counter
    signal w_next_state :t_state;                                 --! the next state
    signal w_next_idle  :t_state;                                 --! comb logic paths
    signal w_next_count :t_state;                                 --! comb logic paths
    signal w_next_lock  :t_state;                                 --! comb logic paths
    signal r_sreg       :std_logic_vector(1 downto 0)   :="00";   --! depounce register
    signal r_state      :t_state                        :=s_IDLE; --! the state register
    
    -- ============================================================================
	--                         ATTRIBUTES
	-- ----------------------------------------------------------------------------
	attribute TIG : string;             -- TIG="TRUE" - Specifies a timing ignore for the asynchronous input
	attribute IOB : string;             -- IOB="FALSE" = Specifies to not place the register into the IOB allowing 
	                                    -- both synchronization registers to exist in the same slice 
	attribute ASYNC_REG : string;       -- ASYNC_REG="TRUE" - Specifies registers will be receiving asynchronous data 
	                                    -- input to allow for better timing simulation 
	attribute HBLKNM : string;          -- HBLKNM="sync_reg" - Specifies to pack both registers into the same slice
	-- ----------------------------------------------------------------------------
	attribute TIG       of i_async : signal is "TRUE" ;
    attribute IOB       of i_async : signal is "FALSE" ;
	attribute ASYNC_REG of r_sreg  : signal is "TRUE";
	attribute HBLKNM    of r_sreg  : signal is "sync_reg";
	-- ============================================================================


begin
    syncreg:process(i_clk)
    begin
        if rising_edge(i_clk) then
            r_sreg<="00";
            if i_reset='0' then
                r_sreg<=std_logic_vector'(r_sreg(0)&i_async);
            end if;
        end if;
    end process syncreg;

    --! state register fsm
	fsm:process(i_clk)
	begin
		if rising_edge(i_clk) then
            r_state<=s_IDLE;
            case r_state is
                when s_IDLE=>
                    r_state<=s_IDLE;
                    if r_sreg(1)='1' then
                        r_state<=s_COUNT;
                    end if;
                when s_COUNT=>
                    r_state<=s_COUNT;
                    if w_done='1' then
                        r_state<=s_LOCK;
                    else
                        if r_sreg(1)='0' then
                            r_count<=s_IDLE;
                        end if;
                    end if;
                when s_LOCK=>
                    r_state<=s_LOCK;
                    if i_reset='1' then
                        r_state<=s_IDLE;
                    end if;
            end case;
			r_state<=w_next_state;
		end if;
	end process fsm;

	o_done<='1' when r_state=s_LOCK else '0';
	w_ld<='0' when r_state=s_COUNT else '1';
    
    --! counter instance
	DOWN_COUNTER_1 : entity work.DOWN_COUNTER
		generic map (
			g_unsigned_width => c_uvec_w
		)
	    port map (
			i_load_value => w_ld_slv,
			i_load       => w_ld,
			i_clk        => i_clk,
			o_done       => w_done
		);	


end Behavioral;
