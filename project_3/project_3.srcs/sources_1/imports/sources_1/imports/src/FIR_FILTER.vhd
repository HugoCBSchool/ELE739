----------------------------------------------------------------------------------
-- Company: ETS.
-- Team members :   Gabriel Gandubert, Hugo Cusson-Bouthillier and 
--                  Ernesto Castaldo-Santillan
--
-- Author :         Gabriel Gandubert
-- 
-- Create Date: 02/22/2021
-- Design Name: FIR_FILTER_HEAD - Behavior
-- Project Name: ELE739 - Phase 2
-- Target Devices: Basys 3
-- Description: 
--  This component represents the first slice of DSP48E1 used to calculate the
--  filtered first slice. This component can be grouped with the CASCADE component
--  and the TAIL component to complete the filter.
-- 
-- File dependencies: 
--   None
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

-- Standard IEEE VHDL functions for synthesis and simulation behavior.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- This library Xilinx : contains the component declarations for all Xilinx
-- primitives : primitives and points to the models that will be used
-- for simulation.
Library UNISIM;
use UNISIM.vcomponents.all;

-- FIR filter entity. Control of the values of the parameters of the filter.
entity FIR_FILTER is
  Port ( 
    i_signal :          IN STD_LOGIC_VECTOR(7 downto 0);
    i_reset  :          IN STD_LOGIC;
    i_active_filter :   IN STD_LOGIC;
    i_signal_rdy:       IN STD_LOGIC;
    i_clk :             IN STD_LOGIC;
    o_filter :          OUT STD_LOGIC_VECTOR(15 downto 0);
    o_reset_ack :       OUT STD_LOGIC;
    o_filter_rdy :      OUT STD_LOGIC
  );
end FIR_FILTER;

architecture Behavioral of FIR_FILTER is
    
    constant c_width_A: natural := 8;
    constant c_width_AC: natural := 30;
    constant c_width_coef: natural := 6;
    constant c_width_P: natural := 48;
    constant c_width_reg: natural := 11;
    
    -- Output of the last stage of the filter.
    signal r_P: STD_LOGIC_VECTOR(c_width_P-1 downto 0);
    signal w_filter: STD_LOGIC_VECTOR(15 downto 0);
    signal w_reset_ack: STD_LOGIC;
    
    -- Shift register for the output of the filter_rdy signal
    signal r_filter_rdy: STD_LOGIC_VECTOR(c_width_reg-1 downto 0):=(others=>'0');
    
    -- Transition signals between each slice of the FIR filter.
    signal w_ACOUT_0 :            STD_LOGIC_VECTOR(c_width_AC-1 downto 0);
    signal w_PCOUT_0 :            STD_LOGIC_VECTOR(c_width_P-1 downto 0);
    signal w_ACOUT_1 :            STD_LOGIC_VECTOR(c_width_AC-1 downto 0);
    signal w_PCOUT_1 :            STD_LOGIC_VECTOR(c_width_P-1 downto 0);
    signal w_ACOUT_2 :            STD_LOGIC_VECTOR(c_width_AC-1 downto 0);
    signal w_PCOUT_2 :            STD_LOGIC_VECTOR(c_width_P-1 downto 0);
    signal w_ACOUT_3 :            STD_LOGIC_VECTOR(c_width_AC-1 downto 0);
    signal w_PCOUT_3 :            STD_LOGIC_VECTOR(c_width_P-1 downto 0);
    signal w_ACOUT_4 :            STD_LOGIC_VECTOR(c_width_AC-1 downto 0);
    signal w_PCOUT_4 :            STD_LOGIC_VECTOR(c_width_P-1 downto 0);
    signal w_ACOUT_5 :            STD_LOGIC_VECTOR(c_width_AC-1 downto 0);
    signal w_PCOUT_5 :            STD_LOGIC_VECTOR(c_width_P-1 downto 0);
    signal w_ACOUT_6 :            STD_LOGIC_VECTOR(c_width_AC-1 downto 0);
    signal w_PCOUT_6 :            STD_LOGIC_VECTOR(c_width_P-1 downto 0);
    
    -- Coefficients of each stage of the FIR filter. 0 is the first input multiplier
    -- and 7 is the last register multiplier.
    constant c_coefficient_0: STD_LOGIC_VECTOR(c_width_coef-1 downto 0) := "000001";
    constant c_coefficient_1: STD_LOGIC_VECTOR(c_width_coef-1 downto 0) := "000010";
    constant c_coefficient_2: STD_LOGIC_VECTOR(c_width_coef-1 downto 0) := "000011";
    constant c_coefficient_3: STD_LOGIC_VECTOR(c_width_coef-1 downto 0) := "000100";
    constant c_coefficient_4: STD_LOGIC_VECTOR(c_width_coef-1 downto 0) := "000101";
    constant c_coefficient_5: STD_LOGIC_VECTOR(c_width_coef-1 downto 0) := "000110";
    constant c_coefficient_6: STD_LOGIC_VECTOR(c_width_coef-1 downto 0) := "000111";
    constant c_coefficient_7: STD_LOGIC_VECTOR(c_width_coef-1 downto 0) := "001000";

