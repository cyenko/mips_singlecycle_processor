library ieee;
use ieee.std_logic_1164.all;

entity pc_logic_tb is
	--Empty declaration for test bech
END pc_logic_tb;

ARCHITECTURE struct OF pc_logic_tb IS
    COMPONENT pc_logic IS
	generic (
		mem_file : string
	);
	PORT (
		imm16 : in std_logic_vector(15 downto 0);
		clk : in std_logic;
		nPC_sel : in std_logic;
		Instruction : out std_logic_vector(31 downto 0)
	);
	END COMPONENT pc_logic;
--The test signals
signal imm16_tb : std_logic_vector(15 downto 0);
signal clk_tb : std_logic;
signal npc_sel_tb : in std_logic;
signal instruction_tb : std_logic_vector(31 downto 0);



BEGIN
	pclogic_map: pc_logic 
	generic map(mem_file => "sort_corrected_branch.dat")
	port map (
		
		imm16 => imm16_tb,
		clk => clk_tb,
		nPC_sel => npc_sel_tb,
		Instruction => instruction_tb);


    test_proc : PROCESS
    BEGIN
    	--No Branch, nPC_sel = 0
    	--Expected pc+4, where pc = pcresult
    	clk_tb <= '0';
    	npc_sel_tb <= '0';
    	imm16 <= "0000000000000000";

		wait for 5 ns;
		clk_tb <= '1';
		wait for 5 ns;
		clk_tb <= '0';
		wait for 5 ns;

		--Branch, nPC_sel = 1
		--Expected currentpc + 4 + imm16
    	npc_sel_tb <= '1';
    	imm16 <= "0000000000000010";

		wait for 5 ns;
		clk_tb <= '1';
		wait for 5 ns;
		clk_tb <= '0';
		wait for 5 ns;

        wait;
   END PROCESS;
  END ARCHITECTURE struct;
    