----------------------------------------------------------------------------------
-- Company: ETS.
-- Team members :   Gabriel Gandubert, Hugo Cusson-Bouthillier and 
--                  Ernesto Castaldo-Santillan
--
-- Author :         Gabriel Gandubert
-- 
-- Create Date: 03/18/2021
-- Design Name: SMALL_FIR_FILTER - Behavior
-- Project Name: ELE739 - Phase 3
-- Target Devices: Basys 3
-- Description: 
--  This component computes an eight level FIR filter optimized in converage area.
--  To reduce the area used, this filter uses a single multiplier block and a single
--  adder.
-- 
-- File dependencies: 
--   pk_small_fir_filter.vhd
-- 
-- Revision:
--   Revision 0.01 - File Created
-- Additional Comments:
--    For each variable name, the following indicators are used:
--        g_<var> : generic
--        i_<var> : input
--        o_<var> : output
--        w_<var> : internal wire
--        r_<var> : register
--        c_<var> : constant
--        s_<var> : local signal
----------------------------------------------------------------------------------

-- Standard IEEE VHDL functions for synthesis and simulation behavior.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

library work;
use work.pk_small_fir_filter.all;

entity SMALL_FIR_FILTER is
  Port (
    i_average   :          IN STD_LOGIC_VECTOR(g_i_vec_size-1 downto 0);
    i_clk       :          IN STD_LOGIC;
    i_clk_fast  :          IN STD_LOGIC;
    i_reset     :          IN STD_LOGIC;
    i_signal_rdy:          in std_logic;
    i_small_filter_active: IN STD_LOGIC;
    o_reset_ack :          OUT STD_LOGIC;
    o_filter_rdy:          OUT STD_LOGIC;
    o_small_filter:        OUT STD_LOGIC_VECTOR(15 downto 0)
    );
end SMALL_FIR_FILTER;

architecture Behavioral of SMALL_FIR_FILTER is
    -- All the following variables are using unique types.
    -- Array of the coefficients of the filter. To set the constants, open the package and change them.
    constant coef_n : t_rom_sample := coef;
    
    -- Array of 8 bit vectors. These represent the shift register.
    signal x_n : t_signal_reg;
    
    -- Multiplication result output.
    signal s_multiplication :   STD_LOGIC_VECTOR(15 downto 0);
    
    -- These variables represent the current dans next state of the FSM.
    signal w_next_state         :   STATE_TYPE;
    signal r_current_state      :   STATE_TYPE;
    
    -- Unsigned value used to reference each state for the array index to use.
    signal state_index          :   UNSIGNED(2 downto 0);
    
    -- Output before slow clock output.
    signal r_small_filter_out   :   STD_LOGIC_VECTOR(15 downto 0);
    
    -- Output of the feedback resgister.
    signal w_filter_feedback    :   STD_LOGIC_VECTOR(15 downto 0);
    signal w_filter_feedback_out    :   STD_LOGIC_VECTOR(15 downto 0);
    
    -- Reset signal used for the feedback register. Special reset is required for this register.
    signal w_feedback_reset     :   STD_LOGIC;
    
    -- Rising edge detector for the feedback register to reset.
    signal r_rising_detector    :   STD_LOGIC;
    signal r_fast_rising_detector    :   STD_LOGIC;
    
    signal r_filter_rdy     :   STD_LOGIC;
