----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2021 03:07:13 PM
-- Design Name: 
-- Module Name: FSM_PED - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_unsigned.all;

library work;
use work.pk_time.all;
use work.pk_time_cst.all;
use work.pk_fsm_control.all;

entity FSM_PED is

    port (
        i_clk        : in  STD_LOGIC;     --! clock
        i_ctrl_slv   : in  tslv_fsm_ctrl; --! bus de signaux de controle venant du controleur
        o_state      : out STD_LOGIC_VECTOR(2 downto 0);
        o_light      : out STD_LOGIC; --- Output of ON or OFF indicating state
        o_count_done : out STD_LOGIC
    ) ;
end FSM_PED;


architecture Behaviorial of FSM_PED is


    constant c_S_STOP   : std_logic_vector(2 downto 0) := "001"; --! stop register value
    constant c_S_GO     : std_logic_vector(2 downto 0) := "010"; --! go state register value
    constant c_S_STROBE : std_logic_vector(2 downto 0) := "100"; --! strobe state register value

    signal w_next_state : std_logic_vector(2 downto 0);             --! comb logic to discriminate the state register next load value
    signal r_state      : std_logic_vector(2 downto 0) := c_S_STOP; --! initialized as STOP, indicates the current state in the register

    signal w_ctrl : trec_fsm_ctrl; --! interface with the controler

    signal w_load_value     : t_time_PED;                                 --! timer load-value-mux output
    signal w_load,w_load_strobe : std_logic;                                  --! mux output towards i_load input port of the timer
    signal w_slv_load_value : std_logic_vector(c_uvec_w_PED -1 downto 0); --! typecasting shananigan receptacle
    signal w_slv_load_value_strobe:std_logic_vector(c_uvec_w_strobe-1 downto 0);
    signal w_count_done,w_count_done_strobe : std_logic;  --! internal logic signal
    signal w_strobe_done : std_logic ; --! internal logic signal raised at 1 when the strobe has done its routine
    
    signal r_strobe     : unsigned(c_uv_w_count_ped downto 0):= to_unsigned(c_nb_strobe_toggle_ped,c_uv_w_count_ped+1);
  

begin
    -- interface routing
    w_ctrl           <= slv2fsm_ctrl(i_ctrl_slv);

    --------------------------------------------------------------------------------
    --! state machine
    --------------------------------------------------------------------------------
    with r_state select w_next_state<=
        c_S_STOP        when c_S_STROBE,
        c_S_STROBE      when c_S_GO,
        c_S_GO          when c_S_STOP,
        (others=>'-')   when others;
    
    fsm:process(i_clk)
    begin
        if rising_edge(i_clk) then
            if w_ctrl.nxt='1'
                then r_state<=w_next_state;
                else r_state<=r_state;
            end if;
        end if;
    end process fsm;
    
    o_light<=   not r_strobe(0) when r_state=c_S_STROBE else
                '0'             when r_state=c_S_STOP   else
                '1'             when r_state=c_S_GO     else '0';
    o_state<=r_state;
    o_count_done<='1' when w_ctrl.step='1' else w_strobe_done when r_state=c_S_STROBE else w_count_done;

    ----------------------------------------------------------------------------------
    --! DOWNCOUNTER
    --------------------------------------------------------------------------------
    U_Timer1 : entity work.DOWN_COUNTER
        generic map( g_unsigned_width => c_uvec_w_PED )
        port map(
            i_clk        => i_clk,
            i_load_value => w_slv_load_value,
            i_load       => w_load,
            o_done       => w_count_done
        );
    --------------------------------------------------------------------------------
    with w_next_state select w_load_value<=
        c_uvec_strobe_ped_tck   when c_S_STOP,
        c_uvec_strobe_ped_tck   when c_S_STROBE,
        c_uvec_go_ped_tck       when c_S_GO,
        (others=>'-')           when others;
    w_slv_load_value <= std_logic_vector(w_load_value(c_uvec_w_PED-1 downto 0));
    w_load<='0' when r_state=c_S_STROBE else w_ctrl.nxt;
    --------------------------------------------------------------------------------




    --------------------------------------------------------------------------------
    --! STROBE
    --------------------------------------------------------------------------------
    U_Timer2 : entity work.DOWN_COUNTER
        generic map( g_unsigned_width => c_uvec_w_strobe )
        port map(
            i_clk        => i_clk,
            i_load_value => w_slv_load_value_strobe,
            i_load       => w_load_strobe,
            o_done       => w_count_done_strobe
        );
    --------------------------------------------------------------------------------
    w_load_strobe<= '1' when ( w_count_done_strobe='1' and r_state=c_S_STROBE)  else 
                    '1' when not (r_state=c_S_STROBE) else
                    '0';
    w_slv_load_value_strobe <= std_logic_vector(c_uvec_strobe_ped_tck(c_uvec_w_strobe-1 downto 0));
    w_strobe_done<=r_strobe(c_uv_w_count_ped);
    ---------------------------------------------------------------------------------
    count_strobe : process(i_clk)
    begin
        if rising_edge(i_clk) then
            if r_state=c_S_STROBE then              -- si on est en mode strobe
                if w_count_done_strobe='1' then     -- si le compteur a fini
                    if w_ctrl.step='0' then         -- si on est pas en mode perpetuel

        if r_strobe(c_uv_w_count_ped)='0' then   
            r_strobe<=r_strobe-1;
        else
            r_strobe<=r_strobe;
        end if;

                    else
                        r_strobe<=r_strobe-1;
                    end if;
                else
                    r_strobe<=r_strobe;
                end if;
            else
                r_strobe<=to_unsigned(c_nb_strobe_toggle_ped,c_uv_w_count_ped+1);
            end if;
        else
            r_strobe<=r_strobe;
        end if;
    end process count_strobe;
    
    
end Behaviorial;

   