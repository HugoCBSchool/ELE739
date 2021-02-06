--! ddd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
--! Package containing record types for the module FSM_CONTROL
--------------------------------------------------------------------------------
--! Package containing record types for the module FSM_CONTROL
package pk_FSM_CONTROL is
	type trec_fsm_ctrl is record
		nxt   : std_logic;
		step  : std_logic;
		maint : std_logic;
	end record trec_fsm_ctrl; --! type
	
	subtype tslv_fsm_ctrl is std_logic_vector(2 downto 0);


	--conversion functions
	pure function fsm_ctrl2slv (ctrl_rec : trec_fsm_ctrl)return std_logic_vector;
	pure function slv2fsm_ctrl (slv : tslv_fsm_ctrl)     return trec_fsm_ctrl;

end package pk_FSM_CONTROL;
--------------------------------------------------------------------------------
package body pk_FSM_CONTROL is

	--conversion functions
	pure function fsm_ctrl2slv (ctrl_rec : trec_fsm_ctrl) return std_logic_vector is
	begin
		return ctrl_rec.nxt&ctrl_rec.step&ctrl_rec.maint;
	end function fsm_ctrl2slv;

	pure function slv2fsm_ctrl (slv : tslv_fsm_ctrl)
		return trec_fsm_ctrl is
		variable rec : trec_fsm_ctrl;
	begin
		rec.nxt   := slv(2);
		rec.step  := slv(1);
		rec.maint := slv(0);
		return rec;
	end function slv2fsm_ctrl;

end package body pk_FSM_CONTROL;
--------------------------------------------------------------------------------