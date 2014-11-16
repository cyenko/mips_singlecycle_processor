LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.eecs361_gates.all;

ENTITY bitSubtractor_32 IS 
	PORT(
		a,b: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		result: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		overflow: OUT STD_LOGIC;
		cout: OUT STD_LOGIC
	);
END bitSubtractor_32;

ARCHITECTURE struct OF bitSubtractor_32 IS
	COMPONENT bitAdder_32 IS
	  port (
	    x,y   : in  std_logic_vector(31 downto 0);
	    carry : in std_logic;
	    resultVector   : out std_logic_vector(31 downto 0);
	    overflow : out std_logic;
	    cout : out std_logic
	  );
	END COMPONENT bitAdder_32;

	SIGNAL ynot : std_logic_vector(31 downto 0);
	BEGIN
		--We add the inverted B to a
		noty: not_gate_32 PORT MAP (b,ynot);
		subtraction: bitAdder_32 PORT MAP (a,ynot,'1',result,overflow,cout); --carry in of 1 to add 1 (2c)
		
END struct;