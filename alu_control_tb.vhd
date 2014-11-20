library ieee;
use ieee.std_logic_1164.all;

entity alu_control_tb is
	--Empty declaration for test bech
END alu_control_tb;

ARCHITECTURE struct OF alu_control_tb IS
    COMPONENT alu_control IS
	PORT (
		ALUOp  : in std_logic_vector(1 downto 0);
		func   : in std_logic_vector(5 downto 0);
		ALUCtrl : out std_logic_vector(3 downto 0)
	);
	END COMPONENT alu_control;
--The test signals
signal aluop_tb : std_logic_vector(1 downto 0);
signal func_tb : std_logic_vector(5 downto 0);
signal aluctrl_tb : std_logic_vector(3 downto 0);


BEGIN
	alucontrol_map: alu_control port map (
		ALUOp => aluop_tb,
		func => func_tb,
		ALUCtrl => aluctrl_tb);

    test_proc : PROCESS
    BEGIN
    	--BEGIN BASE TESTS
    	--load/store, aluop=00
    	--regardless of func, output should be 000
        aluop_tb <= "00";
        func_tb<="000000";
		wait for 5 ns; 
		func_tb<="110101";
		wait for 5 ns;

		--branch, aluop=01
		--regardless of func, output should be 001
        aluop_tb <= "01";
		func_tb<="110101";
		wait for 5 ns;
		func_tb<="000000";
		wait for 5 ns;		
		func_tb<="101000";
		wait for 5 ns;

		--R-type, output is func dependent

		--add, output=000
        aluop_tb <= "10";
		func_tb<="100000";
		wait for 5 ns;

		--subtract, output=001
		func_tb<="100010";
		wait for 5 ns;

		--AND, output=010
		func_tb<="100100";
		wait for 5 ns;

		--OR, output=011
		func_tb<="100101";
		wait for 5 ns;

		--slt, output=101
		func_tb<="101010";
		wait for 5 ns;

		--sltu, output=110
		func_tb<="101011";
		wait for 5 ns;

		--sll, output=100
		func_tb<="000000";
		wait for 5 ns;

		--addu, output=000
		func_tb<="100001";
		wait for 5 ns;

		--subu, output=000
		func_tb<="100011";
		wait for 5 ns;

		--addi, output=000
        aluop_tb <= "11";
		wait for 5 ns;
        wait;
   END PROCESS;
  END ARCHITECTURE struct;
    