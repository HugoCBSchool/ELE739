--------------------------------------------------------------------------------
-- Title       : package of controler module
-- Project     : ELE739 - PHASE 2
--------------------------------------------------------------------------------
-- File        : pk_CONTROLER.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Wed Feb 24 19:08:06 2021
-- Last update : Fri Feb 26 02:56:55 2021
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2021 Hugo Cusson-Bouthillier
-------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.pk_signal_generator.all;



-- =====================================================================================
--                   package containing record types for this module
-- ------------------------------------------------------------------------------
package pk_CONTROLER is

	--------------------------------------------------------
	type   s_mode is (s_reset,s_idle,s_gen,s_filter);
	--------------------------------------------------------
	subtype  tslv_mode_led_3 is std_logic_vector(2 downto 0);
	subtype  tslv_bus_sortie is std_logic_vector(2*c_sample_w-1 downto 0);
	--------------------------------------------------------
	constant c_mode_led_idle   : tslv_mode_led_3 := "001";
	constant c_mode_led_gen    : tslv_mode_led_3 := "010";
	constant c_mode_led_filter : tslv_mode_led_3 := "100";
	constant c_mode_led_reset  : tslv_mode_led_3 := "000";
	--------------------------------------------------------



	--------------------------------------------------------
	constant c_slv_input_w : integer := 3;
	--------------------------------------------------------
	-- record type used for interpretation of signal vectors
	type trec_input is record
		RESET_G   : std_logic;
		RESTART   : std_logic;
		NEXT_MODE : std_logic;
	end record trec_input;
	type trec_ctrl is record
	   reset:std_logic;
	   gen_active:std_logic;
	   filter_active:std_logic;
	end record trec_ctrl;
	--------------------------------------------------------
	subtype tslv_input is std_logic_vector(c_slv_input_w-1 downto 0);
	subtype tslv_ctrl  is std_logic_vector(2 downto 0);
	--------------------------------------------------------
	--conversion functions
	pure function input2slv (input_rec : trec_input) return std_logic_vector;
	pure function slv2input (slv       : tslv_input) return trec_input ;
	pure function ctrl2slv (input_rec : trec_ctrl) return std_logic_vector;
	pure function slv2ctrl (slv       : tslv_ctrl) return trec_ctrl ;
	--------------------------------------------------------

end package pk_CONTROLER;
-- =====================================================================================



-- =====================================================================================
package body pk_CONTROLER is

	--------------------------------------------------------
	pure function input2slv (input_rec : trec_input) return std_logic_vector is
	begin
		return input_rec.RESET_G & input_rec.RESTART & input_rec.NEXT_MODE;
	end function input2slv;
	--------------------------------------------------------
    pure function slv2input (slv : tslv_input) return trec_input is
		variable rec : trec_input;
	begin
		rec.RESET_G   := slv(2);
		rec.RESTART   := slv(1);
		rec.NEXT_MODE := slv(0);
		return rec;
	end function slv2input;
	--------------------------------------------------------
	--------------------------------------------------------
	pure function ctrl2slv (input_rec : trec_ctrl) return std_logic_vector is
	begin
		return input_rec.reset & input_rec.gen_active & input_rec.filter_active;
	end function ctrl2slv;
	--------------------------------------------------------
    pure function slv2ctrl (slv : tslv_ctrl) return trec_ctrl is
		variable rec : trec_ctrl;
	begin
		rec.reset   := slv(2);
		rec.gen_active   := slv(1);
		rec.filter_active := slv(0);
		return rec;
	end function slv2ctrl;
	--------------------------------------------------------

end package body pk_CONTROLER;
-- =====================================================================================
