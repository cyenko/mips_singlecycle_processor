library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.cmp_n;

entity cmp_n_test is
end cmp_n_test;

architecture behavioral of cmp_n_test is
signal a : std_logic_vector(3 downto 0);
signal b : std_logic_vector(3 downto 0);
signal c : std_logic_vector(4 downto 0);
begin
  test_comp : cmp_n
    generic map (n => 4)
    port map (
      a => a,
      b => b,
      a_eq_b => c(4),
      a_gt_b => c(3),
      a_lt_b => c(2),
      signed_a_gt_b => c(1),
      signed_a_lt_b => c(0)
    );

  testbench : process
  begin
    a <= "0000";
    b <= "0000";
    wait for 5 ns;
    assert c = "10000" report "cmp 0" severity error;
    wait for 5 ns;
    a <= "0110";
    b <= "1010";
    wait for 5 ns;
    assert c = "00110" report "cmp 1" severity error;
    wait for 5 ns;
    a <= "0111";
    b <= "0110";
    wait for 5 ns;
    assert c = "01010" report "cmp 2" severity error;
    wait for 5 ns;
    a <= "1000";
    b <= "0001";
    wait for 5 ns;
    assert c = "01001" report "cmp 3" severity error;
    wait for 5 ns;
    a <= "1100";
    b <= "1110";
    wait for 5 ns;
    assert c = "00101" report "cmp 4" severity error;
    wait for 5 ns;
    a <= "1110";
    b <= "1110";
    wait for 5 ns;
    assert c = "10000" report "cmp 5" severity error;
    wait for 5 ns;
    wait;
  end process;
end architecture behavioral;
