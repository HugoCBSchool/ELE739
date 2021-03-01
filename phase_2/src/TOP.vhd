----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2021 09:11:16 PM
-- Design Name: 
-- Module Name: TOP - Behavioral
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
use work.pk_CONTROLER.all;
use work.pk_signal_generator.all;



-- =========================================================================================
entity TOP is
    Port ( 
        i_clk           : in  STD_LOGIC;
        i_pbn_RESET_G   : in  STD_LOGIC;
        i_pbn_RESTART   : in  STD_LOGIC;
        i_pbn_NEXT_MODE : in  STD_LOGIC;
        o_bus_sortie    : out tslv_bus_sortie;
        o_led_bank_state: out std_logic_vector(2 downto 0);
        o_bus_sortie_rdy: out std_logic
    );
end TOP;
-- =========================================================================================



-- =========================================================================================
architecture Behavioral of TOP is 
	

	-- ============================================================================
	--                   CMC-RELATED DEFINITIONS AND SIGNALS
    -- ---------------------------------------------------------------------------
    signal w_in             : trec_input;
    signal wslv_in          : tslv_input;
	-- ---------------------------------------------------------------------------
	signal w_signal_rdy     : std_logic;
	signal w_filter_rdy     : std_logic;
	-- ============================================================================



	-- ============================================================================
	--         FAST-CLOCKED COMPONENTS ROUTING SIGNALS AND INTERFACES
	-- ----------------------------------------------------------------------------
	signal w_reset_ack_gen    		: std_logic;
	signal w_reset_ack_filter 		: std_logic;
    signal w_ctrl 					: trec_ctrl;
    signal wslv_ctrl				: tslv_ctrl;
	signal w_filter_bus_sortie		: tslv_bus_sortie;
	signal w_generator_bus_sortie	: tslv_bus_sortie;
	signal w_mode_led_3       		: tslv_mode_led_3;
	signal w_bus_sortie       		: tslv_bus_sortie;
	signal w_cos_signal				: tslv_sample;
	-- ============================================================================

begin 

	-- ============================================================================
	--                        io routing
	-- ----------------------------------------------------------------------------
    w_reset_latch    <= slv2input(wslv_reset_latch); -- routing of fast-side reset signals
    o_led_bank_state <= w_mode_led_3;                -- output routing of the led bank output
    o_bus_sortie     <= w_bus_sortie;
    w_ctrl           <= slv2ctrl(wslv_ctrl);
    wslv_in          <= input2slv(w_in);
    w_in 			 <= slv2input(i_pbn_reset_g&i_pbn_restart&i_pbn_next_mode);

    with w_mode_led_3 select o_bus_sortie_rdy<=
        w_filter_rdy when c_mode_led_filter,
        w_signal_rdy when c_mode_led_gen,
        '0'          when others;
    -- ============================================================================



	-- ============================================================================
	--                       Controler instance and routings  - fast-domain
	-- ----------------------------------------------------------------------------
	-- ----------------------------------------------------------------------------
	--! instance of controler module responsible for 
	--! controlling the generator, output bus and filter
	CONTROLER_1 : entity work.CONTROLER
		port map (
			i_clk              => i_clk,
			i_reset_ack_gen    => w_reset_ack_gen,
			i_reset_ack_filter => w_reset_ack_filter,
            i_input_slv        => wslv_in,
			i_filter           => w_filter_bus_sortie,
			i_generator        => w_generator_bus_sortie,
			o_ctrl_bus         => wslv_ctrl,
			o_mode_led_3       => w_mode_led_3,
			o_bus_sortie       => w_bus_sortie,
		);	
	-- ============================================================================



	-- ============================================================================
	--                signal generator instance and routings  - fast-domain
	-- ----------------------------------------------------------------------------
	--! signal generator instance
	SIGNAL_GENERATOR_1 : entity work.SIGNAL_GENERATOR
		port map (
			i_clk           => i_clk,
            i_ctrl_slv      => wslv_ctrl,
			o_signal_probe  => w_generator_bus_sortie,
			o_cos           => w_cos_signal,
			o_reset_ack     => w_reset_ack_gen,
			o_signal_rdy    => w_signal_rdy
		);	
	-- ============================================================================



	-- ============================================================================
	--                Filter instance and routing  - fast-domain
	-- ----------------------------------------------------------------------------
	FIR_FILTER_1 : entity work.FIR_FILTER
		port map (
			i_signal       => w_cos_signal,
			i_signal_rdy   => w_signal_rdy,
			i_reset        => w_ctrl.reset,
			i_active_filter=> w_ctrl.filter_active,
			i_clk          => i_clk,
			o_filter       => w_filter_bus_sortie,
			o_reset_ack    => w_reset_ack_filter,
			o_filter_rdy   => w_filter_rdy
		);	
	-- ============================================================================


end Behavioral;
-- ========================================================================================================================