--------------------------------------------------------------------------------
-- Title       : package of signal generator module
-- Project     : ELE739 - PHASE 2
--------------------------------------------------------------------------------
-- File        : pk_signal_generator.vhd
-- Author      : Hugo Cusson-Bouthillier
-- Created     : Wed Feb 24 19:08:06 2021
-- Last update : Fri Feb 26 02:59:30 2021
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
use ieee.math_real.all;



-- =====================================================================================
--         package containing types and constants for the module signal_generator
-- -------------------------------------------------------------------------------------
package pk_signal_generator is

	--------------------------------------------------
	constant c_sample_w  : integer := 8;
	constant c_nb_sample : integer := 16;
	constant c_rom_adr_w : integer := 4;
	--------------------------------------------------
	subtype tslv_sample is std_logic_vector( c_sample_w  - 1 downto 0 );
	subtype t_sample    is signed(           c_sample_w  - 1 downto 0 );
	subtype t_rom_adr   is unsigned(         c_rom_adr_w - 1 downto 0 );
	--------------------------------------------------
	type t_rom_sample is array( c_nb_sample - 1 downto 0 ) of t_sample;
	--------------------------------------------------
	constant c_rom_cos : t_rom_sample := (
			0  => to_signed( 126  , c_sample_w),
			1  => to_signed( 108  , c_sample_w),
			2  => to_signed( 73   , c_sample_w),
			3  => to_signed( 27   , c_sample_w),
			4  => to_signed( -23  , c_sample_w),
			5  => to_signed( -70  , c_sample_w),
			6  => to_signed( -106 , c_sample_w),
			7  => to_signed( -126 , c_sample_w),
			8  => to_signed( -127 , c_sample_w),
			9  => to_signed( -109 , c_sample_w),
			10 => to_signed( -74  , c_sample_w),
			11 => to_signed( -28  , c_sample_w),
			12 => to_signed( 22   , c_sample_w),
			13 => to_signed( 69   , c_sample_w),
			14 => to_signed( 105  , c_sample_w),
			15 => to_signed( 125  , c_sample_w)
		);
	--------------------------------------------------
	constant c_rom_saw : t_rom_sample := (
			0  => to_signed( 125  , c_sample_w ),
			1  => to_signed( 109  , c_sample_w ),
			2  => to_signed( 93   , c_sample_w ),
			3  => to_signed( 77   , c_sample_w ),
			4  => to_signed( 61   , c_sample_w ),
			5  => to_signed( 45   , c_sample_w ),
			6  => to_signed( 29   , c_sample_w ),
			7  => to_signed( 13   , c_sample_w ),
			8  => to_signed( -3   , c_sample_w ),
			9  => to_signed( -19  , c_sample_w ),
			10 => to_signed( -35  , c_sample_w ),
			11 => to_signed( -52  , c_sample_w ),
			12 => to_signed( -68  , c_sample_w ),
			13 => to_signed( -84  , c_sample_w ),
			14 => to_signed( -100 , c_sample_w ),
			15 => to_signed( -116 , c_sample_w )
		);
	--------------------------------------------------

end package pk_signal_generator;
-- =====================================================================================
