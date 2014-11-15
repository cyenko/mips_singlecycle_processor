library ieee; 
use ieee.std_logic_1164.all; 
use work.eecs361_gates.all;

entity alu_tb is
	port (
		R: out std_logic_vector(31 downto 0);
		zero: out std_logic;
		overflow: out std_logic;
		cout: out std_logic
	);
end ENTITY alu_tb;  

architecture tb_architecture of alu_tb is 
	COMPONENT  alu is
		port(
		-- Inputs
		A:  in  std_logic_vector(31 downto 0);
		B:  in  std_logic_vector(31 downto 0);
		ctrl: in std_logic_vector(3 downto 0);
		-- Outputs
		cout: out std_logic;      --'1' if carry out
		overflow: out std_logic;  --'1' if overflow
		ze: out std_logic;        --'1' if zero
		R:  out std_logic_vector(31 downto 0) -- result
	);
	end COMPONENT  alu;
	
   signal ctrl_tb: std_logic_vector(3 downto 0) :=(others=>'0');  --Initialize all values to 0
   signal a_tb: std_logic_vector(31 downto 0) :=(others=>'0'); 
   signal b_tb: std_logic_vector(31 downto 0) :=(others=>'0'); 
   signal inbus: std_logic_vector(67 downto 0) :=(others=>'0');

begin 

  dut:  alu --instantiate ALU
    port map(
		ctrl =>ctrl_tb,
        A =>a_tb,
		B => b_tb,
        cout =>cout,
        overflow =>overflow,
        ze =>zero,
        R => R
  );
  a_tb <= inbus(63 downto 32);
  b_tb <= inbus(31 downto 0);
  ctrl_tb <= inbus(67 downto 64);
  
  
TESTPROC: process
begin
	--OPCODE
	 -- add - x0 - 0000
	 -- sub - x1 - 0001
	 -- sltu - x2- 0010
	 -- slt - x3 - 0011
	 -- sll - x4 - 0100
	 -- and - x5 - 0101
	 -- or - x6  - 0110
	 -- XXX - x7 - 0111
	 
	--add 1 and 1
	inbus <= x"00000000100000001";
	wait for 5 ns;
	--add xAA and -1 - should give xA9
	inbus <= x"0000000AAFFFFFFFF";
	wait for 5 ns;
	--add for an overflow... x9FFFFFFF + x00000001
	inbus <= x"07FFFFFFF00000001";
	wait for 5 ns;
	-- subtract 2-1
	inbus <= x"10000000200000001";
	wait for 5 ns;
	-- subtract 0-10
	inbus <= x"1000000000000000A";
	wait for 5 ns;
	-- sltu xffffffff - 0 (tricky inputs for sltu). should give 0 b/c unsigned
	inbus <= x"2ffffffff00000000";
	wait for 5 ns;
	-- SLTU 1 and 0 --> should give 0
	inbus <= x"20000000100000000";
	wait for 5 ns;
	-- sltu 1 and 4 --> should give 1
	inbus <= x"20000000100000004";
	wait for 5 ns;
	-- sltu 1 and 4 --> should give 1
	inbus <= x"30000000100000004";
	wait for 5 ns;
	-- slt A and B --> should give 1
	inbus <= x"30000000A0000000B";
	wait for 5 ns;
	-- slt -1 and 1 --> should give 1
	inbus <= x"3FFFFFFFF00000001";
	wait for 5 ns;
	--slt for F0000000 and 1 --> should give 1
	inbus <= x"3F000000000000001";
	wait for 5 ns;
	--slt 8 and 1 --> should give 0
	inbus <= x"30000000800000001";
	wait for 5 ns;
	-- sll 1 by 2 --> should give 0100 or 4
	inbus <= x"40000000100000002";
	wait for 5 ns;
	-- sll 7 by 16 --> should give 7 followed by x0000
	inbus <= x"40000000700000010";
	wait for 5 ns;
	-- sll BEEFBEEF by 16 --> should give BEEF0000 as answer
	inbus <= x"4BEEFBEEF00000010";
	wait for 5 ns;
	-- shift by a very large number (>32) to create all 0s
	inbus <= x"4BEEFBEEF00BEEF00";
	wait for 5 ns;
	-- and ABABABAB with FFFFF --> should give the same number
	inbus <= x"5ABABABABFFFFFFFF";
	wait for 5 ns;
	-- AND FABADBAD with 00BAD050 --> should dive 00BAD000
	inbus <= x"5FABADBAD00BAD050";
	wait for 5 ns;
	-- or DEADBEEF with 0000 --> should give deadbeef
	inbus <= x"6DEADBEEF00000000";
	wait for 5 ns;
	--now or ABCDABAB WITH F0F0F0F0 --> SHOULD GIVE FBFDFBFB 
	inbus <= x"6ABCDABABF0F0F0F0";
	wait for 5 ns;
	wait; --halt process to prevent infinite run
end process TESTPROC;

end architecture tb_architecture; 