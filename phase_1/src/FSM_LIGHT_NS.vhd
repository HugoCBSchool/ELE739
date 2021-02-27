--------------------------------------------------------------------------------
-- Project     : ELE792-h21-projet_1
--------------------------------------------------------------------------------
-- File        : FSM_LIGHT_NS.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Sat Jan 30 13:56:46 2021
-- Last update : Fri Feb 12 13:10:02 2021
--------------------------------------------------------------------------------
-- Copyright (c) Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: 
-- 	This module implements the FSM controlling the NS light output
--  - its FSM only transits once it received the next acknowledgement from the controller.
--	- its initial state is maintenance in which the red light is strobing
--  - it will only reflect a change in the 2 mode selectors of the input once 
--       it has reached the red light for 1 strobe period.
--  - in maintenance mode, the red light will strobe
--	- in not maintenance mode, it follows the linear path red->green->yellow->red.
--	- in step-mode, the internal timer is bypassed which translates to the done-output always being high. 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.pk_time.all;
--------------------------------------------------------------------------------
entity FSM_LIGHT_NS is
	generic (
		constant g_clk_freq_mhz:real:=100.0;
		constant g_time_G_NS_s:real:=10.0;
		constant g_time_Y_NS_s : real := 3.0;
		constant g_time_R_strobe_s : real := 1.0  
	);
	Port (
		i_clk        : in  STD_LOGIC;                   --  input clock
		i_next       : in  STD_LOGIC;                   --  logic level signaling(high) request for transition to next light in sequence
		i_maint_mode : in  STD_LOGIC;                   --  logic level set to high to operate in maintenance mode, changes only take effect when red state is met
		i_step_mode  : in  std_logic;                   --  logic level set to high to operate in step mode
		o_count_done : out std_logic;                   --  logic level signaling that the fsm is ready to transition to the next state
		o_light      : out std_logic_vector(2 downto 0) --  vector bijective with light logic levels: form is as follows [2,1,0]->[GREEN,YELLOW,RED]
	);
end FSM_LIGHT_NS;
--------------------------------------------------------------------------------
architecture Behavioral of FSM_LIGHT_NS is

	constant c_max_time_NS_s    :   real:= max_real( 
                                        max_real( g_time_G_NS_s , g_time_Y_NS_s )  ,
                                        g_time_R_strobe_s
                                    );
    constant c_uvec_w_NS        :   natural:= uvec_width(nb_tick(c_max_time_NS_s,g_clk_freq_mhz)-3);
    
    --  unsigned type of length defined by max value of time to count
    subtype  t_time_NS is  unsigned(c_uvec_w_NS-1 downto 0);
    
    --  time constants expressed in subtype format
    constant c_uvec_G_NS_tck        :   t_time_NS := to_unsigned( nb_tick(g_time_G_NS_s,g_clk_freq_mhz)-3   , c_uvec_w_NS );
    constant c_uvec_Y_NS_tck        :   t_time_NS := to_unsigned( nb_tick(g_time_Y_NS_s,g_clk_freq_mhz)-3   , c_uvec_w_NS );
    constant c_uvec_strobe_NS_tck   :   t_time_NS := to_unsigned( nb_tick(g_time_R_strobe_s,g_clk_freq_mhz)-3 , c_uvec_w_NS );

	--  states encoded as one hot for jhonson-based implementation
	constant S_RED    : std_logic_vector(2 downto 0) := "001";
	constant S_GREEN  : std_logic_vector(2 downto 0) := "100";
	constant S_YELLOW : std_logic_vector(2 downto 0) := "010";
	constant S_OFF    : std_logic_vector(2 downto 0) := "000";

	--  internal signals
	signal r_state          : std_logic_vector(2 downto 0) := S_RED;    --  state register
	signal w_next_state     : std_logic_vector(2 downto 0);             --  for input logic dataflow
	signal w_next_red       : std_logic_vector(2 downto 0);             --  temporary variable for with-select construct
	signal w_next           : std_logic;                                --  step mode multiplexer output
	signal w_load_value     : t_time_NS;                                --  the output of the rom selecting the next time to load in the counter
	signal w_slv_load_value : std_logic_vector(c_uvec_w_NS-1 downto 0); --  type conversion alias for typecasting the time to load in the counter 
	signal w_load           : std_logic;                                --  the multiplexed load signal to issue a load command at the timer
	signal w_count_done     : std_logic;                                --  intermediary signal to forward output of timer towards this module output mux

begin
	----------------------------------------------------------------------------------------
	--  comb output logic
	o_light <= r_state; --one hot encoded gives a bijection between register content and output level

	--  step mode logic 
	o_count_done <= w_count_done when i_step_mode='0' else i_step_mode; --  step mode logic 



	----------------------------------------------------------------------------
	-- FSM for state logic
	----------------------------------------------------------------------------
	--  next state logic combinatorial
	w_next_red <= S_GREEN when (i_maint_mode='0') else S_OFF; -- selection of red transition result

	-- linear path through light cycle until red is met. After which, the mode selection occures
	with r_state select w_next_state <=
		S_YELLOW   when S_GREEN,
		S_RED      when S_YELLOW,
		S_RED      when S_OFF,
		w_next_red when S_RED,
		S_RED      when others; -- selection of next state to occure

	--  register clocked process
	REG : process(i_clk)
	begin
		--clocked event
		if rising_edge(i_clk) then
			--  i_next acts as a multiplexer between current state and comb-resulting next state
			if (i_next='1')
			then r_state <= w_next_state;
			else r_state <= r_state;
			end if;
		end if;
	end process REG;
	---------------------------------------------------------------------------


	----------------------------------------------------------------------------
	-- Timer instance 
	----------------------------------------------------------------------------
	-- selection of next timer set value using next state set value                                   
	with w_next_state select w_load_value <=
		c_uvec_G_NS_tck      when S_GREEN,
		c_uvec_Y_NS_tck      when S_YELLOW,
		c_uvec_strobe_NS_tck when S_RED,
		c_uvec_strobe_NS_tck when S_OFF,
		(others => '-')      when others;
	
	w_load<=i_next;	

	--type casting shaninigans for 93 port map compliance
	w_slv_load_value <= std_logic_vector(w_load_value(c_uvec_w_NS-1 downto 0)); 
	
	-- timer instanciation
	U_counter : entity work.DOWN_COUNTER
		generic map( g_unsigned_width => c_uvec_w_NS )
		port map(
			i_load_value => w_slv_load_value,
			i_load       => w_load,
			i_clk        => i_clk,
			o_done       => w_count_done
		);
	---------------------------------------------------------------------------

end Behavioral;
----------------------------------------------------------------------------------------
