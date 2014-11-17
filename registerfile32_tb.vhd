library ieee;
use ieee.std_logic_1164.all;

entity registerfile32_tb is
	--Empty declaration for test bech
END registerfile32_tb;

ARCHITECTURE struct OF registerfile32_tb IS
    COMPONENT registerfile32 IS
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
	END COMPONENT registerfile32;
--The test signals
signal rd_tb : std_logic_vector(4 downto 0);
signal rs_tb : std_logic_vector(4 downto 0);
signal rt_tb : std_logic_vector(4 downto 0);
signal busW_tb : std_logic_vector(31 downto 0);

signal we_tb : std_logic; --Write enable testbench value
signal clk_tb : std_logic;

--The output test signals
signal busA_tb : std_logic_vector(31 downto 0);
signal busB_tb : std_logic_vector(31 downto 0);

BEGIN
    registerfile32_map : registerfile32 port map (
		rd=>rd_tb,
		rs=>rs_tb,
		rt=>rt_tb,
		busW=>busW_tb,
		clk=>clk_tb,
		writeEnable=>we_tb,
		busA=>busA_tb,
		busB=>busB_tb);

    test_proc : PROCESS
    BEGIN
    	--BEGIN BASE TESTS
    	--Try writing to the first register the value 1h
    	--PASSED
        clk_tb <= '0';
        busW_tb <= "00000000000000000000000000000001";
        rd_tb <= "00000";
		we_tb <='1';
		wait for 5 ns; 
		clk_tb <= '1';
		wait for 5 ns;
		clk_tb <= '0';
		--Try changing the first registers value to 5h
		--PASSED
		wait for 5 ns;
		busW_tb <= "00000000000000000000000000000101";
		clk_tb <= '1';
		wait for 5 ns;
		clk_tb <= '0';
		wait for 5 ns;
		--Write the third registers value to Fh
		--PASSED
		wait for 5 ns;
		rd_tb <= "00011";
		busW_tb <= "00000000000000000000000000001111";
		clk_tb <= '1';
		wait for 5 ns;
		clk_tb <= '0';
		wait for 5 ns;
		--Read the first and third register values, should be 5h and Fh
		--PASSED
		wait for 5 ns;
		we_tb <= '0';
		rs_tb <= "00000";
		rt_tb <= "00011";
		clk_tb <= '1';
		wait for 5 ns;
		clk_tb <= '0';
		wait for 5 ns;
		

        wait;
   END PROCESS;
  END ARCHITECTURE struct;
    