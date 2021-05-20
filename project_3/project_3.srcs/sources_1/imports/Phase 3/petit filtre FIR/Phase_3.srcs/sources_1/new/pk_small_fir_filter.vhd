----------------------------------------------------------------------------------
-- Company: ETS.
-- Team members :   Gabriel Gandubert, Hugo Cusson-Bouthillier and 
--                  Ernesto Castaldo-Santillan
--
-- Author :         Gabriel Gandubert
-- 
-- Create Date: 03/18/2021
-- Design Name: pk_small_fir_filter - Behavior
-- Project Name: ELE739 - Phase 3
-- Target Devices: Basys 3
-- Description: 
--  This package is used by the small FIR filter for specific type calls and
--  coefficient constants.
-- 
-- File dependencies: 
--   None.
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
use IEEE.MATH_REAL.all;


-- =====================================================================================
--      package containing types and constants for the module small_fir_filter
-- -------------------------------------------------------------------------------------
package pk_small_fir_filter is

    TYPE STATE_TYPE IS (coef_0, coef_1, coef_2, coef_3, 
                        coef_4, coef_5, coef_6, coef_7);
    constant g_coef_size:       natural :=  6;
    constant g_nb_filter_stage: integer :=  8;
    constant g_i_vec_size:      natural :=  8;
    TYPE t_signal_reg is array(g_nb_filter_stage-1 downto 0) of std_logic_vector(g_i_vec_size-1 downto 0);
    TYPE t_rom_sample is array(g_nb_filter_stage-1 downto 0) of std_logic_vector(g_coef_size-1 downto 0);
    constant coef : t_rom_sample := (
        0 => "000001",
        1 => "000010",
        2 => "000100",
        3 => "001000",
        4 => "010000",
        5 => "111111",
        6 => "111110",
        7 => "111100"
    );
    
end package pk_small_fir_filter;


