--------------------------------------------------------------------------------
-- Project     : ELE792-h21-projet_1
--------------------------------------------------------------------------------
-- File        : INPUT_INTERFACE.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Sat Jan 30 13:56:46 2021
-- Last update : Fri Feb  5 12:47:53 2021
--------------------------------------------------------------------------------
-- Copyright (c) Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: 
-- this module synchronizes the async inputs of the basys3 and 
-- manages reset behaviour on them
--      
--------------------------------------------------------------------------------
--! **TYPES**
--! - trec_input:
--!{reg:[
--!        {name: 'maint',   bits: 1, type: 1},
--!        {name: 'step',   bits: 1, type: 2},
--!        {name: 'nxt',   bits: 1,type: 3},
--!        {name: 'ped', bits: 1, type: 4}
--!    ],
--! config:{bits:4}
--!}
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

--------------------------------------------------------------------------------
-- entity input_interface
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.pk_INPUT_INTERFACE.all;
--------------------------------------------------------------------------------

--! this module synchronizes the async inputs of the basys3 and 
--! manages reset behaviour on them
entity INPUT_INTERFACE is

	Port (
		i_clk          : in  std_logic;  --! clock
		i_reset_slv    : in  tslv_input; --! entree des reset pour les latch
		i_hw_input_slv : in  tslv_input; --! entree des io asynchrones
		o_req_slv      : out tslv_input  --! sortie des signaux de requete usager synchrones
	);

end entity INPUT_INTERFACE;
--------------------------------------------------------------------------------
architecture Behavioral of INPUT_INTERFACE is

	--  signals for local sync of async inputs
	signal r_sreg_1         : std_logic_vector(3 downto 0) := "0000"; --! sync register
	signal r_sreg_2         : std_logic_vector(3 downto 0) := "0000"; --! sync register for the 4 async inputs
	signal w_pbn_next       : std_logic;                              --!  alias for locally synchronized async input counterpart
	signal w_pbn_ped_req    : std_logic;                              --!  alias for locally synchronized async input counterpart
	signal w_pbn_maint_mode : std_logic;                              --!  alias for locally synchronized async input counterpart

	signal w_reset , w_req , w_sync , w_hw_in : trec_input; --! record interface instances

	--  signals for request latches for push buttons
	signal r_next_req       : std_logic := '0'; --! button latch register
	signal r_ped_req        : std_logic := '0'; --! button latch register
	signal r_maint_mode_req : std_logic := '0'; --! button latch register

begin

	w_reset <= slv2input(i_reset_slv); --  reset inputs typecast
	w_sync  <= slv2input(r_sreg_2);    --  forward register level2 to sync record
	w_hw_in <= slv2input(i_hw_input_slv);

	-- output requuest interface wiring
	w_req.ped   <= r_ped_req;
	w_req.nxt   <= r_next_req;
	w_req.maint <= r_maint_mode_req;
	w_req.step  <= w_sync.step;
	o_req_slv   <= input2slv(w_req); -- typecast towards output

	--! synchronization process
	--! 2 registers 4-wide in series to synchronize ios
	p_SYNC : process(i_clk)
	begin
		if rising_edge(i_clk) then
			r_sreg_2 <= r_sreg_1;       --!\forward register level1 to register level 2 
			r_sreg_1 <= i_hw_input_slv; --forward async input to register level 1 
		end if;
	end process p_SYNC;


	--! processus des latch pour les signaux des boutons
	--! chaque sortie de bouton doit etre mis a 1 lors d'un push usager
	--! elle le demeure tant que son signal de reset n'est pas mis a 1
	p_EDGE_PBNS : process(i_clk)
	begin
		if rising_edge(i_clk) then

			if (w_reset.nxt='1') then
				r_next_req <= '0';
			else
				r_next_req <= r_next_req OR w_sync.nxt;
			end if;

			if (w_reset.ped='1') then
				r_ped_req <= '0';
			else
				r_ped_req <= r_ped_req OR w_sync.ped;
			end if;

			--  if reset, we force down. 
			if (w_reset.maint='1') then
				r_maint_mode_req <= '0';
			else
				r_maint_mode_req <= r_maint_mode_req OR w_sync.maint; --  if currently 0, latching implies that
			end if;

		end if;
	end process p_EDGE_PBNS;

end Behavioral;


----------------------------------------------------------------------------------


