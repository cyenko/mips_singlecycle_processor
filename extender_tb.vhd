library ieee;
use ieee.std_logic_1164.all;

entity extender_tb is
	--Empty declaration for test bech
END extender_tb;

ARCHITECTURE struct OF extender_tb IS
    COMPONENT extender IS
	PORT(
		imm16:	in std_logic_vector(15 downto 0);
		ExtOp:	in std_logic;
		R	 :	out std_logic_vector(31 downto 0)
	);
	END COMPONENT extender;
--The test signals
signal imm16_tb : std_logic_vector(15 downto 0);
signal ExtOp_tb : std_logic;
signal R_tb : std_logic_vector(31 downto 0);


BEGIN
    extender_map : extender port map (
		imm16=>imm16_tb,
		ExtOp=>ExtOp_tb,
		R=>R_tb);

    test_proc : PROCESS
    BEGIN
    	--BEGIN BASE TESTS
    	--Try all zeros, 0 extension
    	--PASSED
        imm16_tb <= "0000000000000000";
        ExtOp_tb<='0';
		wait for 5 ns; 
		--Try all ones, 0 extension
		--PASSED
        imm16_tb <= "1111111111111111";
        ExtOp_tb<='0';
		wait for 5 ns; 
		--Try some ones, 0 extension
		--PASSED
        imm16_tb <= "0000000000110011";
        ExtOp_tb<='0';
		wait for 5 ns; 
    	--Try all zeros, sign extension
    	--PASSED
        imm16_tb <= "0000000000000000";
        ExtOp_tb<='1';
		wait for 5 ns; 
		--Try all ones, sign extension
		--PASSED
        imm16_tb <= "1111111111111111";
        ExtOp_tb<='1';
		wait for 5 ns; 
		--Try some ones, sign extension
		--PASSED
        imm16_tb <= "1000000000110011";
        ExtOp_tb<='1';
		wait for 5 ns; 
        wait;
   END PROCESS;
  END ARCHITECTURE struct;
    