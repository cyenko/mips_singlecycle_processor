library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.dec_n;

entity dec_n_test is
end dec_n_test;

architecture behavioral of dec_n_test is
signal src : std_logic_vector(1 downto 0);
signal z   : std_logic_vector(3 downto 0);
begin
  test_comp : dec_n
	generic map (n => 2)
	port map (
	  src => src,
	  z	  => z
	);
  testbench : process
  begin
	src <= "00";
	wait for 5 ns;
	assert z = "0001" report "select 00" severity error;
	wait for 5 ns;
	src <= "01";
	wait for 5 ns;
	assert z = "0010" report "select 01" severity error;
	wait for 5 ns;
	src <= "10";
	wait for 5 ns;
	assert z = "0100" report "select 10" severity error;
	wait for 5 ns;
	src <= "11";
	wait for 5 ns;
	assert z = "1000" report "select 11" severity error;
	wait for 5 ns;
	wait;
  end process;
end behavioral;