begin
    
    -- Set the output value with the respective signal value.
    o_filter <= w_filter;
    o_reset_ack <= w_reset_ack;
    o_filter_rdy <= r_filter_rdy(c_width_reg-1);
    
    -- Output of the filter ajusted for a 16 bits signal.
    process(i_clk)
    begin
        -- Register of the output 
        if(rising_edge(i_clk)) then
            w_reset_ack<='0';
            -- Reset of the output register. A reset acknoledge is sent.
            if(i_reset = '1') then
                w_filter <= (others => '0');
                w_reset_ack <= '1';
                r_filter_rdy <= (others => '0');
            else
                if(i_active_filter = '1') then
                    -- Output of the final register of the filter
                    w_filter <= r_P(15 downto 0);
                    -- Shift register to indicate when the output of the filter is ready.
                    r_filter_rdy <= r_filter_rdy(c_width_reg-2 downto 0) & i_signal_rdy;
                else
                    -- For an inactive filter, keep the same value.
                    w_filter <= w_filter;
                    r_filter_rdy <= r_filter_rdy;
                end if;
            end if;
        end if;
    end process;
    
    ----------------------------------------------------------------------------------
    -- Configuration of the slices of the filter.
    ----------------------------------------------------------------------------------
    
    -- First stage of the filter.
    slice_0: entity work.FIR_FILTER_HEAD
        generic map(g_A_input_width     => c_width_A,
                    g_B_input_width     => c_width_coef)
        port map(   i_signal        => i_signal,
                    i_coefficient   => c_coefficient_0,
                    i_clk           => i_clk,
                    i_reset         => i_reset,
                    i_active_filter => i_active_filter,
                    o_ACOUT         => w_ACOUT_0,
                    o_PCOUT         => w_PCOUT_0);
   
    -- Second stage of the filter. 
    slice_1: entity work.FIR_FILTER_CASCADE
        generic map(g_B_input_width     => c_width_coef)
        port map(   i_ACIN          => w_ACOUT_0,
                    i_PCIN          => w_PCOUT_0,
                    i_coefficient   => c_coefficient_1,
                    i_clk           => i_clk,
                    i_reset         => i_reset,
                    i_active_filter => i_active_filter,
                    o_ACOUT         => w_ACOUT_1,
                    o_PCOUT         => w_PCOUT_1);
    
    -- Third stage of the filter. 
    slice_2: entity work.FIR_FILTER_CASCADE
        generic map(g_B_input_width     => c_width_coef)
        port map(   i_ACIN          => w_ACOUT_1,
                    i_PCIN          => w_PCOUT_1,
                    i_coefficient   => c_coefficient_2,
                    i_clk           => i_clk,
                    i_reset         => i_reset,
                    i_active_filter => i_active_filter,
                    o_ACOUT         => w_ACOUT_2,
                    o_PCOUT         => w_PCOUT_2);
    
    -- Fourth stage of the filter.
    slice_3: entity work.FIR_FILTER_CASCADE
        generic map(g_B_input_width     => c_width_coef)
        port map(   i_ACIN          => w_ACOUT_2,
                    i_PCIN          => w_PCOUT_2,
                    i_coefficient   => c_coefficient_3,
                    i_clk           => i_clk,
                    i_reset         => i_reset,
                    i_active_filter => i_active_filter,
                    o_ACOUT         => w_ACOUT_3,
                    o_PCOUT         => w_PCOUT_3);
    
    -- Fifth stage of the filter.
    slice_4: entity work.FIR_FILTER_CASCADE
        generic map(g_B_input_width     => c_width_coef)
        port map(   i_ACIN          => w_ACOUT_3,
                    i_PCIN          => w_PCOUT_3,
                    i_coefficient   => c_coefficient_4,
                    i_clk           => i_clk,
                    i_reset         => i_reset,
                    i_active_filter => i_active_filter,
                    o_ACOUT         => w_ACOUT_4,
                    o_PCOUT         => w_PCOUT_4);
    
    -- Sixth stage of the filter.
    slice_5: entity work.FIR_FILTER_CASCADE
        generic map(g_B_input_width     => c_width_coef)
        port map(   i_ACIN          => w_ACOUT_4,
                    i_PCIN          => w_PCOUT_4,
                    i_coefficient   => c_coefficient_5,
                    i_clk           => i_clk,
                    i_reset         => i_reset,
                    i_active_filter => i_active_filter,
                    o_ACOUT         => w_ACOUT_5,
                    o_PCOUT         => w_PCOUT_5);
    
    -- Seventh stage of the filter.
    slice_6: entity work.FIR_FILTER_CASCADE
        generic map(g_B_input_width     => c_width_coef)
        port map(   i_ACIN          => w_ACOUT_5,
                    i_PCIN          => w_PCOUT_5,
                    i_coefficient   => c_coefficient_6,
                    i_clk           => i_clk,
                    i_reset         => i_reset,
                    i_active_filter => i_active_filter,
                    o_ACOUT         => w_ACOUT_6,
                    o_PCOUT         => w_PCOUT_6);
    
    -- Last stage of the filter.
    slice_7: entity work.FIR_FILTER_TAIL
        generic map(g_B_input_width     => c_width_coef,
                    g_P_output_width    => c_width_P)
        port map(   i_ACIN          => w_ACOUT_6,
                    i_PCIN          => w_PCOUT_6,
                    i_coefficient   => c_coefficient_7,
                    i_clk           => i_clk,
                    i_reset         => i_reset,
                    i_active_filter => i_active_filter,
                    o_P             => r_P);

end Behavioral;
