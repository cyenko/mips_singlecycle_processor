library ieee;
use work.eecs361_gates.all;
 use ieee.std_logic_1164.all;


ENTITY registerfile32 IS
	PORT(
		rd : in std_logic_vector(4 downto 0);
		rs : in std_logic_vector(4 downto 0);
		rt : in std_logic_vector(4 downto 0);
		busW : in std_logic_vector(31 downto 0);
		clk : in std_logic;
		writeEnable : in std_logic;

		busA: out std_logic_vector(31 downto 0);
		busB : out std_logic_vector(31 downto 0)
	);
END registerfile32;

ARCHITECTURE struct OF registerfile32 IS
	COMPONENT register32 IS
		PORT(
			inData : in std_logic_vector(31 downto 0);
			clk: in std_logic;
			writeEnable: in std_logic;
			outData : out std_logic_vector(31 downto 0)
		);
	END COMPONENT register32;
	COMPONENT mux_32_1 IS
		PORT(
			selection: IN std_logic_vector(4 downto 0);
			c0: IN std_logic; 
			c1: IN std_logic;
			c2: IN std_logic;
			c3: IN std_logic;
			c4: IN std_logic;
			c5: IN std_logic;
			c6: IN std_logic;
			c7: IN std_logic;
			c8: IN std_logic;
			c9: IN std_logic;
			c10: IN std_logic;
			c11: IN std_logic;
			c12: IN std_logic;
			c13: IN std_logic;
			c14: IN std_logic;
			c15: IN std_logic;
			c16: IN std_logic;
			c17: IN std_logic;
			c18: IN std_logic;
			c19: IN std_logic;
			c20: IN std_logic;
			c21: IN std_logic;
			c22: IN std_logic;
			c23: IN std_logic;
			c24: IN std_logic;
			c25: IN std_logic;
			c26: IN std_logic;
			c27: IN std_logic;
			c28: IN std_logic;
			c29: IN std_logic;
			c30: IN std_logic;
			c31: IN std_logic;
			result: OUT std_logic
			);
	END COMPONENT mux_32_1;
	COMPONENT regSelector IS
		PORT(
		destSelect : in std_logic_vector(4 downto 0);
		we : in std_logic;
		writeEnable : out std_logic_vector(31 downto 0)
		);
	END COMPONENT regSelector;
	SIGNAL regWE : std_logic_vector(31 downto 0);
	TYPE regFile is array (0 to 31) of std_logic_vector(31 downto 0);
	SIGNAL regOutSignal : regFile;

	BEGIN

		genRegister: FOR i in 0 to 31 GENERATE
			mapRegister: register32 PORT MAP (
					inData=>busW,
					clk=>clk,
					writeEnable=>regWE(i),
					outData=> regOutSignal(i)
				);
		END GENERATE genRegister;

		getWriteEnable : regSelector PORT MAP(
			destSelect => rd,
			we => writeEnable,
			writeEnable => regWE
		);

		mux1 : mux_32_1 PORT MAP(
			rs,
			regOutSignal(0),
			regOutSignal(1),
			regOutSignal(2),
			regOutSignal(3),
			regOutSignal(4),
			regOutSignal(5),
			regOutSignal(6),
			regOutSignal(7),
			regOutSignal(8),
			regOutSignal(9),
			regOutSignal(10),
			regOutSignal(11),
			regOutSignal(12),
			regOutSignal(13),
			regOutSignal(14),
			regOutSignal(15),
			regOutSignal(16),
			regOutSignal(17),
			regOutSignal(18),
			regOutSignal(19),
			regOutSignal(20),
			regOutSignal(21),
			regOutSignal(22),
			regOutSignal(23),
			regOutSignal(24),
			regOutSignal(25),
			regOutSignal(26),
			regOutSignal(27),
			regOutSignal(28),
			regOutSignal(29),
			regOutSignal(30),
			regOutSignal(31),
			busA
		);

		mux2 : mux_32_1 PORT MAP(
			rt,
			regOutSignal(0),
			regOutSignal(1),
			regOutSignal(2),
			regOutSignal(3),
			regOutSignal(4),
			regOutSignal(5),
			regOutSignal(6),
			regOutSignal(7),
			regOutSignal(8),
			regOutSignal(9),
			regOutSignal(10),
			regOutSignal(11),
			regOutSignal(12),
			regOutSignal(13),
			regOutSignal(14),
			regOutSignal(15),
			regOutSignal(16),
			regOutSignal(17),
			regOutSignal(18),
			regOutSignal(19),
			regOutSignal(20),
			regOutSignal(21),
			regOutSignal(22),
			regOutSignal(23),
			regOutSignal(24),
			regOutSignal(25),
			regOutSignal(26),
			regOutSignal(27),
			regOutSignal(28),
			regOutSignal(29),
			regOutSignal(30),
			regOutSignal(31),
			busB
		);

		

END struct;