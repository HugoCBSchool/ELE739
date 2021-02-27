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

entity INPUT_LATCH is
	generic(
		constant g_clk_freq_mhz:real:=c_clk_freq_mhz;
		constant g_time_rst_s:real:=0.3
	);
	port(
		i_sync:in std_logic;
		i_reset:in std_logic;
		i_clk:in std_logic;
		o_done:out std_logic
	);
end INPUT_LATCH;

architecture Behavioral of INPUT_LATCH is

    --component clk_wiz_0
    --    port(
    --      o_clk_9MHz24  : out    std_logic;
    --      i_clk_464_mhz : in     std_logic
    --    );
    --end component;
    
	constant c_uvec_w			: natural :=uvec_width(nb_tick(g_time_rst_s,g_clk_freq_mhz/2.0)-1);
    subtype  t_time_lock	is unsigned(c_uvec_w-1 downto 0);
    constant c_uvec_tck			: t_time_lock:=to_unsigned(nb_tick(g_time_rst_s,g_clk_freq_mhz/2.0)-1,c_uvec_w);

    type t_state is (s_IDLE,s_COUNT,s_LOCK);
    
    signal w_ld_slv   :std_logic_vector(c_uvec_w-1 downto 0);
    signal r_ld_slv_d :std_logic_vector(c_uvec_w-1 downto 0):=(others=>'0');
    signal r_ld_slv_dd:std_logic_vector(c_uvec_w-1 downto 0):=(others=>'0');
    
    signal w_ld     :std_logic;
    signal r_ld_d   :std_logic:='0';
    signal r_ld_dd  :std_logic:='0';
    
    signal w_done   :std_logic;
    signal r_done_d :std_logic:='0';
    signal r_done_dd:std_logic:='0';
    
    signal w_next_state:t_state;
    signal r_state:t_state:=s_IDLE;
    signal w_next_idle,w_next_count,w_next_lock:t_state;
        
begin
    
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

	--w_ld_slv <= std_logic_vector(c_uvec_tck);
	o_done<='1' when r_state=s_LOCK else '0';
	w_ld<='0' when r_state=s_COUNT else '1';
    
    
   -- hi2lo:process(w_clk_divide_by_50)
    --begin
    --    if rising_edge(w_clk_divide_by_50) then
     --      r_ld_slv_d  <=w_ld_slv;
    --       r_ld_slv_dd <=r_ld_slv_d;
    --       
     --      r_ld_d      <=w_ld;
     --      r_ld_dd     <=r_ld_d;
     --   end if;
    --end process hi2lo;
    --lo2hi:process(i_clk)
    --begin
    --    if rising_edge(i_clk) then
    --        r_done_d  <=w_done;
    --        r_done_dd <=r_done_d;
    --    end if;
   -- end process lo2hi;
    
    
    --TIMER_1:entity work.TIMER
    --    generic map(
    --        g_clk_freq_mhz=>g_clk_freq_mhz,
    --        g_time_count_s=>g_time_rst_s
    --    )
    --    port map(
    --        i_rst=>w_ld,
    --        i_clk=>i_clk,
    --        o_done=>w_done
    --    );
	DOWN_COUNTER_1 : entity work.DOWN_COUNTER
		generic map (
			g_unsigned_width => c_uvec_w
		)
	    port map (
			i_load_value => r_ld_slv_dd,
			i_load       => r_ld_dd,
			i_clk        => i_clk,
			o_done       => w_done
		);	


end Behavioral;
