----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2021 12:50:42 PM
-- Design Name: 
-- Module Name:  - Behavioral
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


package pk_time is

--  uninfered constants
    constant c_clk_freq_mhz     :   real:= 100.0;
    constant c_time_pbn_s			:	real:= 0.7;

    
--  function instanciation
    pure function nb_tick(i_time_s: real;i_clk_mhz:real)return natural;
    pure function uvec_width(i_max_natural: natural) return natural;
    pure function max_real(a,b: real) return real;
    
end package pk_time;

package body pk_time is
--  function implementations:
    pure function nb_tick(  i_time_s : real;i_clk_mhz:real) return natural is
    -- returns the number of clock ticks after which the inputted seconds have passed
    -- args: i_time_s->real value of time in seconds to be converted in number of clock ticks
        begin
            return natural(i_time_s*i_clk_mhz*1000.0*1000.0);
    end nb_tick;
    
    pure function uvec_width(i_max_natural:natural) return natural is
        begin
            return natural(ceil(log2(real(i_max_natural))));
    end uvec_width;
    
    pure function max_real(a,b: real)return real is
            variable tmp:real;
        begin
            if(b>a) 
                then tmp:=b;
                else tmp:=a;
            end if;
            return tmp;
    end max_real;
    
end package body pk_time;
----------------------------------------------------------------------------------