begin
    
    -- Synchronous process for the reset and the registers of the used slowest clock.
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            -- Synchonous reset.
            if(i_reset = '1') then
                -- reset the first value into the first level of the register.
                x_n(0) <= (OTHERS => '0');
                -- System output reset.
                o_small_filter <= (OTHERS => '0');
                -- Input register reset loop.
                l_register_reset : FOR k in 0 to g_nb_filter_stage-1 loop
                    x_n(to_integer(to_unsigned(k,3))) <= (OTHERS => '0');
                end loop l_register_reset;
                -- Rising edge detector  reset.
                r_rising_detector <= '0';
                -- active filter indicator reset.
                o_filter_rdy <= '0';
                r_filter_rdy <= '0';
                -- Reset acknowledge
                o_reset_ack <= i_reset;
            else
                -- Clock enable behavior
                if(i_small_filter_active = '1') then
                    -- Set the first value into the first level of the register.
                    x_n(0) <= i_average;
                    -- System output.
                    o_small_filter <= r_small_filter_out;
                    -- Input register.
                    l_register_set : FOR k in 0 to g_nb_filter_stage-2 loop
                        x_n(to_integer(to_unsigned(k+1,3))) <= x_n(to_integer(to_unsigned(k,3)));
                    end loop l_register_set;
                    -- Rising edge detector for filter feedback reset.
                    r_rising_detector <= NOT r_rising_detector;
                    -- If reset is not active, check if data is ready.
                    r_filter_rdy <= i_signal_rdy and i_small_filter_active;
                    o_filter_rdy <= r_filter_rdy;
                end if;
                -- If reset is not active, set reset ack to 0.
                o_reset_ack <= '0';
            end if;
        end if;
    end process;
    
    -- Synchronous process for the reset and the registers of the fastest used clock.
    process(i_clk_fast)
    begin
        if(rising_edge(i_clk_fast)) then
            if(i_reset = '1') then
                r_current_state <= coef_7;
                r_fast_rising_detector <= '0';
                w_filter_feedback <= (OTHERS => '0');
            else
                if(i_small_filter_active = '1') then
                    r_current_state <= w_next_state;
                    w_filter_feedback <= r_small_filter_out;
                    r_fast_rising_detector <= r_rising_detector;
                end if;
            end if;
        end if;
    end process;
    
    w_feedback_reset <= r_fast_rising_detector XOR r_rising_detector;
    
    process(w_feedback_reset, w_filter_feedback)
    begin
        if(w_feedback_reset = '1') then
            w_filter_feedback_out <= (OTHERS => '0');
        else
            w_filter_feedback_out <= w_filter_feedback;
        end if;
    end process;
    
    -- State machine for the segmentation of the computation of the filter. simple counter.
    with r_current_state select w_next_state <= coef_1 when coef_0,
                                                coef_2 when coef_1,
                                                coef_3 when coef_2,
                                                coef_4 when coef_3,
                                                coef_5 when coef_4,
                                                coef_6 when coef_5,
                                                coef_7 when coef_6,
                                                coef_0 when coef_7,
                                                coef_0 when others;     -- selection of next state to occure.
                                                    
    -- Index reference of each state.
    with r_current_state select state_index  <= to_unsigned(0,3) when coef_0,
                                                to_unsigned(1,3) when coef_1,
                                                to_unsigned(2,3) when coef_2,
                                                to_unsigned(3,3) when coef_3,
                                                to_unsigned(4,3) when coef_4,
                                                to_unsigned(5,3) when coef_5,
                                                to_unsigned(6,3) when coef_6,
                                                to_unsigned(7,3) when coef_7,
                                                to_unsigned(0,3) when others;     -- first coefficient by default.
    
--    with r_current_state select w_feedback_reset  <= '1' when coef_7,
--                                                '0' when others;
    
    -- Multiplication operation of the state corresponding coefficient with the state corresponding input.
    s_multiplication <= std_logic_vector(resize(signed(coef_n(to_integer(state_index))) * signed(x_n(to_integer(state_index))),16));
    
    -- Final addition of the feedback with the multiplication.
    r_small_filter_out <= std_logic_vector(signed(w_filter_feedback_out) + signed(s_multiplication));
    
--    MACC_MACRO_inst : MACC_MACRO
--   generic map (
--      DEVICE => "7SERIES",  -- Target Device: "VIRTEX5", "7SERIES", "SPARTAN6" 
--      LATENCY => 1,         -- Desired clock cycle latency, 1-4
--      WIDTH_A => 8,         -- Multiplier A-input bus width, 1-25
--      WIDTH_B => 6,         -- Multiplier B-input bus width, 1-18     
--      WIDTH_P => 16)        -- Accumulator output bus width, 1-48
--   port map (
--      P => r_small_filter_out,     -- MACC ouput bus, width determined by WIDTH_P generic 
--      A => x_n(to_integer(state_index)),     -- MACC input A bus, width determined by WIDTH_A generic 
--      ADDSUB => '1', -- 1-bit add/sub input, high selects add, low selects subtract
--      B => coef_n(to_integer(state_index)),           -- MACC input B bus, width determined by WIDTH_B generic 
--      CARRYIN => '0', -- 1-bit carry-in input to accumulator
--      CE => i_small_filter_active,      -- 1-bit active high input clock enable
--      CLK => i_clk_fast,    -- 1-bit positive edge clock input
--      LOAD => '1', -- 1-bit active high input load accumulator enable
--      LOAD_DATA => w_filter_feedback_out, -- Load accumulator input data, 
--                              -- width determined by WIDTH_P generic
--      RST => i_reset    -- 1-bit input active high reset
--   );
    
--        CLK_GEN : clk_wiz_0
--        port map ( 
--            -- Clock out ports  
--            i_clk_fast => i_clk_fast,
--            i_clk => i_clk,
--            -- Clock in ports
--            clk_in1 => s_clk_in
--        );

end Behavioral;
