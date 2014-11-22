library ieee;
use ieee.std_logic_1164.all;

entity tb_sortCorrectedBranch is
	--Empty declaration for test bech
END tb_sortCorrectedBranch;

ARCHITECTURE struct OF tb_sortCorrectedBranch IS
    COMPONENT mips_single_cycle IS
 	GENERIC (
		mem_file : string
	  );
	PORT(
		clk: 	in std_logic;
		reset:	in std_logic;
		pcOut:	out std_logic_vector(31 downto 0);	
		busWout:	out std_logic_vector(31 downto 0)
	);
	END COMPONENT mips_single_cycle;
--The test signals
signal clk_tb : std_logic := '0';
signal reset_tb : std_logic := '0';
signal pcOut_tb : std_logic_vector(31 downto 0);
signal busWout_tb : std_logic_vector(31 downto 0);

BEGIN
	processor_map: mips_single_cycle
	generic map(mem_file => "sort_corrected_branch.dat")
	port map (
		clk => clk_tb,
		reset => reset_tb,
		pcOut => pcOut_tb,
		busWout => busWout_tb);

    test_proc : PROCESS
    BEGIN
    	--Trigger the reset
    	reset_tb <= '0';

    	wait for 50 ns;
    	reset_tb <= '1';
    	clk_tb <= '1';
    	wait for 50 ns;
    	reset_tb <= '0';
    	clk_tb <= '0';
    	--Start the processor
    	for i in 1 to 1500 loop
    		clk_tb <= not clk_tb;
    		wait for 50 ns;
    	end loop;
        wait;
   END PROCESS;
  END ARCHITECTURE struct;
    