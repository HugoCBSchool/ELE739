----------------------------------------------------------------------------------
-- Company: ETS.
-- Team members :   Gabriel Gandubert, Hugo Cusson-Bouthillier and 
--                  Ernesto Castaldo-Santillan
--
-- Author :         Gabriel Gandubert
-- 
-- Create Date: 03/21/2021
-- Design Name: SMALL_FIR_FILTER_TB - Behavior
-- Project Name: ELE739 - Phase 3
-- Target Devices: Basys 3
-- Description: 
--  This test bench tests the behavior of a small FIR filter optimized in coverage
--  area. The input of the component is an 8 bits signal and the output is a 16 bits
--  signal. The coefficients of the component are defined in the package pk_small_fir_filter.
-- 
-- File dependencies: 
--  SMALL_FIR_FILTER.vhd
--  pk_small_fir_filter.vhd
-- 
-- Revision:
--   Revision 0.01 - File Created
-- Additional Comments:
--    For each variable name, the following indicators are used:
--        g_<var> : generic
--        i_<var> : input
--        o_<var> : output
--        w_<var> : internal wire
--        r_<var> : register
--        c_<var> : constant
--        s_<var> : local signal
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity SMALL_FIR_FILTER_TB is
end SMALL_FIR_FILTER_TB;

architecture Behavioral of SMALL_FIR_FILTER_TB is  
    --signal s_clk : STD_LOGIC;
    --signal s_clk_fast : STD_LOGIC;
    signal s_clk_in : STD_LOGIC;
    signal s_signal_rdy:std_logic:='1';
    
    signal s_signal   :          STD_LOGIC_VECTOR(7 downto 0);
    signal s_reset     :          STD_LOGIC;
    signal s_small_filter_active: STD_LOGIC;
    signal s_reset_ack :          STD_LOGIC;
    signal s_filter_rdy :         STD_LOGIC;
    signal s_small_filter:        STD_LOGIC_VECTOR(15 downto 0);
begin
    ----------------------------------------------------------------------------------
    -- Clock signal simulation.
    ----------------------------------------------------------------------------------
    
    -- simulation of a 100MHz clock with a 50% duty cycle.
    fast_clk_gen : process
    begin
        s_clk_in <= '0';
        wait for 5 ns;
        s_clk_in <= '1';
        wait for 5 ns;
    end process fast_clk_gen;
    
--    fast_clk_gen : process
--    begin
--        s_clk_fast <= '1';
--        wait for 5 ns;
--        s_clk_fast <= '0';
--        wait for 5 ns;
--    end process fast_clk_gen;
    
--    clk_gen : process
--    begin
--        s_clk <= '1';
--        wait for 40 ns;
--        s_clk <= '0';
--        wait for 40 ns;
--    end process clk_gen;
    
    ----------------------------------------------------------------------------------
    -- Stimuli simulation
    ----------------------------------------------------------------------------------
    
    main : process
    begin
        s_signal <= "11111111";
        s_small_filter_active <= '1';
        wait for 400 ns;
        s_signal <= "01010101";
        wait for 80 ns;
        s_signal <= "00000001";
        wait for 80 ns;
        s_signal <= "00000010";
        wait for 80 ns;
        s_signal <= "00000011";
        wait for 920 ns;
        s_signal <= "00000001";
        wait for 80 ns;
        s_signal <= "00000000";
        wait;
    end process main;
    
    reset : process
    begin
        s_reset <= '1';
        wait for 160 ns;
        s_reset <= '0';
        wait for 1360 ns;
        s_reset <= '1';
        wait for 80 ns;
        s_reset <= '0';
        wait;
    end process reset;
    ----------------------------------------------------------------------------------
    -- Instantiation of the devices under test.
    ----------------------------------------------------------------------------------

    
    DUT: entity work.CLK_TEST
        port map(   i_average               => s_signal,
                    i_clk                   => s_clk_in,
                    i_reset                 => s_reset,
                    i_signal_rdy            => s_signal_rdy,
                    i_small_filter_active   => s_small_filter_active,
                    o_reset_ack             => s_reset_ack,
                    o_small_filter          => s_small_filter,
                    o_filter_rdy            => s_filter_rdy);

end Behavioral;
