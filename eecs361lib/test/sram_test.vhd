library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.eecs361.sram;

entity sram_test is
end sram_test;

architecture behavioral of sram_test is
signal cs   : std_logic;
signal oe   : std_logic;
signal we   : std_logic;
signal addr : std_logic_vector(31 downto 0);
signal din  : std_logic_vector(31 downto 0);
signal dout : std_logic_vector(31 downto 0);
begin
  test_comp : sram
    generic map (
      mem_file => "data/bills_branch.dat"
    )
    port map (
      cs => cs,
      oe => oe,
      we => we,
      addr => addr,
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
    addr <= x"1000000c";
    wait for 5 ns;
    assert dout = x"000002bc" report "sram read error" severity error;
    wait for 5 ns;
    -- write
    cs <= '0';
    wait for 5 ns;
    oe <= '0';
    we <= '1';
    addr <= x"1000001c";
    din  <= x"efefefef";
    wait for 5 ns;
    cs <= '1';
    wait for 5 ns;
    we <= '0';
    cs <= '0';
    wait for 5 ns;
    cs <= '1';
    oe <= '1';
    wait for 5 ns;
    assert dout = x"efefefef" report "sram write error" severity error;
    wait for 5 ns;
    wait;
  end process;
end;
