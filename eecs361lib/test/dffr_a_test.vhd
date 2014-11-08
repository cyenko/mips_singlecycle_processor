library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.dffr_a;

entity dffr_a_test is
end dffr_a_test;

architecture behavioral of dffr_a_test is
signal clk	: std_logic;
signal d	: std_logic;
signal q	: std_logic;
signal aload : std_logic;
signal arst : std_logic;
signal adata : std_logic;
signal enable : std_logic;
begin
  test_comp : dffr_a port map (
	clk => clk,
    arst => arst,
    aload => aload,
    adata => adata,
    enable => enable,
	d   => d,
	q   => q);
  testbench : process
  begin
	clk <= '0';
	d <= '0';
    enable <= '1';
    aload <= '0';
    arst <= '0';
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
    clk <= '0';
    d <= '0';
    enable <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
    assert q = '1' report "enable disabled" severity error;
    wait for 5 ns;
    arst <= '1';
    adata <= '1';
    aload <= '1';
    wait for 5 ns;
    assert q = '0' report "arst working" severity error;
    wait for 5 ns;
    arst <= '0';
    wait for 5 ns;
    assert q = '1' report "aload working" severity error;
	wait;
  end process;
end behavioral;
