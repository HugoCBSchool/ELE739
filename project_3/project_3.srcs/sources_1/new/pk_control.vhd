--------------------------------------------------------------------------------
-- Title       : package of controler module
-- Project     : ELE739 - PHASE 2
--------------------------------------------------------------------------------
-- File        : pk_CONTROLER.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Wed Feb 24 19:08:06 2021
-- Last update : Mon Mar 29 11:38:07 2021
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
package pk_control is

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


	type trec_ctrl is record
	   gen_active			:std_logic;
	   filter_active		:std_logic;
	   small_filter_active	:std_logic;
	end record trec_ctrl;

	type trec_rst_ack is record
		filter: std_logic;
		small:	std_logic;
		avg:	std_logic;
	end record trec_rst_ack;
	--------------------------------------------------------
	subtype tslv_ctrl  is std_logic_vector(2 downto 0);
	subtype tslv_rst   is std_logic_vector(2 downto 0);
	--------------------------------------------------------
	--conversion functions
	pure function rst2slv (rst_rec    : trec_rst_ack) return std_logic_vector;
	pure function slv2rst (slv        : tslv_rst) 	  return trec_rst_ack ;
	pure function ctrl2slv (ctrl_rec  : trec_ctrl)    return std_logic_vector;
	pure function slv2ctrl (slv       : tslv_ctrl)    return trec_ctrl ;
	--------------------------------------------------------

end package pk_control;
-- =====================================================================================



-- =====================================================================================
package body pk_control is

	--------------------------------------------------------
	pure function rst2slv (rst_rec : trec_rst_ack) return std_logic_vector is
	begin
		return rst_rec.filter & rst_rec.small & rst_rec.avg;
	end function rst2slv;
	--------------------------------------------------------
    pure function slv2rst (slv : tslv_rst) return trec_rst_ack is
		variable rec : trec_rst_ack;
	begin
		rec.filter   	:= slv(0);
		rec.small  		:= slv(1);
		rec.avg 		:= slv(2);
		return rec;
	end function slv2rst;
	--------------------------------------------------------
	--------------------------------------------------------
	pure function ctrl2slv (ctrl_rec : trec_ctrl) return std_logic_vector is
	begin
		return ctrl_rec.gen_active & ctrl_rec.filter_active & ctrl_rec.small_filter_active ;
	end function ctrl2slv;
	--------------------------------------------------------
    pure function slv2ctrl (slv : tslv_ctrl) return trec_ctrl is
		variable rec : trec_ctrl;
	begin
		rec.gen_active   		:= slv(0);
		rec.filter_active 		:= slv(1);
		rec.small_filter_active	:= slv(2);
		return rec;
	end function slv2ctrl;
	--------------------------------------------------------

end package body pk_control;
-- =====================================================================================
