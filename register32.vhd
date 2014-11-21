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
		outData : out std_logic_vector(31 downto 0);
		reset: in std_logic
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
	SIGNAL zeros: std_logic_vector(31 downto 0):=(others=>'0');
	SIGNAL we_in: std_logic;
	SIGNAL data_in: std_logic_vector(31 downto 0);

	BEGIN
		
		startup_m0: mux PORT MAP (sel=>reset,src0=>writeEnable, src1=>'1', z=>we_in);
		startup_m1: mux_32 PORT MAP (sel=>reset, src0=>inData,src1=>zeros,z=>data_in);
		
		genRegister: FOR i in 0 to 31 GENERATE
			mapRegister: register1 PORT MAP (
					inData=>data_in(i),
					clk=>clk,
					writeEnable=>we_in,
					outData=>outData(i)
				);
		END GENERATE genRegister;

		
END struct;
