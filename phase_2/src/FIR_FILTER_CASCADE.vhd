----------------------------------------------------------------------------------
-- Company: ETS.
-- Team members :   Gabriel Gandubert, Hugo Cusson-Bouthillier and 
--                  Ernesto Castaldo-Santillan
--
-- Author :         Gabriel Gandubert
-- 
-- Create Date: 02/22/2021
-- Design Name: FIR_FILTER_CASCADE - Behavior
-- Project Name: ELE739 - Phase 2
-- Target Devices: Basys 3
-- Description: 
--!  This component represents the interconnect slices of DSP48E1 used to calculate the
--!  filtered slices between the head and the tail. This component can be grouped with
--!  the HEAD component and the TAIL component to complete the filter.
-- 
--! File dependencies: 
--!   None
-- 
--! Revision:
--!   Revision 0.01 - File Created
--! Additional Comments:
--!    For each variable name, the following indicators are used:
--!        g_<var> : generic
--!        i_<var> : input
--!        o_<var> : output
--!        w_<var> : internal wire
--!        r_<var> : register
--!        c_<var> : constant
--!        s_<var> : local signal
----------------------------------------------------------------------------------

--   DSP48E1   : In order to incorporate this function into the design,
--    VHDL     : the following instance declaration needs to be placed
--  instance   : in the body of the design code.  The instance name
-- declaration : (DSP48E1_inst) and/or the port declarations after the
--    code     : "=>" declaration maybe changed to properly reference and
--             : connect this function to the design.  All inputs and outputs
--             : must be connected.

--   Library   : In addition to adding the instance declaration, a use
-- declaration : statement for the UNISIM.vcomponents library needs to be
--     for     : added before the entity declaration.  This library
--   Xilinx    : contains the component declarations for all Xilinx
-- primitives  : primitives and points to the models that will be used
--             : for simulation.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity FIR_FILTER_CASCADE is
    generic(
        constant g_B_input_width:natural:= 6
    );
    Port (
        i_ACIN :            IN STD_LOGIC_VECTOR(29 downto 0);
        i_PCIN :            IN STD_LOGIC_VECTOR(47 downto 0);
        i_coefficient :     IN STD_LOGIC_VECTOR(g_B_input_width-1 downto 0);
        i_clk:              IN STD_LOGIC;
        i_reset  :          IN STD_LOGIC;
        i_active_filter :   IN STD_LOGIC;
        o_ACOUT :           OUT STD_LOGIC_VECTOR(29 downto 0);
        o_PCOUT :           OUT STD_LOGIC_VECTOR(47 downto 0)
     );
end FIR_FILTER_CASCADE;

architecture Behavioral of FIR_FILTER_CASCADE is
    constant width_B: natural := 18;
    constant ALUMODE: STD_LOGIC_VECTOR (3 downto 0):= "0000";
    constant CARRYINSEL: STD_LOGIC_VECTOR (2 downto 0):= "000";
    constant INMODE: STD_LOGIC_VECTOR (4 downto 0):= "00001";
    constant OPMODE: STD_LOGIC_VECTOR (6 downto 0):= "0010101";
    signal B: STD_LOGIC_VECTOR (width_B-1 downto 0);
