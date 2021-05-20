----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2021 12:00:00 PM
-- Design Name: 
-- Module Name: TOP_TB - Behavioral
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

-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity TOP_TB is
end TOP_TB;

architecture Behavioral of TOP_TB is
    signal s_pbn_restart     : std_logic;
	signal s_pbn_next        : std_logic;
	signal s_pbn_reset_g     : std_logic;
	signal s_clk             : std_logic;

	signal s_idle_led        : std_logic;
	signal s_gen_led         : std_logic;
	signal s_fil_led         : std_logic;
	signal s_small_led       : std_logic;
begin

    ----------------------------------------------------------------------------------
    -- Clock signal simulation.
    ----------------------------------------------------------------------------------
        
        -- simulation of a 100MHz clock with a 50% duty cycle.
        clk_gen : process
        begin
            s_clk <= '1';
            wait for 5 ns;
            s_clk <= '0';
            wait for 5 ns;
        end process clk_gen;
    
    ----------------------------------------------------------------------------------
    -- Stimuli simulation
    ----------------------------------------------------------------------------------
    
    main : process
    begin
        s_pbn_next      <= '0';
        s_pbn_reset_g   <= '0';
        wait for 160 ns;
        s_pbn_next      <= '1';
        wait for 80 ns;
        s_pbn_next      <= '0';
        wait for 80 ns;
        s_pbn_next      <= '1';
        wait for 80 ns;
        s_pbn_next      <= '0';
        wait for 2000 ns;
        s_pbn_next      <= '1';
        wait for 80 ns;
        s_pbn_next      <= '0';
        wait for 2000 ns;
        s_pbn_next      <= '1';
        wait for 80 ns;
        s_pbn_next      <= '0';
        wait;
    end process main;
    
    reset : process
    begin
        s_pbn_restart <= '1';
        wait for 160 ns;
        s_pbn_restart <= '0';
        wait;
    end process reset;
    
    ----------------------------------------------------------------------------------
    -- Instantiation of the devices under test.
    ----------------------------------------------------------------------------------
    
    DUT : entity work.TOP
        generic map (
            g_debouncer_shreg_width   => 6,
            g_signal_length           => 16
        )
        port map(
            i_pbn_restart     => s_pbn_restart,
            i_pbn_next        => s_pbn_next,
            i_pbn_reset_g     => s_pbn_reset_g,
            i_clk             => s_clk,
    
            o_idle_led        => s_idle_led,
            o_gen_led         => s_gen_led,
            o_fil_led         => s_fil_led,
            o_small_led       => s_small_led
        );
end Behavioral;
