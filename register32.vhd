use work.eecs361_gates.all;
library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;
ENTITY register32 IS
	PORT(
		inData : in std_logic_vector(31 downto 0);
		clk: in std_logic;
		writeEnable: in std_logic;
		outData : out std_logic_vector(31 downto 0)
	);
END register32;

ARCHITECTURE struct OF register32 IS
	COMPONENT register1 IS
		PORT(
		inData : in std_logic;
		clk: in std_logic;
		writeEnable: in std_logic;
		outData : out std_logic
		);
	END COMPONENT register1;

	SIGNAL keepOut : std_logic_vector(31 downto 0);

	BEGIN

		genRegister: FOR i in 0 to 31 GENERATE
			mapRegister: register1 PORT MAP (
					inData=>inData(i),
					clk=>clk,
					writeEnable=>writeEnable,
					outData=>outData(i)
				);
		END GENERATE genRegister;

		
END struct;
