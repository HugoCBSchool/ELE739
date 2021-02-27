----------------------------------------------------------------------------------
-- Titre            : Banc d'essai du filtre FIR direct.
-- Projet           : ELE739 Phase 2
----------------------------------------------------------------------------------
-- Fichier          : FIR_FILTER_TB.vhd
-- Auteur           : Gabriel Gandubert
-- Creation         : 2020-02-22

----------------------------------------------------------------------------------
-- Copyright (c) 2020 Gabriel Gandubert
--  
-- Description: Banc d'essai pour le filtre FIR de la phase 2 du projet dans
--              le cadre du cours ELE739. Le but est de valider la
--              synchronisation des signaux et la vitesse de traitement des
--              données
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Empty entity for every testbench
entity FIR_FILTER_TB is
end FIR_FILTER_TB;

architecture Behavioral of FIR_FILTER_TB is
    
    -- Inputs of the FIR_FILTER.
    signal s_clk            :            STD_LOGIC:='0';       -- * Clock signal
    signal s_signal         :            STD_LOGIC_VECTOR(7 downto 0):= (others => '0');
    signal s_reset          :            STD_LOGIC:='0';       -- * Reset signal
    signal s_filtre_actif   :            STD_LOGIC:='0';
    signal s_signal_rdy     :            std_logic:='0';
    -- Output of the FIR_FILTER.
    signal s_o_filter       :            STD_LOGIC_VECTOR(15 downto 0);
    signal s_reset_ack      :            STD_LOGIC;
    signal s_filter_rdy     :            STD_LOGIC;
    
begin

    ----------------------------------------------------------------------------------
    -- Clock simulation
    ----------------------------------------------------------------------------------
    
    -- Simulation of a 100MHz clock signal with a duty cycle of 50%.
    clk_gen : process
    begin
        s_clk <= '0';
        wait for 5 ns;
        s_clk <= '1';
        wait for 5 ns;
    end process clk_gen;
    
    ----------------------------------------------------------------------------------
    -- Stimulus simuation
    ----------------------------------------------------------------------------------
    
    -- Signal input process.
    process
    begin
        s_signal_rdy<='1';
        s_signal <= "00000111"; -- 0.0546875
        wait for 20 ns;
        s_signal <= "10000110"; -- -0.953125
        wait for 10 ns;
        s_signal <= "00011000"; -- 0.1875
        wait for 10 ns;
        s_signal <= "10000000"; -- -1
        wait for 110 ns;
        s_signal <= "00000000"; -- 0
        wait;
    end process;
    
    -- Filter activation process.
    process
    begin
        wait for 10 ns;
        s_filtre_actif <= '1';
        wait for 160 ns;
        s_filtre_actif <= '0';
        wait for 20 ns;
        s_filtre_actif <= '1';
        wait;
    end process;
    
    -- Reset signal process.
    process
    begin
        -- Initial system reset.
        s_reset <= '1';
        wait for 10 ns;
        s_reset <= '0';
        
        -- Reset test after 130 ns.
        wait for 120 ns;
        s_reset <= '1';
        wait for 10 ns;
        s_reset <= '0';
        wait;
    end process;
    
    ----------------------------------------------------------------------------------
    -- Instanciation of the component under test.
    ----------------------------------------------------------------------------------
    
    -- Filter to validate.
    DUT_FILTRE: entity work.FIR_FILTER
        port map(   i_signal            => s_signal,
                    i_reset             => s_reset,
                    i_signal_rdy        => s_filter_rdy,
                    i_active_filter     => s_filtre_actif,
                    i_clk               => s_clk,
                    o_filter            => s_o_filter,
                    o_reset_ack         => s_reset_ack,
                    o_filter_rdy        => s_filter_rdy);

end Behavioral;
