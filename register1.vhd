use work.eecs361_gates.all;

ENTITY register1 IS
	PORT(
		inData : in std_logic;
		clk: in std_logic;
		writeEnable: in std_logic;
		outData : out std_logic;
	);
END register1;

ARCHITECTURE struct OF register1 IS
	--Using component dff
	SIGNAL keepOut : std_logic :='0';
	SIGNAL outMux : std_logic;
	BEGIN
		enableCheck: mux PORT MAP(sel=>writeEnable,src0=>keepOut,src1=>inData,z=>outMux);

		flipflop: dff PORT MAP (clk=>clk,d=>outMux,q=>keepOut);
		outData <= keepOut;
END struct;
