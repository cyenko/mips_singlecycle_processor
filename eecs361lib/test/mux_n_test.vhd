library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.mux_n;

entity mux_n_test is
end mux_n_test;

architecture behavioral of mux_n_test is
signal sel	: std_logic;
signal src0 : std_logic_vector(3 downto 0);
signal src1 : std_logic_vector(3 downto 0);
signal z    : std_logic_vector(3 downto 0);
begin
  test_comp : mux_n
	generic map (n => 4)
	port map (
	  sel  => sel,
	  src0 => src0,
	  src1 => src1,
	  z	  => z
	);
  testbench : process
  begin
	sel <= '0';
	src0 <= "1010";
	src1 <= "1001";
	wait for 5 ns;
	assert z = "1010" report "select 0" severity error;
	wait for 5 ns;
	sel <= '1';
	wait for 5 ns;
	assert z = "1001" report "select 1" severity error;
	wait for 5 ns;
	src1 <= "1101";
	wait for 5 ns;
	assert z = "1101" report "src1 change" severity error;
	wait for 5 ns;
	wait;
  end process;
end behavioral;
