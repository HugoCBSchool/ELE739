--------------------------------------------------------------------------------
-- Title       : Down counter
-- Project     : ELE739 - PHASE 2
--------------------------------------------------------------------------------
-- File        : Down_Counter.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Wed Feb 24 19:08:06 2021
-- Last update : Wed Feb 24 22:17:05 2021
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2021 Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: This module is a downcounter which generates an interupt at 
-- underflow with load input
-------------------------------------------------------------------------------
--! Waveform:
--! {
--!		signal:[
--!			{name: "i_clk",                   wave: "p.................."},
--!			{name: "i_hw_input_slv.ped",      wave: "x01.0.............."},
--!			{name: "i_hw_input_slv.nxt",      wave: "x01.0.............."},
--!			{name: "i_hw_input_slv.step",     wave: "x01.0.............."},
--!			{name: "i_hw_input_slv.maint",    wave: "x01.0.............."},
--!			{name: "i_reset_slv.ped",         wave: "x0....10..........."},
--!			{name: "i_reset_slv.nxt",         wave: "x0......10........."},
--!			{name: "i_reset_slv.step",        wave: "x.................."},
--!			{name: "i_reset_slv.maint",       wave: "x0........10......."},
--!			{name: "o_req_slv.ped",           wave: "x0.........1.0....."},
--!			{name: "o_req_slv.nxt",           wave: "x0.........1...0..."},
--!			{name: "o_req_slv.step",          wave: "x0........1.0......"},
--!			{name: "o_req_slv.maint",         wave: "x0.........1.....0."},
--!		]
--! }
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
library work;

--! This module is a downcounter which generates an interupt at 
--! underflow with load input
entity DOWN_COUNTER is
    generic(
        constant g_unsigned_width:natural:=8 --! the width of the unsigned load_value
    );
    Port ( 
        i_load_value    : in std_logic_vector(g_unsigned_width-1 downto 0); --! the value at which to begin de downcounter
        i_load          : in std_logic;                                     --! put at one to issue a load at the next clock
        i_clk           : in std_logic;     --! clock
        o_done          : out std_logic                                     --! logic level goes to 1 when the counter decremented to 0 from the loaded value
    );
    
    --attribute use_dsp48:string;
    --attribute use_dsp48 of DOWN_COUNTER:entity is "yes";
    
end DOWN_COUNTER;

architecture Behavioral of DOWN_COUNTER is
        signal r_count          : signed(g_unsigned_width downto 0):=(others=>'0');--! count register
        signal r_next_count:signed(g_unsigned_width downto 0):=to_signed(-1,g_unsigned_width+1);

        signal w_load_value     : std_logic_vector(g_unsigned_width downto 0); --! type cast receptacle

  begin
   
    
        o_done  <= r_count(r_count'length-1);
        
        next_count:process(i_clk)
        begin
            if rising_edge(i_clk) then
                
                r_next_count<=signed(w_load_value);
                
                if i_load='0' then
                
                    r_next_count<=to_signed(0,g_unsigned_width+1);
                    
                    if r_count(g_unsigned_width)='0' then
                    
                        r_next_count<=r_count;
                        
                    end if;
                    
                end if;
                
            end if;
            
        end process next_count;
        
        
        --en:process(i_clk)
        --begin
            
        --end process en;
        
        w_load_value(g_unsigned_width downto 0)   <= std_logic_vector(signed('0'&i_load_value));
    
        COUNTER:process(i_clk) begin
            if rising_edge(i_clk) then
                r_count<=r_next_count-1;
            end if;
        end process COUNTER;
        
end Behavioral;
