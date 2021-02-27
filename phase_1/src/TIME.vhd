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
    use IEEE.NUMERIC_STD.ALL;
    use ieee.math_real.all;
    
library work;
    use work.pk_time.all;

package pk_time_cst is
-- uninfered constants
    -- GYR light time constants
    constant c_time_G_NS_s          :   real:= 10.0;
    constant c_time_Y_NS_s          :   real:= 7.0;
    constant c_time_G_EW_s          :   real:= 10.0;
    constant c_time_Y_EW_s          :   real:= 7.0;
    constant c_time_R_strobe_s      :   real:= 0.8;
    constant c_time_pbn_s			:	real:= 0.7;

    -- PED light time constants
    constant c_time_strobe_PED_s    :   real    := 0.8;
    constant c_time_go_PED_s        :   real    := 5.0;
    constant c_nb_strobe_toggle_PED :   natural := 10;
    

    --constant c_uvec_w_pbn			: natural :=uvec_width(nb_tick(c_time_pbn_s));
    --subtype  t_time_pbn	is unsigned(c_uvec_w_pbn-1 downto 0);
    --constant c_uvec_pbn_tck			: t_time_pbn:=to_unsigned(nb_tick(c_time_pbn_s),c_uvec_w_pbn);
-- NS Light constants
    --non-vectorial infered constants
    --constant c_max_time_NS_s    :   real:= max_real( 
    --                                    max_real( c_time_G_NS_s , c_time_Y_NS_s )  ,
    --                                    c_time_R_strobe_s
    --                                );
    --constant c_uvec_w_NS        :   natural:= uvec_width(nb_tick(c_max_time_NS_s,c_clk_freq_mhz));
    
    --  unsigned type of length defined by max value of time to count
    --subtype  t_time_NS is  unsigned(c_uvec_w_NS-1 downto 0);
    
    --  time constants expressed in subtype format
    --constant c_uvec_G_NS_tck        :   t_time_NS := to_unsigned( nb_tick(c_time_G_NS_s,c_clk_freq_mhz)     , c_uvec_w_NS );
    --constant c_uvec_Y_NS_tck        :   t_time_NS := to_unsigned( nb_tick(c_time_Y_NS_s,c_clk_freq_mhz)     , c_uvec_w_NS );
    --constant c_uvec_strobe_NS_tck   :   t_time_NS := to_unsigned( nb_tick(c_time_R_strobe_s,c_clk_freq_mhz) , c_uvec_w_NS );
    
    
-- EW Light constants
    --non-vectorial infered constants
    --constant c_max_time_EW_s    :   real:= max_real(
      --                                  max_real( c_time_G_EW_s , c_time_Y_EW_s )  ,
        --                                c_time_R_strobe_s
          --                          );
    --constant c_uvec_w_EW        :   natural := uvec_width(nb_tick(c_max_time_EW_s,c_clk_freq_mhz));
    
    --  unsigned type of length defined by max value of time to count
    --subtype  t_time_EW is  unsigned(c_uvec_w_EW-1 downto 0);
    
    --  time constants expressed in subtype format
    --constant c_uvec_G_EW_tck        :   t_time_EW := to_unsigned( nb_tick(c_time_G_EW_s,c_clk_freq_mhz)     , c_uvec_w_EW );
    --constant c_uvec_Y_EW_tck        :   t_time_EW := to_unsigned( nb_tick(c_time_Y_EW_s,c_clk_freq_mhz)     , c_uvec_w_EW );
    --constant c_uvec_strobe_EW_tck   :   t_time_EW := to_unsigned( nb_tick(c_time_R_strobe_s,c_clk_freq_mhz) , c_uvec_w_EW );
                                               
-- pedestrian Light constants
    --non-vectorial infered constants
    --constant c_time_PED_stop_s  :   real:= real(c_nb_strobe_toggle_PED)*c_time_strobe_PED_s;
    --constant c_max_time_PED_s   :   real:= max_real( c_time_strobe_PED_s , c_time_go_PED_s )   ;                                               
    --constant c_uvec_w_PED       :   natural:=uvec_width(nb_tick(c_max_time_PED_s,c_clk_freq_mhz));
    --constant c_uvec_w_strobe	:	natural:=uvec_width(nb_tick(c_time_strobe_ped_s,c_clk_freq_mhz));
    --constant c_uv_w_count_ped   :   natural:=uvec_width(c_nb_strobe_toggle_ped);
    --  unsigned type of length defined by max value of time to count
    --subtype  t_time_PED is  unsigned(c_uvec_w_PED-1 downto 0);
    
    --  time constants expressed in subtype format
    --constant c_uvec_strobe_PED_tck  :   t_time_PED := to_unsigned( nb_tick(c_time_strobe_PED_s,c_clk_freq_mhz) , c_uvec_w_PED );
    --constant c_uvec_go_PED_tck      :   t_time_PED := to_unsigned( nb_tick(c_time_go_PED_s,c_clk_freq_mhz)     , c_uvec_w_PED );
    
end pk_time_cst;
----------------------------------------------------------------------------------