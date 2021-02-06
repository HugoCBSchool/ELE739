----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2021 10:12:42 AM
-- Design Name: 
-- Module Name: pk_ila_interface - Behavioral
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
use work.pk_input_interface.all;
use work.pk_seq_code.all;
use work.pk_fsm_control.all;
--------------------------------------------------------------------------------
-- package containing record types for this module
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------
package pk_ila_interface is

    --ila component
    COMPONENT ila_0
        PORT (
            clk : IN STD_LOGIC;
            probe0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
            probe1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
            probe2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
            probe3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
            probe4 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
            probe5 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
            probe6 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
            probe7 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
            probe8 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
            probe9 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
            probe10 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe11 : IN STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT  ;
    
	-- record type used for interpretation of signal vectors
	type trec_busila_top_side is record
                --for input_interface
        hw_in   :   trec_input; -- async
        sync_in :   trec_input; -- synchronized
        in_reset:   trec_input; -- resets
        
        -- for fsm_control
        seq_code: trec_seq_code;
        ctrl_ns: trec_fsm_ctrl;--ns
        ctrl_ew: trec_fsm_ctrl;--ew
        ctrl_ped: trec_fsm_ctrl;--ped

        -- for outputs
        done_slv: std_logic_vector(2 downto 0);--for fsms done signals
        light_ns: std_logic_vector(2 downto 0);--for light ns
        light_ew: std_logic_vector(2 downto 0);--for light ew
        light_ped: std_logic;                   --for light ped
        ped_state: std_logic_vector(2 downto 0);--for ped state
	end record trec_busila_top_side;
    
    
    -- ila side interface
    type trec_busila_ila_side is record
    
        --for input_interface
        probe0: tslv_input; -- async
        probe1: tslv_input; -- synchronized
        probe2: tslv_input; -- resets
        
        -- for fsm_control
        probe3: tslv_seq_code;
        probe4: tslv_fsm_ctrl;--ns
        probe5: tslv_fsm_ctrl;--ew
        probe6: tslv_fsm_ctrl;--ped
        
        -- for outputs
        probe7: std_logic_vector(2 downto 0);--for fsms done signals
        probe8: std_logic_vector(2 downto 0);--for light ns
        probe9: std_logic_vector(2 downto 0);--for light ew
        probe10: std_logic_vector(0 downto 0);                   --for light ped
        probe11: std_logic_vector(2 downto 0);--for ped state
         
    end record trec_busila_ila_side;
   

	--conversion functions
	pure function top2ila (top : trec_busila_top_side) return trec_busila_ila_side;

end package pk_ila_interface;

--------------------------------------------------------    
package body pk_ila_interface is
	--conversion functions
    pure function top2ila (top : trec_busila_top_side) return trec_busila_ila_side is
        variable ila: trec_busila_ila_side;
        variable zerovec:std_logic_vector(1 downto 0);
    begin
                --for input_interface
        ila.probe0:=input2slv(top.hw_in); -- async
        ila.probe1:=input2slv(top.sync_in);
        ila.probe2:=input2slv(top.in_reset);
        
        -- for fsm_control
        ila.probe3:=seq_code2slv(top.seq_code);
        ila.probe4:=fsm_ctrl2slv(top.ctrl_ns);
        ila.probe5:=fsm_ctrl2slv(top.ctrl_ew);
        ila.probe6:=fsm_ctrl2slv(top.ctrl_ped);
        
        -- for outputs
        ila.probe7:=top.done_slv; 
        ila.probe8:=top.light_ns;
        ila.probe9:=top.light_ew;
        ila.probe10(0):=top.light_ped;
        ila.probe11:=top.ped_state;
        return ila;
    end top2ila;

end package body pk_ila_interface;