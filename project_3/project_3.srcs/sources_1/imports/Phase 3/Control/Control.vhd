--------------------------------------------------------------------------------
-- Title       : CONTROLER MODULE
-- Project     : ELE739 - PHASE 2
--------------------------------------------------------------------------------
-- File        : CONTROLER.vhd
-- Author      : Ernesto Castaldo-S.
-- Created     : Wed Feb 24 19:08:06 2021
-- Last update : Sun Mar 14 13:51:05 2021
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2021 Ernesto Castaldo-S.
-------------------------------------------------------------------------------
-- Description: This module is responsible for controling the mode of operation
-- of the signal generator, output bus and filter module based on the externally
-- synchronized values of the input user interface
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library work;
--use work.pk_time.all;

entity Control is
    generic(
        constant g_debouncer_shreg_width:positive:=32
    );
	port(
		i_clk			:	in	std_logic;	--! clock
		
		------------------------------------------------------------------------------------------------
		i_ack_gen		:	in	std_logic;	--! acknowledge from generator following reset request
		i_ack_fil		:	in	std_logic;  --! acknowledge from filter    following reset request
		--------------------------------------------------------------------------------------------
		
		
		i_reset_g		:	in	std_logic;	--! the input values of the RESET_G buttons	
		i_restart		:	in	std_logic;	--! the input values of the RESTART buttons
		i_next			:	in	std_logic;  --! the input values of the NEXT buttons
		
		i_bus_g		    :   in std_logic_vector(15 downto 0); --! input bus generator
		i_bus_f		    :   in std_logic_vector(15 downto 0); --! input bus filter
		i_bus_s		    :   in std_logic_vector(15 downto 0); --! input bus filter
		-------------------------------------------------------------------------------------------------
		o_signal_active :   out std_logic_vector(2 downto 0);
		--in next order --
--2--	o_gen_act		:	out std_logic;	--! control bit towards signal generator
--1--	o_fil_act	    :	out std_logic;	--! control bit towards signal filter
--0--	o_sml_act	    :	out std_logic;	--! control bit towards signal small filter
		----------------------------------------------------------------------------------------------
		o_reset	  		:	out std_logic;	--! reset bit towards signal generator and filter
		
		o_idle_led    :	out std_logic; --! led output for idle mode 
		o_gen_led		:	out std_logic;  --! led output for generator mode output
		o_fil_led	    :	out std_logic;  --! led output for filter mode output interface
		o_small_led	    :	out std_logic;  --! led output for small mode output interface
	 --   o_idle_led	    :	out std_logic;   
	
		o_bus		    :   out std_logic_vector(15 downto 0) --! output bus

	
		
		
		
	);
end Control;
		
architecture arch of Control is
    constant nreg:positive:=2*g_debouncer_shreg_width;
    subtype t_sreg is std_logic_vector(nreg-1 downto 0);
    constant c_high:std_logic_vector(g_debouncer_shreg_width-1 downto 0):=(others=>'1');
    constant c_low:std_logic_vector(g_debouncer_shreg_width-1 downto 0):=(others=>'0');
	constant c_fedge:t_sreg:=c_high&c_low;
	
	constant idle   		: std_logic_vector(1 downto 0) := "00"; --! idle register value
    constant sig_gen    	: std_logic_vector(1 downto 0) := "01"; --! signal generator state register value
    constant filter 		: std_logic_vector(1 downto 0) := "10"; --! filter state register value
	constant small 		    : std_logic_vector(1 downto 0) := "11";
	 
	signal	cstate			: std_logic_vector(1 downto 0) := idle; --! current state register initialized as idle mode
	signal  nstate			: std_logic_vector(1 downto 0) ; 		--! next state register initialized as idle mode
	
														--! interface for input bus
	signal s_reset 			 : std_logic:='0';														--! interface for input reset signals
   
--2--	o_gen_act		:	out std_logic;	--! control bit towards signal generator
--1--	o_fil_act	    :	out std_logic;	--! control bit towards signal filter
--0--	o_sml_act	    :	out std_logic;	--! control bit towards signal small filter
-------- debounce buffer---------------------------------------------------
	signal reset_buff  	  : t_sreg:= (others => '0');
	signal restart_buff   : t_sreg:= (others => '0');
	signal next_buff      : t_sreg:= (others => '0');
	
	signal s_gen_act 			 : std_logic:='0';
    signal s_fil_act 			 : std_logic:='0';
    signal s_sml_act			 : std_logic:='0';
    
	signal s_bus		    :    std_logic_vector(15 downto 0):= (others => '0'); --! output bus
	signal s_mode		    :    std_logic_vector(1 downto 0):= (others => '0'); --! output mode
	
	signal r_reset_ack	:std_logic:='0';
	signal w_next,w_reset_g,w_restart:std_logic;
	
