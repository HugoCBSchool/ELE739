----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2021 06:59:02 PM
-- Design Name: 
-- Module Name: DOWN_COUNTER - Behavioral
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
use IEEE.numeric_std.all;
library work;

entity DOWN_COUNTER is
    generic(
        constant g_unsigned_width:natural:=16 --! the width of the unsigned load_value
    );
    Port ( 
        i_load_value    : in std_logic_vector(g_unsigned_width-1 downto 0); --! the value at which to begin de downcounter
        i_load          : in std_logic;                                     --! put at one to issue a load at the next clock
        i_clk           : in std_logic;     --! clock
        o_done          : out std_logic                                     --! logic level goes to 1 when the counter decremented to 0 from the loaded value
    );
    attribute use_dsp48:string;
    attribute use_dsp48 of DOWN_COUNTER:entity is "yes";
end DOWN_COUNTER;

architecture Behavioral of DOWN_COUNTER is
        signal r_count      : signed(g_unsigned_width downto 0):=(others=>'0');--! count register
        signal w_load_value : std_logic_vector(g_unsigned_width downto 0); --! type cast receptacle
        
    begin
    
        o_done  <=  r_count(g_unsigned_width);
        
        w_load_value(g_unsigned_width)              <= '0';
        w_load_value(g_unsigned_width-1 downto 0)   <= std_logic_vector(i_load_value);
    
        COUNTER:process(i_clk) begin
            if rising_edge(i_clk) then
                if (i_load='1') then
                    r_count<=signed(w_load_value);
                else
                    if(r_count(g_unsigned_width)='0') then
                        r_count<=r_count-1;
                    else
                        r_count<=r_count;
                    end if;
                end if;
            end if;
        end process COUNTER;
        
end Behavioral;
