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
use work.pk_controler.all;



entity SIGNAL_GENERATOR is
	port (
		i_clk           : in  std_logic;
        i_ctrl_slv      : in  tslv_ctrl;
        o_reset_ack     : out std_logic;
		o_signal_probe  : out tslv_bus_sortie;
		o_cos           : out tslv_sample;
		o_signal_rdy    : out std_logic
	);
end entity SIGNAL_GENERATOR;



architecture behav of SIGNAL_GENERATOR is

	type t_state is (s_gen_saw,s_gen_cos,s_reset,s_idle);

	signal r_state     : t_state      := s_reset;
	signal r_count_cos : t_rom_adr    := "0000";
	signal r_count_saw : t_rom_adr    := "0000";
	signal rom_saw     : t_rom_sample := c_rom_saw;
	signal rom_cos     : t_rom_sample := c_rom_cos;

	signal w_cos : t_sample;
	signal w_saw : t_sample;

	signal w_input : std_logic_vector(2 downto 0);
    signal w_ctrl : trec_ctrl;

	attribute rom_style            : string;
	attribute rom_style of rom_saw : signal is "block";
	attribute rom_style of rom_cos : signal is "block";

begin

    w_ctrl<=slv2ctrl(i_ctrl_slv);
	----------------------------------------------------------------
	-- output routing
	o_reset_ack <= '1' when r_state=s_reset else '0';

	w_cos <= rom_cos(to_integer(r_count_cos)); -- rom access
	w_saw <= rom_saw(to_integer(r_count_saw)); -- rom access

	o_signal_probe <= std_logic_vector(w_cos) & std_logic_vector(w_saw);
	o_cos          <= std_logic_vector(w_cos) when r_state=s_gen_cos else (others => '0');
	o_signal_rdy   <= '1' when r_state=s_gen_cos else
	                  '1' when r_state=s_gen_saw else
	                  '0';
	----------------------------------------------------------------



	----------------------------------------------------------------
	-- aggregate
	w_input <= w_ctrl.reset & w_ctrl.gen_active & w_ctrl.filter_active;

	--! Process managing the activity state of the generator
	fsm1 : process(i_clk)
	begin
		if rising_edge(i_clk) then

			r_state <= s_reset; --default

			--state logic
			if w_input="011" then
				r_state <= s_gen_cos;
			else
				if w_input="010" then
					r_state <= s_gen_saw;
				end if;
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

				when s_gen_saw => r_count_cos <= "0000";        	--reset the cos
								  r_count_saw <= r_count_saw+1;     --increment the sawtooth
								  
				when others    => r_count_saw <= "0000";           	--reset both
								  r_count_cos <= "0000";             --reset both
			end case;
		end if;
	end process pcount;
	----------------------------------------------------------------   

end behav;