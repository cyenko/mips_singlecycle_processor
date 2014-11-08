use work.eecs361_gates.all;

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
			outData : out std_logic_vector(31 downto 0);
		);
	END register32;
	COMPONENT regSelector IS
		PORT(
		destSelect : in std_logic_vector(4 downto 0);
		we : in std_logic;
		writeEnable : out std_logic_vector(31 downto 0)
	);

	SIGNAL regWE : std_logic_vector(31 downto 0);
	TYPE regFile is array (0 to 31) of std_logic_vector(31 downto 0);
	SIGNAL regOutSignal : regFile;

	BEGIN

		genRegister: FOR i in 0 to 31 GENERATE
			mapRegister: register32 PORT MAP (
					inData=>busW,
					clk=>clk,
					writeEnable=>regWE(i),
					outData=> regOutSignal(i);
				);
		END GENERATE genRegister;

		getWriteEnable : regSelector PORT MAP(
			destSelect => rd,
			we => writeEnable,
			writeEnable => regWE
		)

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
		)

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
		)

		

END struct;