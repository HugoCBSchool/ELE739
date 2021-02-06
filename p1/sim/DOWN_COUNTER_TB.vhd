----------------------------------------------------------------------------------
-- Titre            : Banc d'essai ocmpteur a decrementation.
-- Projet           : ELE739 Phase 1
----------------------------------------------------------------------------------
-- Fichier          : DOWN_COUNTER_TB.vhd
-- Auteur           : Gabriel Gandubert
-- Creation         : 2020-01-19

----------------------------------------------------------------------------------
-- Copyright (c) 2020 Gabriel Gandubert
--  
-- Description: Banc d'essai ocmpteur a decrementation.
-- Cette simulation permet de valider le temps de reponse du compteur a 
-- decrementation. Les temps de simulations sont definis dans le fichier
-- TIME,vhd contenant le package pk_time et pk_time_simulation.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Set of specific packages to control the parameters of the lights.
library work;
use work.pk_time.all;
use work.pk_time_simulation.all;
use work.all;


entity DOWN_COUNTER_TB is
end DOWN_COUNTER_TB;

architecture Behavioral of DOWN_COUNTER_TB is
    
    signal s_clk                    : STD_LOGIC:='0';                               -- * Clock signal
    signal s_load_value             : t_time_sim := c_uvec_three_sim_tck;           -- * Time counted by the down_counter. Specific type declared in the parameter package.
    signal s_transfer_load_value    : STD_LOGIC_VECTOR(c_uvec_w_sim-1 downto 0);    -- * Vector of the time to count for each state.
    signal s_load                   : STD_LOGIC := '1';                             -- * Indicates when to load the down_counter.
    signal s_count_done             : STD_LOGIC := '1';                             -- * Indicator for the main controler when the timer reaches the final value for 
                                                                                    --   a specific state or if the step mode is activated.
begin
    
    ----------------------------------------------------------------------------------
    -- simulation de l'horloge
    ----------------------------------------------------------------------------------
    
    -- simulation d'une horloge 100MHz avec un taux de charge de 50%
    clk_gen : process
    begin
        s_clk <= '0';
        wait for 5 ns;
        s_clk <= '1';
        wait for 5 ns;
    end process clk_gen;
    
    ----------------------------------------------------------------------------------
    -- simulation des stimulis
    ----------------------------------------------------------------------------------
    -- Changement du compteur selon
    main : process(s_count_done)
    begin
        if rising_edge(s_count_done) then
            case s_load_value is
                when c_uvec_one_sim_tck =>
                    s_load_value <= c_uvec_two_sim_tck;
                when c_uvec_two_sim_tck =>
                    s_load_value <= c_uvec_three_sim_tck;
                when c_uvec_three_sim_tck =>
                    s_load_value <= c_uvec_one_sim_tck;
                when others =>
                    s_load_value <= c_uvec_one_sim_tck;
            end case;
        end if;
        
--        if(s_load_value = c_uvec_one_sim_tck) then
--            s_load_value <= c_uvec_two_sim_tck;
--        elsif(s_load_value = c_uvec_two_sim_tck) then
--            s_load_value <= c_uvec_three_sim_tck;
--        elsif(s_load_value = c_uvec_three_sim_tck) then
--            s_load_value <= c_uvec_one_sim_tck;
--        else
--            s_load_value <= c_uvec_one_sim_tck;
--        end if;
        
    end process;
    
    
    process
    begin
        s_load <= '1';
        wait for 10 ns;
        s_load <= '0';
        wait for 1050 ns;
    end process;
    
    -- Conversion of the specific type to a standard type for the counter.
    s_transfer_load_value <= std_logic_vector(s_load_value(c_uvec_w_sim-1 downto 0));
    
    ----------------------------------------------------------------------------------
    -- configuration des modules à tester
    ----------------------------------------------------------------------------------
    
    DUT: entity work.DOWN_COUNTER
        generic map(g_unsigned_width => c_uvec_w_sim)
        port map(   i_clk           => s_clk,
                    i_load_value    => s_transfer_load_value,
                    i_load          => s_load,
                    o_done          => s_count_done);
end Behavioral;
