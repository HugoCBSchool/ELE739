----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2021 10:02:03 PM
-- Design Name: 
-- Module Name: TOP_tb - testbench
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
library work;
use work.pk_seq_code.all;
use work.pk_input_interface.all;
use work.pk_FSM_CONTROL.all;
--use work.pk_time_cst.all;
--use work.pk_time.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP_tb is

end TOP_tb;

-----------------------------------------------------------

architecture testbench of TOP_tb is

	-- Testbench DUT ports
	signal i_clk                   : std_logic;
	signal i_pbn_ped_req           : std_logic;
	signal i_pbn_maint_mode        : std_logic;
	signal i_sw_step_mode          : std_logic;
	signal i_pbn_next              : std_logic;
	signal o_red_ns,o_red_ew       : std_logic;
	signal o_green_ns,o_green_ew   : std_logic;
	signal o_yellow_ns,o_yellow_ew : std_logic;
	signal o_light_ped             : std_logic;

	-- Other constants
	constant C_CLK_PERIOD : real := 2.55e-9; -- NS


	constant c_clk_freq_mhz         : real    := (1.0e-6)/c_clk_period;
	constant c_time_strobe_PED_s    : real    := 5.0*c_clk_period;
	constant c_nb_strobe_toggle_PED : natural := 10;
	constant c_time_go_PED_s        : real    := 100.0*c_clk_period;
	constant c_time_G_NS_s          : real    := c_time_go_PED_s;
	constant c_time_Y_NS_s          : real    := 60.0*c_clk_period;
	constant c_time_R_strobe_s      : real    := c_time_strobe_PED_s ;
	constant c_time_G_ew_s          : real    := 90.0*c_clk_period;
	constant c_time_Y_ew_s          : real    := 60.0*c_clk_period;
	constant c_time_pbn_s			: real	  := 0.5;
begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		i_clk <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		i_clk <= '0';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
	end process CLK_GEN;


	gen : process
	begin
		i_pbn_next       <= '0';
		i_pbn_maint_mode <= '0';
		i_sw_step_mode   <= '0';
		i_pbn_ped_req    <= '0';
		wait until rising_edge(i_clk);
		wait for 0.1*C_CLK_PERIOD*(1 sec);
		i_pbn_maint_mode <= '1';
		wait for (c_time_pbn_s)*(1 sec);
		i_pbn_maint_mode <= '0';
        
        wait until rising_edge(o_yellow_ew);
        wait until rising_edge(i_clk);
        wait for 0.1*c_clk_period*(1 sec);
        i_pbn_maint_mode <= '1';
		wait for (c_time_pbn_s)*(1 sec);
		i_pbn_maint_mode <= '0';
        
        
        
        wait until rising_edge(o_red_ns);
        wait until rising_edge(o_red_ns);
        wait until rising_edge(o_red_ns);
        wait until rising_edge(o_red_ns);
        wait until rising_edge(o_red_ns);
        wait until falling_edge(o_red_ns);
        
        wait until rising_edge(i_clk);
        wait for 0.1*c_clk_period*(1 sec);
        i_pbn_maint_mode <= '1';
		wait for (c_time_pbn_s)*(1 sec);
		i_pbn_maint_mode <= '0';
        
        wait until rising_edge(o_yellow_ew);
        wait until rising_edge(o_green_ns);
        i_pbn_ped_req<='1';
        wait for (c_time_pbn_s)*(1 sec);
        i_pbn_ped_req<='0';
        
        
        wait for (c_time_pbn_s)*10.0*(1 sec);
        wait until rising_edge(o_green_ns);
        i_sw_step_mode<='1';
        
        
        
        
        wait until rising_edge(o_red_ns);
        wait for 0.1*c_clk_period*(1 sec);
        i_pbn_next<='1';      
        wait for c_time_pbn_s*18.0*(1 sec);
        wait until rising_edge(i_clk);
        wait for 0.1*c_clk_period*(1 sec);
        i_pbn_ped_req<='1';
        wait for c_time_pbn_s*(1 sec);
        i_pbn_ped_req<='0';
        wait until falling_edge(o_light_ped);
        wait for c_clk_period*20.0*(1 sec);
        i_pbn_next<='0';
        wait for c_clk_period*40.0*(1 sec);
        i_pbn_ped_req<='1';
        wait for c_clk_period*40.0*(1 sec);
        i_pbn_ped_req<='0';
        i_pbn_next<='1';
        wait for c_time_pbn_s*(1 sec);
        i_pbn_next<='0';
        wait for c_clk_period*10.0*(1 sec);
        i_pbn_next<='1';
        wait for c_time_pbn_s*(1 sec);
        i_pbn_next<='0';
        wait for c_clk_period*10.0*(1 sec);
        i_pbn_next<='1';
        wait for c_time_pbn_s*(1 sec);
        i_pbn_next<='0';
        wait for c_clk_period*10.0*(1 sec);
        i_pbn_next<='1';
        wait for c_time_pbn_s*(1 sec);
        i_pbn_next<='0';
        wait for c_clk_period*10.0*(1 sec);
        i_pbn_next<='1';
        wait for c_time_pbn_s*(1 sec);
        i_pbn_next<='0';
        wait for c_clk_period*10.0*(1 sec);
        i_pbn_next<='1';
        wait for c_time_pbn_s*(1 sec);
        i_pbn_next<='0';
        wait for c_clk_period*10.0*(1 sec);
        i_pbn_next<='1';
        wait for c_time_pbn_s*(1 sec);
        i_pbn_next<='0';
        wait for c_clk_period*10.0*(1 sec);
        i_pbn_next<='1';
        wait for c_time_pbn_s*(1 sec);
        i_pbn_next<='0';
        wait for c_clk_period*10.0*(1 sec);
        i_pbn_next<='1';
        wait for c_time_pbn_s*(1 sec);
        i_pbn_next<='0';
        wait for c_clk_period*10.0*(1 sec);
        i_pbn_next<='1';
        i_sw_step_mode<='0';
        
        
        
        
        
        
        
        
             
        
        
		wait;

	end process gen;




	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	TOP_2 : entity work.TOP
		generic map (
			 g_clk_freq_mhz         =>  c_clk_freq_mhz,
			 g_time_strobe_PED_s    =>  c_time_strobe_PED_s,
			 g_nb_strobe_toggle_PED =>  c_nb_strobe_toggle_PED,
			 g_time_go_PED_s        =>  c_time_go_PED_s,
			 g_time_G_NS_s          =>  c_time_G_NS_s,
			 g_time_Y_NS_s          =>  c_time_Y_NS_s,
			 g_time_R_strobe_s      =>  c_time_R_strobe_s,
			 g_time_G_ew_s          =>  c_time_G_ew_s,
			 g_time_Y_ew_s          =>  c_time_Y_ew_s,
			 g_time_pbn_s			=>	c_time_pbn_s	
		)
		port map (
			i_clk            => i_clk,
			i_pbn_ped_req    => i_pbn_ped_req,
			i_pbn_maint_mode => i_pbn_maint_mode,
			i_sw_step_mode   => i_sw_step_mode,
			i_pbn_next       => i_pbn_next,
			o_red_ns         => o_red_ns,
			o_red_ew         => o_red_ew,
			o_green_ns       => o_green_ns,
			o_green_ew       => o_green_ew,
			o_yellow_ns      => o_yellow_ns,
			o_yellow_ew      => o_yellow_ew,
			o_light_ped      => o_light_ped
		);

end testbench;