begin
    w_next<='1' when next_buff=c_fedge else '0';
    w_reset_g<='1' when reset_buff=c_fedge else '0';
    w_restart<='1' when restart_buff=c_fedge else '0';
    
	s_reset<= '1' when cstate=idle else r_reset_ack;
	o_reset<=s_reset;
	s_mode <= cstate;
	
	
	

	o_signal_active(2)<= '1' when cstate=filter else
	            '1' when cstate=sig_gen else
	            '1' when cstate=small else
	            '0';
	            
	o_signal_active(1)<= '1' when cstate=filter else '0';
	
	o_signal_active(0)<= '1' when cstate=small else '0';
	
	----a modifier plus tard ---
	o_gen_led<= '1' when cstate=sig_gen else
	            '0';
	            
	o_fil_led<= '1' when cstate=filter else '0';
	
	o_idle_led<= '1' when cstate=idle else '0';
	
	o_small_led<= '1' when cstate=small else '0';
    
	with cstate select nstate<=
        sig_gen      when idle,
        filter     	 when sig_gen,
		small     	 when filter,
		idle     	 when small,
        idle         when others;
	
	
	
	process( i_clk)
	begin
		if rising_edge(i_clk) then

            -------------DEBOUNCE WITH BUFFER----------------
            reset_buff <= reset_buff(nreg-2 downto 0)&i_reset_g;
    
            restart_buff <= restart_buff(nreg-2 downto 0)&i_restart;
                    
            next_buff <=next_buff(nreg-2 downto 0)&i_next;
            
            
    
    
            case(cstate) is
                when idle=>
                    if w_next='1' then 
                        cstate<=nstate;
                        r_reset_ack<='1';
                    else 
                        cstate<=cstate;
                        r_reset_ack<='0';
                    end if;
                    
                when sig_gen=>
                    if w_reset_g='1' then	
                        cstate<=idle;
                        r_reset_ack<='1';
                    else
                        if w_restart='1' then
                            r_reset_ack<='1';
                        else
                            r_reset_ack<=r_reset_ack;
                            if w_next='1' then 
                                cstate<=nstate;
                            else 
                                cstate<=cstate;
                            end if;
                        end if;
                    end if;
                    
                when filter=>
                    if w_reset_g='1' then	
                        cstate<=idle;
                        r_reset_ack<='1';
                    else
                        if w_restart='1' then
                            r_reset_ack<='1';
                        else
                            r_reset_ack<=r_reset_ack;
                            if w_next='1' then 
                                cstate<=nstate;
                            else 
                                cstate<=cstate;
                            end if;
                        end if;
                    end if;
                 ------------------------- 
                   
                 when small =>
                     if w_reset_g='1' then	
                            cstate<=idle;
                            r_reset_ack<='1';
                        else
                            if w_restart='1' then
                                r_reset_ack<='1';
                            else
                                r_reset_ack<=r_reset_ack;
                                if w_next='1' then 
                                    cstate<=nstate;
                                else 
                                    cstate<=cstate;
                                end if;
                            end if;
                        end if;
                            
                 ------------------------   
                when others=>cstate<=idle;
            end case;
            if cstate=filter OR cstate=sig_gen then
                if r_reset_ack='1' then
                   
                    if (i_ack_fil AND i_ack_gen)='1' then
                        r_reset_ack<='0';
                    else
                        r_reset_ack<=r_reset_ack;
                    end if;
                else
                    if not (w_reset_g OR w_restart OR w_next) = '1' then
                        r_reset_ack<='0';
                    end if;
                end if;
            end if;
		end if;
	end process;
	----------------
	----------MUX-------------------------------
	process(i_bus_g, i_bus_f, s_mode,i_bus_s ) is
    begin
 
        case s_mode is
           
            when sig_gen =>            -- use  states to check state and select
                o_bus <= i_bus_g;
            when filter =>
                o_bus <= i_bus_f;
            when small =>
                o_bus <= i_bus_s;
            when others =>
                o_bus <= (others => '0');
        end case;
 
    end process;


	
end arch;