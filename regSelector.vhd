use work.eecs361_gates.all;

ENTITY regSelector IS
	PORT(
		destSelect : in std_logic_vector(4 downto 0);
		we : in std_logic;
		writeEnable : out std_logic_vector(31 downto 0)

	);
end regSelector;

ARCHITECTURE struct of regSelector IS
	SIGNAL decOut : std_logic_vector(31 downto 0);

	COMPONENT dec_n IS
		PORT(
			src : in std_logic_vector(n-1 downto 0);
			z   : out std_logic_vector((2**n) - 1 downto 0);
		)
	END dec_n;

BEGIN
	dec1: dec_n
		generic map (n => 5)
		port map (
			src => destSelect,
			z => decOut;
		)
	genAnd: FOR i in 0 to 31 GENERATE
			and1: and_gate PORT MAP (
					x => decOut(i),
					y => we,
					z => writeEnable(i)
				);
	END GENERATE genAnd;

end struct;
