library ieee;
use ieee.std_logic_1164.all;

entity mips_singlecycle_tb is
	--Empty declaration for test bech
END mips_singlecycle_tb;

ARCHITECTURE struct OF mips_singlecycle_tb IS
    COMPONENT mips_singlecycle IS
	GENERIC (
		mem_file : string
	  );
	PORT(
		clk: 	in std_logic;
		pcOut:	out std_logic_vector(31 downto 0);
		busWout:	out std_logic_vector(31 downto 0)
	);
	END COMPONENT mips_singlecycle;
--The test signals
signal clk_tb : std_logic := '0';
signal pcOut_tb : std_logic_vector(31 downto 0);
signal busWout_tb : std_logic_vector(31 downto 0);

BEGIN
	processor_map: mips_singlecycle
	generic map(mem_file => "sort_corrected_branch.dat")
	port map (
		clk => clk_tb,
		pcOut => pcOut_tb,
		busWout => busWout_tb);

    test_proc : PROCESS
    BEGIN
    	clk <= not clk after 50 ns;
        wait;
   END PROCESS;
  END ARCHITECTURE struct;
    