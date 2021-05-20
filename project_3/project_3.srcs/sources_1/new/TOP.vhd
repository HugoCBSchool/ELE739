----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2021 10:42:55 AM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library work;
use work.pk_control.all;

entity TOP is
	generic (
		constant g_debouncer_shreg_width : integer:=12;
		constant g_signal_length		 : natural:=16
	);
	port (
		i_pbn_restart	: in std_logic;
		i_pbn_next		: in std_logic;
		i_pbn_reset_g	: in std_logic;
		i_clk   		: in std_logic;

		o_idle_led      : out std_logic;
		o_gen_led       : out std_logic;
		o_fil_led       : out std_logic;
		o_small_led     : out std_logic
	);
end TOP;

architecture Behavioral of TOP is
	component clk_wiz_0
	port(
		clk_100M          : out    std_logic;
		clk_12_5M         : out    std_logic;
		clk_ila           : out    std_logic;
		clk_in1           : in     std_logic
	);
	end component;
    COMPONENT ila_0
    PORT (
        clk : IN STD_LOGIC;
        probe0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        probe1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
    END COMPONENT;


	signal w_clk_12_5M     : std_logic;
	signal w_clk_100M	   : std_logic;
    signal w_clk_ila        :std_logic;
	--for output mux
	signal w_bus_gen         : std_logic_vector(15 downto 0);
	signal w_bus_fir         : std_logic_vector(15 downto 0);
	signal w_bus_small       : std_logic_vector(15 downto 0);
	signal w_bus_sortie      : std_logic_vector(15 downto 0);

	--for signal propagation
	signal w_cos			 : std_logic_vector(7 downto 0);
	signal w_avg             : std_logic_vector(7 downto 0);

	--controler
	signal w_reset         : std_logic;
	signal wslv_ctrl_bus   : tslv_ctrl;
	signal w_ctrl_bus 	   : trec_ctrl;
	signal wslv_rst_ack    : tslv_rst;
	signal w_rst_ack 	   : trec_rst_ack;
	
	--signal readys
	signal w_gen_signal_rdy    : std_logic;
	signal w_fir_signal_rdy    : std_logic;
	signal w_avg_signal_rdy    : std_logic;
	signal w_small_signal_rdy  : std_logic;
    signal w_signal_rdy        : std_logic_vector(0 downto 0);
    
	signal w_gen_rst_ack   : std_logic;-- forwarding towards i_rst of average module

begin

	w_ctrl_bus  <=slv2ctrl(wslv_ctrl_bus);
	wslv_rst_ack<=rst2slv(w_rst_ack);

    with wslv_ctrl_bus select w_signal_rdy(0)<=
        w_gen_signal_rdy when "001",
        w_fir_signal_rdy when "010",
        w_small_signal_rdy when "100",
        '0' when others;

	Control_1 : entity work.Control
		generic map (
			g_debouncer_shreg_width => g_debouncer_shreg_width
		)
		port map (
			i_clk         => w_clk_100M,
			i_rst_ack_slv => wslv_rst_ack,
			i_reset_g     => i_pbn_reset_g,
			i_restart     => i_pbn_restart,
			i_next        => i_pbn_next,
			i_bus_g       => w_bus_gen,
			i_bus_f       => w_bus_fir,
			i_bus_s       => w_bus_small,
			o_ctrl_bus    => wslv_ctrl_bus,
			o_reset       => w_reset,
			o_idle_led    => o_idle_led,
			o_gen_led     => o_gen_led,
			o_fil_led     => o_fil_led,
			o_small_led   => o_small_led,
			o_bus         => w_bus_sortie
		);


	SIGNAL_GENERATOR_1 : entity work.SIGNAL_GENERATOR
		port map (
			i_clk          => w_clk_100M,
			i_clk_slow     => w_clk_12_5M,
			i_ctrl_slv     => wslv_ctrl_bus,
			i_rst          => w_reset,
			o_reset_ack    => w_gen_rst_ack,
			o_signal_probe => w_bus_gen,
			o_cos          => w_cos,
			o_signal_rdy   => w_gen_signal_rdy
		);


	FIR_FILTER_1 : entity work.FIR_FILTER
		port map (
			i_signal        => w_cos,
			i_reset         => w_reset,
			i_active_filter => w_ctrl_bus.filter_active,
			i_signal_rdy    => w_gen_signal_rdy,
			i_clk           => w_clk_100M,
			o_filter        => w_bus_fir,
			o_reset_ack     => w_rst_ack.filter,
			o_filter_rdy    => w_fir_signal_rdy
		);

	SIGNAL_AVERAGE_1 : entity work.SIGNAL_AVERAGE
		generic map (
			g_signal_length => g_signal_length
		)
		port map (
			i_signal         => w_bus_gen,
			i_clk            => w_clk_12_5M,
			i_reset          => w_gen_rst_ack,
			i_signal_rdy     => w_gen_signal_rdy,
			i_average_active => w_ctrl_bus.small_filter_active,
			o_average        => w_avg,
			o_avrg_rdy       => w_avg_signal_rdy,
			o_reset_ack      => w_rst_ack.avg
		);

	SMALL_FIR_FILTER_1 : entity work.SMALL_FIR_FILTER
		port map (
			i_average             => w_avg,
			i_clk                 => w_clk_12_5M,
			i_clk_fast            => w_clk_100M,
			i_signal_rdy          => w_avg_signal_rdy,
			i_reset               => w_reset,
			i_small_filter_active => w_ctrl_bus.small_filter_active,
			o_reset_ack           => w_rst_ack.small,
			o_filter_rdy          => w_small_signal_rdy,
			o_small_filter        => w_bus_small
		);	
	MMCM_1 : clk_wiz_0
		port map ( 
			clk_100M => w_clk_100M,
			clk_12_5M => w_clk_12_5M,
			clk_ila => w_clk_ila,
			clk_in1 => i_clk
		);
	ILA : ila_0
        PORT MAP (
            clk => w_clk_ila,
            probe0 => w_signal_rdy,
            probe1 => w_bus_sortie
        );
end Behavioral;
