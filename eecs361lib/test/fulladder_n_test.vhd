library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.fulladder_n;

entity fulladder_n_test is
end fulladder_n_test;

architecture behavioral of fulladder_n_test is
signal cin : std_logic;
signal x : std_logic_vector(3 downto 0);
signal y : std_logic_vector(3 downto 0);
signal cout : std_logic;
signal z : std_logic_vector(3 downto 0);
begin
  test_comp : fulladder_n
    generic map (n => 4)
    port map (
      cin => cin,
      x => x,
      y => y,
      cout => cout,
      z => z);
  testbench : process
  begin
    cin <= '0';
    x <= "0100";
    y <= "0111";
    wait for 5 ns;
    assert z = "1011" report "z" severity error;
    assert cout = '0' report "cout" severity error;
    wait for 5 ns;
    cin <= '0';
    x <= "0100";
    y <= "1111";
    wait for 5 ns;
    assert z = "0011" report "z" severity error;
    assert cout = '1' report "cout" severity error;
    wait for 5 ns;
    cin <= '1';
    x <= "0100";
    y <= "0101";
    wait for 5 ns;
    assert z = "1010" report "z" severity error;
    assert cout = '0' report "cout" severity error;
    wait for 5 ns;
    cin <= '1';
    x <= "0010";
    y <= "1101";
    wait for 5 ns;
    assert z = "0000" report "z" severity error;
    assert cout = '1' report "cout" severity error;
    wait for 5 ns;
    wait;
  end process;
end behavioral;
