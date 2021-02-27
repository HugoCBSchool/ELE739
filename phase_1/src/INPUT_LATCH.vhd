----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/12/2021 11:48:59 AM
-- Design Name: 
-- Module Name: INPUT_LATCH - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.pk_time.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity INPUT_LATCH is
	generic(
		constant g_clk_freq_mhz:real:=100.0;--c_clk_freq_mhz;
		constant g_time_rst_s:real:=0.005
	);
	port(
		i_sync:in std_logic;
		i_reset:in std_logic;
		i_clk:in std_logic;
		o_done:out std_logic
	);
end INPUT_LATCH;

architecture Behavioral of INPUT_LATCH is


	constant c_uvec_w			: natural :=uvec_width(nb_tick(g_time_rst_s,g_clk_freq_mhz)-1);
    subtype  t_time_lock	is unsigned(c_uvec_w-1 downto 0);
    constant c_uvec_tck			: t_time_lock:=to_unsigned(nb_tick(g_time_rst_s,g_clk_freq_mhz)-1,c_uvec_w);

    type t_state is (s_IDLE,s_COUNT,s_LOCK);
    signal w_ld_slv:std_logic_vector(c_uvec_w-1 downto 0);

    signal w_next_state:t_state;
    signal r_state:t_state:=s_IDLE;
    signal w_next_idle,w_next_count,w_next_lock:t_state;
    signal w_ld,w_done:std_logic;
    signal r_count:signed(c_uvec_w downto 0):=signed('0'&std_logic_vector(c_uvec_tck));
    signal w_reset_intr:std_logic;
    signal w_intr:std_logic;
begin

    w_reset_intr<=w_intr when r_state=s_COUNT else '1';
    
    
	w_next_idle	<=	s_COUNT 	when i_sync='1' 		else 
					s_IDLE;
					
	w_next_count<=	s_LOCK when (w_done='1') else
					s_IDLE when (i_sync='0') else
					s_COUNT;
	w_next_lock	<=	s_IDLE		when i_reset='1' else 
					s_LOCK;


	with r_state select w_next_state<=
		w_next_idle 	when s_IDLE,
		w_next_lock 	when s_LOCK,
		w_next_count	when s_COUNT,
		s_IDLE 			when others; 


	fsm:process(i_clk)
	begin
		if rising_edge(i_clk) then
			r_state<=w_next_state;
		end if;
	end process fsm;

	w_ld_slv <= std_logic_vector(c_uvec_tck);
	o_done<='1' when r_state=s_LOCK else '0';
	w_ld<='0' when r_state=s_COUNT else '1';

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
