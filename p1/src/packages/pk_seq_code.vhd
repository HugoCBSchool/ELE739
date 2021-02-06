--------------------------------------------------------------------------------
-- package containing record types for this module
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------
package pk_seq_code is

	-- record type used for interpretation of signal vectors
	type trec_seq_code is record
		mode_update : std_logic;
		fsm_select  : std_logic;
		next_emit   : std_logic;
	end record trec_seq_code;

	subtype tslv_seq_code is std_logic_vector(2 downto 0);


	--conversion functions
	pure function seq_code2slv (input_rec : trec_seq_code) return std_logic_vector;
	pure function slv2seq_code (slv       : tslv_seq_code) return trec_seq_code;

end package pk_seq_code;

--------------------------------------------------------    
package body pk_seq_code is
	--conversion functions
		pure function seq_code2slv (input_rec : trec_seq_code) return std_logic_vector is
			begin
				return input_rec.mode_update&input_rec.fsm_select&input_rec.next_emit;
		end function seq_code2slv;

		pure function slv2seq_code (slv : tslv_seq_code) return trec_seq_code is
			variable rec : trec_seq_code;
		begin
			rec.mode_update := slv(2);
			rec.fsm_select  := slv(1);
			rec.next_emit   := slv(0);
			return rec;
		end function slv2seq_code;

end package body pk_seq_code;