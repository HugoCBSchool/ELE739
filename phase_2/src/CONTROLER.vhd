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
use work.pk_CONTROLER.all;
use work.pk_time.all;

entity CONTROLER is
	port(
		i_clk              : in  std_logic;       --! clock
		i_reset_ack_gen    : in  std_logic;       --! acknowledge from generator following reset request
		i_reset_ack_filter : in  std_logic;       --! acknowledge from filter    following reset request
        i_input_slv        : in  tslv_input;
		i_filter           : in  tslv_bus_sortie; --! output bus of filter
		i_generator        : in  tslv_bus_sortie; --! output bus of generator
		o_ctrl_bus         : out tslv_ctrl;
		o_mode_led_3       : out tslv_mode_led_3; --! led register output for mode output interface
		o_bus_sortie       : out tslv_bus_sortie;  --! output bus towards output led register
		o_reset_latch      : out tslv_input
	);
end CONTROLER;

architecture Behavioral of CONTROLER is

	signal w_in          : trec_input;
	signal w_reset_latch : trec_input;
	signal w_in_slv      : tslv_input;
	signal w_mux_out     : std_logic_vector(i_filter'length + o_mode_led_3'length -1 downto 0);

	signal r_mode    : s_mode := s_reset;
	signal r_reset_latch_next_mode : std_logic:='0';
	signal w_ctrl : trec_ctrl;
    
begin  
    ----------------------------------------------------------------------------
	--input signals routing through oop interfaces
    w_in          <=  slv2input( i_input_slv );
    o_reset_latch <=  input2slv(w_reset_latch);
    o_ctrl_bus    <=  ctrl2slv(w_ctrl);
    ----------------------------------------------------------------------------
	with r_mode select w_ctrl.gen_active<=
		'1' when s_gen,
		'1' when s_filter,
		'0' when others;

	with r_mode select w_ctrl.filter_active<=
		'1' when s_filter,
		'0' when others;
		
	with r_mode select w_ctrl.reset<=
		'1'			 when s_reset,
		'1'			 when s_idle,
		w_in.restart when others;
	----------------------------------------------------------------------------
	----------------------------------------------------------------------------
	with r_mode select w_reset_latch.RESET_G   <= 
	   (w_in.reset_g and i_reset_ack_filter and  i_reset_ack_gen)  when s_reset,
	   ('0'                                                     )  when others; 
    
    w_reset_latch.next_mode <= r_reset_latch_next_mode;
    
    with r_mode select w_reset_latch.restart <= 
        (w_in.restart and i_reset_ack_filter and i_reset_ack_gen) when s_filter,
        (w_in.restart and i_reset_ack_filter and i_reset_ack_gen) when s_gen,
        (w_in.restart                                           ) when s_idle,
        (w_in.restart                                           ) when s_reset;

	----------------------------------------------------------------------------
	--output mux logic
	with r_mode select w_mux_out <=
	    ( c_mode_led_reset  & std_logic_vector(to_unsigned(0,i_filter'length)) ) when s_reset,
		( c_mode_led_idle   & std_logic_vector(to_unsigned(0,i_filter'length)) ) when s_idle,
		( c_mode_led_filter & i_filter                                         ) when s_filter,
		( c_mode_led_gen    & i_generator                                      ) when s_gen;

	-- output mux outputs routing
	o_bus_sortie <= w_mux_out( i_filter'length  - 1 downto 0 );
	o_mode_led_3 <= w_mux_out( w_mux_out'length - 1 downto i_filter'length );
	----------------------------------------------------------------------------
	fsm: process(i_clk)
	begin
		if rising_edge(i_clk) then

            r_mode 					<=s_reset;
            r_reset_latch_next_mode	<='0';

            if w_in.reset_g='0' then

            	r_mode <= r_mode;

            	if w_in.next_mode='1' then

            		r_reset_latch_next_mode<='1';

            		case r_mode is
	            		when s_reset  => r_mode <=s_idle;
	            		when s_idle   => r_mode <=s_gen;
	            	    when s_gen    => r_mode <=s_filter;
	            	    when s_filter => r_mode <=s_idle;
            		end case;

            	end if;

            end if;

        end if;
	end process fsm;


end Behavioral;
