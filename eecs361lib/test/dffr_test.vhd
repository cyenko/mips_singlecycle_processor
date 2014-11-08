library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.dffr;

entity dffr_test is
end dffr_test;

architecture behavioral of dffr_test is
signal clk	: std_logic;
signal d	: std_logic;
signal q	: std_logic;
begin
  test_comp : dffr port map (
	clk => clk,
	d   => d,
	q   => q);
  testbench : process
  begin
	clk <= '0';
	d <= '0';
	wait for 5 ns;
	clk <= '1';
	wait for 5 ns;
	assert q = '0' report "first signal" severity error;
	wait for 5 ns;
	clk <= '0';
	d <= '1';
	assert q = '0' report "before second signal" severity error;
	wait for 5 ns;
	clk <= '1';
	wait for 5 ns;
	assert q = '1' report "second signal" severity error;
	wait for 5 ns;
	wait;
  end process;
end behavioral;
