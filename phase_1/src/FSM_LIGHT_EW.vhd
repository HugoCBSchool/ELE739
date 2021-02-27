----------------------------------------------------------------------------------
-- Company: ETS.
-- Engineer: Gabriel Gandubert, Hugo Cusson-Bouthillier and 
--           Ernesto Castaldo-Santillan
-- 
-- Create Date: 01/25/2021 08:42:41 AM
-- Design Name: FSM_LIGHT_EW - arch
-- Project Name: ELE739 - Phase 1
-- Target Devices: Basys 3
-- Description: 
--   This finite state machine controls the behaviour of the east and west traffic
--   lights for the project ELE739 - phase 1. The behaviour includes a maintenance
--   mode and a step-by-step mode. A counter is included to keep track of the time
--   spent in a specific state.
-- 
-- Dependencies: 
--   time.vhd
--   DOWN_COUNTER.vhd
-- 
-- Revision:
--   Revision 0.01 - File Created
-- Additional Comments:
--    For each variable name, the following indicators are used:
--        i_<var> : input
--        o_<var> : output
--        c_<var> : constant
--        s_<var> : Local signal
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Set of specific packages to control the parameters of the lights.
library work;
use work.pk_time.all;
use work.pk_time_cst.all;
use work.all;

-- Entit� de la M�F. Comprends un signal de changement des feux et un signal de reset.
entity FSM_LIGHT_EW is
	port (
		i_clk                 : in STD_LOGIC;                       -- input clock.
		i_maintenance_mode    : in STD_LOGIC;                       -- indicator of the maintenance mode if high.
        i_next_light          : in STD_LOGIC;                       -- Permission from the main control to switch from one state to another if high.
        i_step_mode           : in STD_LOGIC;                       -- Persmission to change the state if high.
        o_count_done          : out STD_LOGIC;                      -- Indicator for the main controler when the timer reaches the final value for 
                                                                    -- a specific state or if the step mode is activated.
        o_light               : out STD_LOGIC_VECTOR(2 downto 0)    -- Traffic light status.
	) ;
end entity FSM_LIGHT_EW;

architecture arch of FSM_LIGHT_EW is
    -- Constant output and value for each state. jhonson-based implementation.
    constant c_OFF      : STD_LOGIC_VECTOR(2 downto 0) := "000";
    constant c_GREEN    : STD_LOGIC_VECTOR(2 downto 0) := "100";
    constant c_YELLOW   : STD_LOGIC_VECTOR(2 downto 0) := "010";
    constant c_RED      : STD_LOGIC_VECTOR(2 downto 0) := "001";
    
    -- Local signals.
    signal s_current_state          : STD_LOGIC_VECTOR(2 downto 0):=c_RED;      -- Current state of the FSM.
    signal s_next_state             : STD_LOGIC_VECTOR(2 downto 0);             -- Next state of the FSM.
    signal s_load_value             : t_time_EW;                                -- Time counted by the down_counter. Specific type declared in the parameter package.
    signal s_transfer_load_value    : STD_LOGIC_VECTOR(c_uvec_w_EW-1 downto 0); -- Vector of the time to count for each state.
    signal s_load                   : STD_LOGIC;                                -- Indicates when to load the down_counter.
    signal s_count_done             : STD_LOGIC;                                -- Counter indicator when the counting is done.
    
begin
    
    --  step mode logic to bypass the counter and switch state.
    o_count_done <= s_count_done OR i_step_mode;
    s_load       <= i_next_light OR i_step_mode;
    
    -- Output the light state when the state changes.
    o_light      <= s_current_state;
    
    -- D flip-flop process.
    process (i_clk)
    begin
        if rising_edge(i_clk) then
            if(i_next_light = '1') then
                -- Change the state and the output.
                s_current_state <= s_next_state;
            else
                -- For all other cases, keep the same output.
                s_current_state <= s_current_state;
            end if;
        end if;
    end process;

    -- Behaviour of the state machine and counter value based on the next state.
    FSM_EW_LIGHTS: process(s_current_state, i_maintenance_mode)
        begin
            case s_current_state is
                when c_OFF =>
                    s_next_state <= c_RED;
                    s_load_value <= c_uvec_strobe_EW_tck;
                when c_GREEN =>
                    s_next_state <= c_YELLOW;
                    s_load_value <= c_uvec_Y_EW_tck;
                when c_YELLOW =>
                    s_next_state <= c_RED;
                    s_load_value <= c_uvec_strobe_EW_tck;
                when c_RED =>
                    if(i_maintenance_mode = '1') then
                        s_next_state <= c_OFF;
                        s_load_value <= c_uvec_strobe_EW_tck;
                    else
                        s_next_state <= c_GREEN;
                        s_load_value <= c_uvec_G_EW_tck;
                    end if;
                when others =>
                    s_next_state <= c_RED;
                    s_load_value <= (others => '-');
            end case;
    end process FSM_EW_LIGHTS;
    
    -- Conversion of the specific type to a standard type for the counter.
    s_transfer_load_value <= std_logic_vector(s_load_value(c_uvec_w_EW-1 downto 0));
    
    -- Counter component to control the timing of each state.
    compteur_entity: entity work.DOWN_COUNTER
        generic map(g_unsigned_width => c_uvec_w_EW)
        port map(   i_clk           => i_clk,
                    i_load_value    => s_transfer_load_value,
                    i_load          => s_load,
                    o_done          => s_count_done);
    
end architecture ;