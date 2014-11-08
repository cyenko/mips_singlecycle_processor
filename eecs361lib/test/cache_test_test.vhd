library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.eecs361.cache_test;
use work.eecs361.sram;

entity cache_test_test is
  port (
    clko : out std_logic;
    err : out std_logic;
    addr : out std_logic_vector(31 downto 0);
    data : out std_logic_vector(31 downto 0);
    wr : out std_logic
  );
end cache_test_test;

architecture mix of cache_test_test is
signal clk : std_logic := '0';
signal tmpData : std_logic_vector(31 downto 0);
signal idx : std_logic_vector(31 downto 0);
signal rst : std_logic;
begin
  clk <= not clk after 5 ns;

  clko <= clk;

  rst <= '1', '0' after 2 ns;

  idx_proc : process(clk, rst)
  begin
    if rst = '1' then
      idx <= (others => '0');
    elsif rising_edge(clk) then
      idx <= std_logic_vector(unsigned(idx) + 4);
    end if;
  end process;

  sram_map : sram
    generic map (
      mem_file => "data/mem_init"
    )
    port map (
      cs => '1',
      oe => '1',
      we => '0',
      addr => idx,
      din => (others => '0'),
      dout => tmpData
    );

  cache_map : cache_test
    generic map (
      data_trace_file => "data/random_data_trace",
      addr_trace_file => "data/random_addr_trace"
    )
    port map (
      DataIn => tmpData,
      clk => clk,
      ready => '1',
      rst => rst,
      Addr => addr,
      Data => data,
      WR => wr,
      Err => err
    );

  process
  begin
    wait for 100 ns;
    wait;
  end process;
end mix;
