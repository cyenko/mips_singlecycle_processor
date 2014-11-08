library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.eecs361.csram;

entity csram_test is
end csram_test;

architecture behavioral of csram_test is
signal cs   : std_logic;
signal oe   : std_logic;
signal we   : std_logic;
signal addr : std_logic_vector(1 downto 0);
signal din  : std_logic_vector(2 downto 0);
signal dout : std_logic_vector(2 downto 0);
begin
  test_comp : csram
    generic map (
      INDEX_WIDTH => 2,
      BIT_WIDTH => 3
    )
    port map (
      cs => cs,
      oe => oe,
      we => we,
      index => addr,
      din => din,
      dout => dout
    );
  testbench : process
  begin
    cs <= '0';
    wait for 5 ns;
    -- read
    cs <= '1';
    oe <= '1';
    we <= '0';
    addr <= "01";
    wait for 5 ns;
    assert dout = "000" report "csram read error" severity error;
    wait for 5 ns;
    -- write
    cs <= '0';
    wait for 5 ns;
    oe <= '0';
    we <= '1';
    addr <= "10";
    din  <= "011";
    wait for 5 ns;
    cs <= '1';
    wait for 5 ns;
    we <= '0';
    cs <= '0';
    wait for 5 ns;
    cs <= '1';
    oe <= '1';
    wait for 5 ns;
    assert dout = "011" report "csram write error" severity error;
    wait for 5 ns;
    wait;
  end process;
end;
