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
    signal i_clk                : STD_LOGIC;                    -- Signal d'horloge du testbench.
    signal i_maint   : STD_LOGIC:= '0';              -- Signal de maintenance du système.
    signal i_next      : STD_LOGIC:= '1';              -- Signal de changement d'état de la MEF des feux seconaire.
    signal i_step          : STD_LOGIC:= '0';              -- Mode pas à pas deux MEF.
    signal o_done      : STD_LOGIC;                    -- Signal de fin du compteur de la MEF des feux secondaire
    signal o_active_light    : STD_LOGIC_VECTOR(2 downto 0); -- Signal des feux actifs de la MEF des feux secondaire
    
    constant c_clk_period:real:=10.0e-9;
    constant g_clk_freq_mhz : real := (10.0e-6)/c_clk_period;
    constant g_time_G_NS_s:real:=100.0*c_clk_period;
    constant g_time_Y_NS_s:real:=80.0*c_clk_period;
    constant g_time_R_strobe_s:real:=10.0*c_clk_period;
    constant g_light:real:=g_time_Y_NS_s+g_time_G_NS_s+g_time_R_strobe_s;

begin
    ----------------------------------------------------------------------------------
    -- configuration des modules à tester
    ----------------------------------------------------------------------------------
	FSM_LIGHT_EW : entity work.FSM_LIGHT_NS
		generic map (
				g_clk_freq_mhz    => g_clk_freq_mhz,
				g_time_G_NS_s     => g_time_G_NS_s,
				g_time_Y_NS_s     => g_time_Y_NS_s,
				g_time_R_strobe_s => g_time_R_strobe_s
			)
        port map (
            i_clk                 => i_clk,
		    i_maint_mode    => i_maint,
            i_next         => i_next,
            i_step_mode           => i_step,
            o_count_done          => o_done,
            o_light               => o_active_light
           	);
    ----------------------------------------------------------------------------------
    -- Simulation de l'horloge et du mode maintenance.
    ----------------------------------------------------------------------------------
    
    -- Simulation d'une horloge 200MHz avec un taux de charge de 50%
    clk_gen : process
    begin
        i_clk <= '0';
        wait for c_clk_period/2.0*(1 sec);
        i_clk <= '1';
        wait for c_clk_period/2.0*(1 sec);
    end process clk_gen;
       
    -- Au moment que le compteur fini son decompte, activer le prochain etat pour les deux feux.
    process
    begin
        if i_step='0' then
            i_next<='0';
            wait until rising_edge(o_done);
            wait until rising_edge(i_clk);
            wait until rising_edge(i_clk);
            wait until rising_edge(i_clk);wait for c_clk_period/10.0*(1 sec);
            i_next<='1';
            wait until rising_edge(i_clk);wait for c_clk_period/10.0*(1 sec);
        else
            i_next<='0';
            wait until rising_edge(i_clk);
            wait for c_clk_period/10.0*(1 sec);
            i_next<='1';
            wait until rising_edge(i_clk);
            wait for c_clk_period/10.0*(1 sec);
         end if;
    end process;
    p2:process
    begin
        i_maint<='1';
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(i_clk);
        wait until rising_edge(i_clk);wait for c_clk_period/10.0*(1 sec);
        
        i_maint<='0';
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(i_clk);wait for c_clk_period/10.0*(1 sec);
        
        
        i_maint<='1';
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(i_clk);
        wait until rising_edge(i_clk);wait for c_clk_period/10.0*(1 sec);
        
        i_maint<='0';
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(o_done);
        wait until rising_edge(i_clk);wait for c_clk_period/10.0*(1 sec);
        
        i_step<='1';
        i_maint<='1';
        wait for 20.0*c_clk_period*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period/10.0*(1 sec);
        i_maint<='0';
        wait for 20.0*c_clk_period*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period/10.0*(1 sec);
        i_step<='0';
        wait for 20.0*c_clk_period*(1 sec);
        wait until rising_edge(i_clk);
        wait for c_clk_period/10.0*(1 sec);
        
        
    end process;
    
    
end testbench;