--------------------------------------------------------------------------------
-- Title       : CONTROLER MODULE
-- Project     : ELE739 - PHASE 2
--------------------------------------------------------------------------------
-- File        : CONTROLER.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Wed Feb 24 19:08:06 2021
-- Last update : Mon Mar 29 12:06:17 2021
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2021 Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
--! Description: This module is responsible for generating either a cosine wave
--! or a sawtooth wave. The functions sampled are detailed below
--!   -  fcos(n)=1.0048*cos[ n*pi/8 + 0.05625*pi ]
--!   -  fsaw(n)=(1.0-n/8)-0.015625  </br></br></br>
-------------------------------------------------------------------------------
--! **TYPES**
--! - tslv_bus_sortie:
--!   {reg:[
--!        {name: 'MSB',   bits: 8, type: 1},
--!        {name: 'LSB',   bits: 8, type: 2},
--!    ],
--!    config:{bits:16}
--!   }
--! - tslv_sample:
--!   {reg:[
--!        {name: 'COSINUS',   bits: 8, type: 1}
--!    ],
--!    config:{bits:8}
--!   }
--! Waveform:
--! {
--!		signal:[
--!			{name: "i_clk",                      wave: "p....|...........|.."},
--!			{name: "i_ctrl_slv.reset",           wave: "x0...|....1.0....|.."},
--!			{name: "i_ctrl_slv.gen_active",      wave: "x01..|..01.......|.."},
--!			{name: "i_ctrl_slv.filter_active",   wave: "x0...|.......1...|.."},
--!			{name: "o_reset_ack",                wave: "x10..|.....1.0...|.."},
--!			{name: "o_signal_probe_MSB",         wave: "x=.==|======.==..|..",data: ["fsaw[0]","[1]","...","[16]","[0]","[1]","[0]","[1]","[0]","[1]","[0]"]},
--!			{name: "o_signal_probe_LSB",         wave: "x=...|.........==|==",data: ["fcos[0]","[1]","...","[16]","[0]","[1]","[0]","[1]","[0]","[1]","[0]"]},
--!			{name: "o_cos",        				 wave: "x=...|........===|==",data: ["0","[0]","[1]","...","[16]","[0]","[1]","[0]","[1]","[0]","[1]","[0]"]},
--!			{name: "o_signal_rdy",               wave: "x0.1.|...010.11..|.."}
--!		]
--! }


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.pk_signal_generator.all;
use work.pk_control.all;



entity SIGNAL_GENERATOR is
	port (
		i_clk           : in  std_logic;  --! Main clock
		i_clk_slow      : in  std_logic;  --! Secondary slower clock
        i_ctrl_slv      : in  tslv_ctrl;  --! control signal bus
        i_rst			: in  std_logic;
        o_reset_ack     : out std_logic;  --! reset acknowledge for global reset synchronization
		o_signal_probe  : out std_logic_vector(15 downto 0); --! output bus towards ILA
		o_cos           : out tslv_sample; --! output signal towards filter
		o_signal_rdy    : out std_logic --! output throughput indicating the start of virtual time
	);
end entity SIGNAL_GENERATOR;



architecture behav of SIGNAL_GENERATOR is

	type t_state is (s_gen_saw,s_gen_cos,s_gen_both,s_reset,s_idle);

	signal r_state     : t_state      := s_reset;
	signal w_next_state: t_state      ;
	signal r_count_cos : t_rom_adr    := "0000";
	signal r_count_saw : t_rom_adr    := "0000";
	signal w_count_cos : t_rom_adr    := "0000";
	signal w_count_saw : t_rom_adr    := "0000";
	signal r_count_slow: t_rom_adr    := "0000";
	signal rom_saw     : t_rom_sample := c_rom_saw;
	signal rom_cos     : t_rom_sample := c_rom_cos;

	signal w_cos : t_sample;
	signal w_saw : t_sample;

	attribute rom_style            : string;
	attribute rom_style of rom_saw : signal is "block";
	attribute rom_style of rom_cos : signal is "block";

begin

	----------------------------------------------------------------
	-- output routing
	o_reset_ack <= '1' when r_state=s_reset else '0';

--	w_cos <= rom_cos(to_integer(w_count_cos)); -- rom access
--	w_saw <= rom_saw(to_integer(w_count_saw)); -- rom access

	o_signal_probe <= std_logic_vector(w_cos) & std_logic_vector(w_saw);
	o_cos          <= std_logic_vector(w_cos) when r_state=s_gen_cos else (others => '0');
	o_signal_rdy   <= '0' when r_state=s_reset else '1';
	----------------------------------------------------------------

	with i_ctrl_slv select w_next_state<=
		s_gen_saw  when "001",
		s_gen_cos  when "010",
		s_gen_both when "100",
		s_reset    when others;

	----------------------------------------------------------------
	
	
	----------------------------------------------------------------
	
	Counter_MUX : process(r_state, r_count_slow, r_count_cos, r_count_saw)
	begin
	   if(r_state = s_gen_both) then
	       w_cos <= rom_cos(to_integer(r_count_slow)); -- rom access
	       w_saw <= rom_saw(to_integer(r_count_slow)); -- rom access
	   else
	       w_cos <= rom_cos(to_integer(r_count_cos)); -- rom access
	       w_saw <= rom_saw(to_integer(r_count_saw)); -- rom access
	   end if;
	   
	end process;
	
	----------------------------------------------------------------

	--! Process managing the activity state of the generator
	--! fsm_extract
	fsm1 : process(i_clk)
	begin
		if rising_edge(i_clk) then

			r_state <= s_reset; --default

			if i_rst='0' then
				r_state <= w_next_state;
			end if;
		end if;
	end process fsm1;
	----------------------------------------------------------------




	----------------------------------------------------------------
	--! process managing the increment of both signals adress in rom space
	pcount : process(i_clk)
	begin
		if rising_edge(i_clk) then
			case r_state is

				when s_gen_cos => r_count_cos <= r_count_cos+1; 	--increment the cos
								  r_count_saw <= "0000";    		--reset the sawtooth

				when s_gen_saw => r_count_cos <= r_count_cos+1;     
								  r_count_saw <= r_count_saw+1;     --increment the sawtooth

				when s_gen_both=> r_count_cos <= "0000"; --r_count_cos+1;
								  r_count_saw <= "0000"; --r_count_saw+1;
								  
				when others    => r_count_saw <= "0000";           	--reset both
								  r_count_cos <= "0000";             --reset both
			end case;
		end if;
	end process pcount;
	----------------------------------------------------------------
	
	----------------------------------------------------------------
	--! process managing the increment of both signals adress in rom space
	pcount_slow : process(i_clk_slow)
	begin
		if rising_edge(i_clk_slow) then
			case r_state is

				when s_gen_cos => r_count_slow <= "0000"; 	--reset the slow

				when s_gen_saw => r_count_slow <= "0000";   --reset the slow

				when s_gen_both=> r_count_slow <= r_count_slow+1;   -- increment the slow
								  
				when others    => r_count_slow <= "0000";   --reset the slow
			end case;
		end if;
	end process pcount_slow;
	----------------------------------------------------------------   

end behav;