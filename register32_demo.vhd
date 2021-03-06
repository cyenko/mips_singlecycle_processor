library ieee;
use ieee.std_logic_1164.all;

entity register32_demo is
    port (
        z   : out std_logic_vector(31 downto 0)
    );
END register32_demo;

ARCHITECTURE struct OF register32_demo IS
    COMPONENT register32 IS
       PORT(
		inData : in std_logic_vector(31 downto 0);
		clk: in std_logic;
		writeEnable: in std_logic;
		outData : out std_logic_vector(31 downto 0)
	);
	END COMPONENT register32;

signal input : std_logic_vector(31 downto 0);
signal we_tb : std_logic;
signal clk_tb : std_logic;
--signal inbus: std_logic_vector(35 downto 0);

BEGIN
    reg32_map : register32 port map (
		inData=>input,
		writeEnable=>we_tb,
		clk=>clk_tb,
		outData=>z);
    --clk_tb <= inbus(33);
    --we_tb <= inbus(32);
    --input <= inbus(31 downto 0);
    
    test_proc : PROCESS
    BEGIN
        clk_tb <= '0';
		we_tb <='0';
		input <= x"00000000";
		wait for 5 ns;
		clk_tb <= '1';
		wait for 5 ns;
		we_tb <= '1';
		input <= x"0000000A";
		wait for 5 ns;
		clk_tb <= '0';
		wait for 5 ns;
		clk_tb <= '1';
		wait for 5 ns;
		we_tb <= '1';
		input <= x"000000B0";
		wait for 5 ns;
		clk_tb <= '0';
		wait for 5 ns;
		we_tb <='0';
		input <= x"FFFFFFFF";
		wait for 5 ns;
		clk_tb <= '1';
		wait for 5 ns;
		we_tb <='1';
		wait for 5 ns;
		clk_tb <= '0';
        wait;
   END PROCESS;
  END ARCHITECTURE struct;
    