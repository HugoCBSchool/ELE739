----------------------------------------------------------------------------------
-- Titre            : Banc d'essai Feux de circulation 
-- Projet           : ELE739 Phase 1
----------------------------------------------------------------------------------
-- Fichier          : FSM_Lights_tb.vhd
-- Auteur           : Gabriel Gandubert
-- Creation         : 2020-01-19

----------------------------------------------------------------------------------
-- Copyright (c) 2020 Gabriel Gandubert
--  
-- Description: Banc d'essai pour les feux de circulation.
-- Cette simulation compare le comportement des deux MEF en fonction des entrees.
-- L'objectif est de verifier le comportement de la MEF en fonction de signaux
-- d'entree multiple ou simple a des moments specifiques.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Pour les types std_logic et std_logic_vector.
use IEEE.numeric_std.ALL;    -- Pour les types signed et unsigned.


-- l'entite d'un banc d'essai est toujours vide.
entity FSM_Lights_tb is
end FSM_Lights_tb;

architecture testbench of FSM_Lights_tb is
    
    -- Definition des ports du module teste en signaux
    signal s_clk                : STD_LOGIC;                    -- Signal d'horloge du testbench.
    signal s_maintenance_mode   : STD_LOGIC:= '0';              -- Signal de maintenance du système.
    signal s_next_light_EW      : STD_LOGIC:= '1';              -- Signal de changement d'état de la MEF des feux seconaire.
    signal s_next_light_NS      : STD_LOGIC:= '1';              -- Signal de changement d'état de la MEF des feux primaire.
    signal s_step_mode          : STD_LOGIC:= '0';              -- Mode pas à pas deux MEF.
    signal s_count_done_EW      : STD_LOGIC;                    -- Signal de fin du compteur de la MEF des feux secondaire
    signal s_count_done_NS      : STD_LOGIC;                    -- Signal de fin du compteur de la MEF des feux primaire
    signal s_active_light_EW    : STD_LOGIC_VECTOR(2 downto 0); -- Signal des feux actifs de la MEF des feux secondaire
    signal s_active_light_NS    : STD_LOGIC_VECTOR(2 downto 0); -- Signal des feux actifs de la MEF des feux primaire

begin
    ----------------------------------------------------------------------------------
    -- configuration des modules à tester
    ----------------------------------------------------------------------------------
    
    -- MEF seconaire.
    FSM_EW : entity work.FSM_LIGHT_EW
        port map (
            i_clk                 => s_clk,
		    i_maintenance_mode    => s_maintenance_mode,
            i_next_light          => s_next_light_EW,
            i_step_mode           => s_step_mode,
            o_count_done          => s_count_done_EW,
            o_light               => s_active_light_EW);
    
    -- MEF principale.
    FSM_NS : entity work.FSM_LIGHT_NS
        port map (
            i_clk                 => s_clk,
		    i_maint_mode          => s_maintenance_mode,
            i_next                => s_next_light_NS,
            i_step_mode           => s_step_mode,
            o_count_done          => s_count_done_NS,
            o_light               => s_active_light_NS);
    
    ----------------------------------------------------------------------------------
    -- Simulation de l'horloge et du mode maintenance.
    ----------------------------------------------------------------------------------
    
    -- Simulation d'une horloge 200MHz avec un taux de charge de 50%
    clk_gen : process
    begin
        s_clk <= '0';
        wait for 2.5 ns;
        s_clk <= '1';
        wait for 2.5 ns;
    end process clk_gen;
    
    -- Simulation d'un signal de maintenance activé à des moments précis de la simulation.
    maintenance_gen : process
    begin
        s_maintenance_mode <= '1', '0' after 90 ns;
        wait for 150 ns;
        s_maintenance_mode <= '1';
        wait for 100 ns;
         s_maintenance_mode <= '0';
         wait for 90 ns;
        s_maintenance_mode <= '1';
        wait for 20 ns;
         s_maintenance_mode <= '0';
         wait;
        
    end process maintenance_gen;
    
    ----------------------------------------------------------------------------------
    -- simulation des stimulis
    ----------------------------------------------------------------------------------
    
    -- Processus de simulation d'un signal pas a pas.
    Step : process
    begin
        s_step_mode <= '0';
        wait for 300 ns;
        s_step_mode <= '1';
        wait for 50 ns;
        s_step_mode <= '0';
        wait;
    end process Step;
    
    -- Au moment que le compteur fini son decompte, activer le prochain etat pour les deux feux.
    s_next_light_EW <= s_count_done_EW;
    s_next_light_NS <= s_count_done_NS;
    
    ----------------------------------------------------------------------------------
    -- Procedure de validation simple.
    ----------------------------------------------------------------------------------
    process(s_active_light_NS,s_active_light_EW)
    begin
        assert s_active_light_NS = s_active_light_EW report "Error : Not same output for both lights" severity error;
    end process;
    
    
end testbench;