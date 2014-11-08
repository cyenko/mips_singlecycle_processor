library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.eecs361_gates.all;
use work.eecs361.all;

entity sram_demo is
  port (
    dout : out std_logic_vector(31 downto 0)
  );
end sram_demo;

architecture structural of sram_demo is
signal cs : std_logic;
signal oe : std_logic;
signal we : std_logic;
signal addr : std_logic_vector(31 downto 0);
signal din : std_logic_vector(31 downto 0);
signal ctrl_bus : std_logic_vector(2 downto 0);
begin
  sram_map : sram
    generic map (mem_file => "data/sort_corrected_branch.dat")
    port map (cs => cs, oe => oe, we => we, addr => addr, din => din, dout => dout);
  cs <= ctrl_bus(2);
  oe <= ctrl_bus(1);
  we <= ctrl_bus(0);

  process
    variable vaddr : integer range 0 to 2147483647;
  begin
    ctrl_bus <= "110";
    for vaddr in 4194336 to 4194376 loop
      addr <= std_logic_vector(to_unsigned(vaddr, 32));
      wait for 5 ns;
    end loop;
    wait;
  end process;
end;
