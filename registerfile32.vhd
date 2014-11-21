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
		busB : out std_logic_vector(31 downto 0);
		reset: in std_logic
	);
END registerfile32;

ARCHITECTURE struct OF registerfile32 IS
	COMPONENT register32 IS
		PORT(
			inData : in std_logic_vector(31 downto 0);
			clk: in std_logic;
			writeEnable: in std_logic;
			outData : out std_logic_vector(31 downto 0);
			reset: in std_logic
		);
	END COMPONENT register32;
	COMPONENT mux_32_1 IS
	PORT (
		--inputs 
		ctrl:	in std_logic_vector(4 downto 0);
		R_0:	in std_logic_vector(31 downto 0);
		R_1:	in std_logic_vector(31 downto 0);
		R_2:	in std_logic_vector(31 downto 0);
		R_3:	in std_logic_vector(31 downto 0);
		R_4:	in std_logic_vector(31 downto 0);
		R_5:	in std_logic_vector(31 downto 0);
		R_6: 	in std_logic_vector(31 downto 0);
		R_7:	in std_logic_vector(31 downto 0);
		R_8:	in std_logic_vector(31 downto 0);
		R_9:	in std_logic_vector(31 downto 0);
		R_10:	in std_logic_vector(31 downto 0);
		R_11:	in std_logic_vector(31 downto 0);
		R_12:	in std_logic_vector(31 downto 0);
		R_13:	in std_logic_vector(31 downto 0);
		R_14:	in std_logic_vector(31 downto 0);
		R_15:	in std_logic_vector(31 downto 0);
		R_16:	in std_logic_vector(31 downto 0);
		R_17:	in std_logic_vector(31 downto 0);
		R_18:	in std_logic_vector(31 downto 0);
		R_19:	in std_logic_vector(31 downto 0);
		R_20:	in std_logic_vector(31 downto 0);
		R_21:	in std_logic_vector(31 downto 0);
		R_22:	in std_logic_vector(31 downto 0);
		R_23:	in std_logic_vector(31 downto 0);
		R_24:	in std_logic_vector(31 downto 0);
		R_25:	in std_logic_vector(31 downto 0);
		R_26:	in std_logic_vector(31 downto 0);
		R_27:	in std_logic_vector(31 downto 0);
		R_28:	in std_logic_vector(31 downto 0);
		R_29:	in std_logic_vector(31 downto 0);
		R_30:	in std_logic_vector(31 downto 0);
		R_31:	in std_logic_vector(31 downto 0);	
		R	: 	out std_logic_vector(31 downto 0)
	);
	END COMPONENT mux_32_1;
	COMPONENT regSelector IS
		PORT(
		destSelect : in std_logic_vector(4 downto 0);
		we : in std_logic;
		writeEnable : out std_logic_vector(31 downto 0)
		);
	END COMPONENT regSelector;
	SIGNAL regWE : std_logic_vector(31 downto 0):=x"ffffffff";
	TYPE regFile is array (0 to 31) of std_logic_vector(31 downto 0);
	SIGNAL regOutSignal : regFile;

	BEGIN

		genRegister: FOR i in 0 to 31 GENERATE
			mapRegister: register32 PORT MAP (
					inData=>busW,
					clk=>clk,
					writeEnable=>regWE(i),
					outData=> regOutSignal(i),
					reset=>reset
				);
		END GENERATE genRegister;

		getWriteEnable : regSelector PORT MAP(
			destSelect => rd,
			we => writeEnable,
			writeEnable => regWE
		);

		mux1 : mux_32_1 PORT MAP(
			rs,
			regOutSignal(0),regOutSignal(1),regOutSignal(2),regOutSignal(3),
			regOutSignal(4),regOutSignal(5),regOutSignal(6),regOutSignal(7),
			regOutSignal(8),regOutSignal(9),regOutSignal(10),regOutSignal(11),
			regOutSignal(12),regOutSignal(13),regOutSignal(14),regOutSignal(15),
			regOutSignal(16),regOutSignal(17),regOutSignal(18),regOutSignal(19),
			regOutSignal(20),regOutSignal(21),regOutSignal(22),regOutSignal(23),
			regOutSignal(24),regOutSignal(25),regOutSignal(26),regOutSignal(27),
			regOutSignal(28),regOutSignal(29),regOutSignal(30),regOutSignal(31),
			busA
		);

		mux2 : mux_32_1 PORT MAP(
			rt,
			regOutSignal(0),regOutSignal(1),regOutSignal(2),regOutSignal(3),
			regOutSignal(4),regOutSignal(5),regOutSignal(6),regOutSignal(7),
			regOutSignal(8),regOutSignal(9),regOutSignal(10),regOutSignal(11),
			regOutSignal(12),regOutSignal(13),regOutSignal(14),regOutSignal(15),
			regOutSignal(16),regOutSignal(17),regOutSignal(18),regOutSignal(19),
			regOutSignal(20),regOutSignal(21),regOutSignal(22),regOutSignal(23),
			regOutSignal(24),regOutSignal(25),regOutSignal(26),regOutSignal(27),
			regOutSignal(28),regOutSignal(29),regOutSignal(30),regOutSignal(31),
			busB
		);
		

END struct;