begin

    --------------------------------------------------------------
    -- Vector size ajustment for the input of DSP48E1 component.--
    --------------------------------------------------------------

    -- FIR coefficient.
    B <= std_logic_vector(resize(signed(i_coefficient), width_B));
    
    --------------------------------------------------------------
    -- DSP48E1: 48-bit Multi-Functional Arithmetic Block
    --          Artix-7
    -- Xilinx HDL Language Template, version 2018.3
    --------------------------------------------------------------
 
    DSP48E1_inst : DSP48E1
    generic map (
       -- Feature Control Attributes: Data Path Selection
       A_INPUT => "CASCADE",               -- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
       B_INPUT => "DIRECT",               -- Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
       USE_DPORT => FALSE,                -- Select D port usage (TRUE or FALSE)
       USE_MULT => "MULTIPLY",            -- Select multiplier usage ("MULTIPLY", "DYNAMIC", or "NONE")
       USE_SIMD => "ONE48",               -- SIMD selection ("ONE48", "TWO24", "FOUR12")
       -- Pattern Detector Attributes: Pattern Detection Configuration
       AUTORESET_PATDET => "NO_RESET",    -- "NO_RESET", "RESET_MATCH", "RESET_NOT_MATCH" 
       MASK => X"3fffffffffff",           -- 48-bit mask value for pattern detect (1=ignore)
       PATTERN => X"000000000000",        -- 48-bit pattern match for pattern detect
       SEL_MASK => "MASK",                -- "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2" 
       SEL_PATTERN => "PATTERN",          -- Select pattern value ("PATTERN" or "C")
       USE_PATTERN_DETECT => "NO_PATDET", -- Enable pattern detect ("PATDET" or "NO_PATDET")
       -- Register Control Attributes: Pipeline Register Configuration
       ACASCREG => 2,                     -- Number of pipeline stages between A/ACIN and ACOUT (0, 1 or 2)
       ADREG => 0,                        -- Number of pipeline stages for pre-adder (0 or 1)
       ALUMODEREG => 1,                   -- Number of pipeline stages for ALUMODE (0 or 1)
       AREG => 2,                         -- Number of pipeline stages for A (0, 1 or 2)
       BCASCREG => 0,                     -- Number of pipeline stages between B/BCIN and BCOUT (0, 1 or 2)
       BREG => 0,                         -- Number of pipeline stages for B (0, 1 or 2)
       CARRYINREG => 1,                   -- Number of pipeline stages for CARRYIN (0 or 1)
       CARRYINSELREG => 1,                -- Number of pipeline stages for CARRYINSEL (0 or 1)
       CREG => 1,                         -- Number of pipeline stages for C (0 or 1)
       DREG => 1,                         -- Number of pipeline stages for D (0 or 1)
       INMODEREG => 0,                    -- Number of pipeline stages for INMODE (0 or 1)
       MREG => 1,                         -- Number of multiplier pipeline stages (0 or 1)
       OPMODEREG => 1,                    -- Number of pipeline stages for OPMODE (0 or 1)
       PREG => 1                          -- Number of pipeline stages for P (0 or 1)
    )
    port map (
       -- Cascade: 30-bit (each) output: Cascade Ports
       ACOUT => o_ACOUT,         -- 30-bit output: A port cascade output
       PCOUT => o_PCOUT,                   -- 48-bit output: Cascade output
       -- Cascade: 30-bit (each) input: Cascade Ports
       ACIN => i_ACIN,          -- 30-bit input: A cascade data input
       BCIN => (others => '0'),          -- 18-bit input: B cascade input
       CARRYCASCIN => '0',               -- 1-bit input: Cascade carry input
       MULTSIGNIN => '0',                -- 1-bit input: Multiplier sign input
       PCIN => i_PCIN,                   -- 48-bit input: P cascade input
       -- Control: 4-bit (each) input: Control Inputs/Status Bits
       ALUMODE => ALUMODE,               -- 4-bit input: ALU control input
       CARRYINSEL => CARRYINSEL,         -- 3-bit input: Carry select input
       CLK => i_clk,                     -- 1-bit input: Clock input
       INMODE => INMODE,                 -- 5-bit input: INMODE control input
       OPMODE => OPMODE,                 -- 7-bit input: Operation mode input
       -- Data: 30-bit (each) input: Data Ports
       A => (others => '0'),                           -- 30-bit input: A data input
       B => B,                           -- 18-bit input: B data input
       C => (others => '0'),                           -- 48-bit input: C data input
       CARRYIN => '0',               -- 1-bit input: Carry input signal
       D => (others => '0'),                           -- 25-bit input: D data input
       -- Reset/Clock Enable: 1-bit (each) input: Reset/Clock Enable Inputs
       CEA1 => i_active_filter,          -- 1-bit input: Clock enable input for 1st stage AREG
       CEA2 => i_active_filter,          -- 1-bit input: Clock enable input for 2nd stage AREG
       CEAD => i_active_filter,          -- 1-bit input: Clock enable input for ADREG
       CEALUMODE => i_active_filter,     -- 1-bit input: Clock enable input for ALUMODE
       CEB1 => i_active_filter,          -- 1-bit input: Clock enable input for 1st stage BREG
       CEB2 => i_active_filter,          -- 1-bit input: Clock enable input for 2nd stage BREG
       CEC => i_active_filter,           -- 1-bit input: Clock enable input for CREG
       CECARRYIN => i_active_filter,     -- 1-bit input: Clock enable input for CARRYINREG
       CECTRL => i_active_filter,        -- 1-bit input: Clock enable input for OPMODEREG and CARRYINSELREG
       CED => i_active_filter,           -- 1-bit input: Clock enable input for DREG
       CEINMODE => i_active_filter,      -- 1-bit input: Clock enable input for INMODEREG
       CEM => i_active_filter,           -- 1-bit input: Clock enable input for MREG
       CEP => i_active_filter,           -- 1-bit input: Clock enable input for PREG
       RSTA => i_reset,                  -- 1-bit input: Reset input for AREG
       RSTALLCARRYIN => i_reset,         -- 1-bit input: Reset input for CARRYINREG
       RSTALUMODE => i_reset,            -- 1-bit input: Reset input for ALUMODEREG
       RSTB => i_reset,                  -- 1-bit input: Reset input for BREG
       RSTC => i_reset,                  -- 1-bit input: Reset input for CREG
       RSTCTRL => i_reset,               -- 1-bit input: Reset input for OPMODEREG and CARRYINSELREG
       RSTD => i_reset,                  -- 1-bit input: Reset input for DREG and ADREG
       RSTINMODE => i_reset,             -- 1-bit input: Reset input for INMODEREG
       RSTM => i_reset,                  -- 1-bit input: Reset input for MREG
       RSTP => i_reset                   -- 1-bit input: Reset input for PREG
       
       
       -- In this slice, we won't use any of the following control bits or output port.
       -- Control: 1-bit (each) output: Control Inputs/Status Bits
       -- OVERFLOW => OVERFLOW,             -- 1-bit output: Overflow in add/acc output
       -- PATTERNBDETECT => PATTERNBDETECT, -- 1-bit output: Pattern bar detect output
       -- PATTERNDETECT => PATTERNDETECT,   -- 1-bit output: Pattern detect output
       -- UNDERFLOW => UNDERFLOW,           -- 1-bit output: Underflow in add/acc output
       -- Data: 4-bit (each) output: Data Ports
       -- CARRYOUT => CARRYOUT,             -- 4-bit output: Carry output
       -- P => P,                           -- 48-bit output: Primary data output
       
       -- Unused cascade ports
       -- BCOUT => BCOUT,                   -- 18-bit output: B port cascade output
       -- CARRYCASCOUT => CARRYCASCOUT,     -- 1-bit output: Cascade carry output
       -- MULTSIGNOUT => MULTSIGNOUT,       -- 1-bit output: Multiplier sign cascade output
    );

    -- End of DSP48E1_inst instantiation
    
end Behavioral;
