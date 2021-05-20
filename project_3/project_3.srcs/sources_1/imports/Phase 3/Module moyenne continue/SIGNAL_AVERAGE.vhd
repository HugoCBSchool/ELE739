--------------------------------------------------------------------------------
-- Title       : AVERAGE MODULE
-- Project     : ELE739 - PHASE 3
--------------------------------------------------------------------------------
-- File        : SIGNAL_AVERAGE.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Wed Mar 23 20:15:46 2021
-- Last update : Mon Mar 29 12:14:49 2021
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2021 Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
--! Description: This component computes the average of the input signal by 
--!  slicing it into two signals, adding them together and removing the LSB. 
--!  This module is used to generate another signal for the SMALL_FIR_FILTER 
--!  requested in this project.
--!  NOTE : This component includes an output register, but no input register. 
--!  It is assumed that the input signal originates from a register to reduce
--!  the timing constraints.
-------------------------------------------------------------------------------
--! Waveform:
--! {
--!		signal:[
--!			{name: "i_clk",                      wave: "p......................"},
--!			{name: "i_signal",                   wave: "x=...=.=.=.=.=.........",data: ["A&B","C&D"]},
--!			{name: "s_signal_MSB",               wave: "x=...=.=.=.=.=.........",data: ["A","C"]},
--!			{name: "s_signal_LSB",               wave: "x=...=.=.=.=.=.........",data: ["B","D"]},
--!			{name: "i_reset",                    wave: "1..0...........1.0....."},
--!			{name: "i_average_active",           wave: "x1.........0.1........."},
--!			{name: "o_avrg_rdy",                 wave: "0..1.......0.1.0.1....."},
--!			{name: "o_average",                  wave: "x0.=...=.=...=.0.=.....",data: ["(A+B)/2","(C+D)/2"]},
--!			{name: "o_reset_ack",        	     wave: "x1.0...........1.0....."}
--!		]
--! }


-- Standard IEEE VHDL functions for synthesis and simulation behavior.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity SIGNAL_AVERAGE is
  generic (
     g_signal_length : NATURAL := 16    -- Input signal length with default value. MUST BE AN EVEN NUMBER!
     );
  
  Port (
     i_signal    :   IN STD_LOGIC_VECTOR(g_signal_length-1 downto 0);        -- Input signal to process.
     i_clk       :   IN STD_LOGIC;                                           -- Input clock signal.
     i_reset     :   IN STD_LOGIC;                                           -- Input reset signal.
     i_signal_rdy:   in std_logic;
     i_average_active: IN STD_LOGIC;                                        -- System is active.
     o_average  :   OUT STD_LOGIC_VECTOR((g_signal_length/2)-1 downto 0);   -- Output average.
     o_avrg_rdy :   OUT STD_LOGIC;                                          -- Reset acknowledge signal.
     o_reset_ack:   OUT STD_LOGIC                                           -- Reset acknowledge signal.
     );
end SIGNAL_AVERAGE;

architecture Behavioral of SIGNAL_AVERAGE is

    -- Two signals to split the input value into two values.
    signal s_signal_MSB :     SIGNED(o_average'length downto 0);
    signal s_signal_LSB :     SIGNED(o_average'length downto 0);
    
    -- Result of the sum.
    signal s_sum          :     STD_LOGIC_VECTOR(8 downto 0);
begin
    
    -- Split the signal into two distinct signals to add together.
    ---------------------------------------------------------------------------------------------------------------
    -- Extend the signals to consider the carry output.
    s_signal_MSB <= resize(signed(i_signal(15 downto 8)), s_signal_MSB'length);
    s_signal_LSB <= resize(signed(i_signal(7 downto 0)), s_signal_LSB'length);
    
    -- Add the two values together
    s_sum <= std_logic_vector(s_signal_MSB + s_signal_LSB);
    ---------------------------------------------------------------------------------------------------------------
    
    
    
    ---------------------------------------------------------------------------------------------------------------
    -- Process of the output resgister with a synchronous reset.
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            -- Register output reset to 0.
            if(i_reset = '1') then
                o_average <= (OTHERS => '0');
                o_avrg_rdy <= '0';
            else
                -- Clock enable condition.
                if(i_average_active = '1') then
                    -- Output the summation without the LSB (numerical equivalent to a division by 2).
                    o_average <= s_sum(o_average'length downto 1);
                end if;
                -- Indicator if the data is ready after rising edge (only of the filter is active and not in reset).
                o_avrg_rdy <= i_signal_rdy and i_average_active;
            end if;
            -- Each riding edge, output reset signal status (simple register with no reset (not required)).
            o_reset_ack <= i_reset;
        end if;
    end process;
    ---------------------------------------------------------------------------------------------------------------
    
end Behavioral;
