library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
-- package containing record types for this module
--------------------------------------------------------------------------------
package pk_INPUT_INTERFACE is

    -- record type used for interpretation of signal vectors
    type trec_input is record
        ped   : std_logic;
        nxt   : std_logic;
        step  : std_logic;
        maint : std_logic;
    end record trec_input;

    subtype tslv_input is std_logic_vector(3 downto 0);


    --conversion functions
    pure function input2slv (input_rec : trec_input) return std_logic_vector;
    pure function slv2input (slv       : tslv_input) return trec_input ;

end package pk_INPUT_INTERFACE;
--------------------------------------------------------    
package body pk_INPUT_INTERFACE is

    --conversion functions
    pure function input2slv (input_rec : trec_input) return std_logic_vector is
    begin
        return input_rec.ped&input_rec.nxt&input_rec.step&input_rec.maint;
    end function input2slv;

    pure function slv2input (slv: tslv_input) return trec_input is
        variable rec : trec_input;
    begin
        rec.ped   := slv(3);
        rec.nxt   := slv(2);
        rec.step  := slv(1);
        rec.maint := slv(0);
        return rec;
    end function slv2input;

end package body pk_INPUT_INTERFACE;
--------------------------------------------------------------------------------
