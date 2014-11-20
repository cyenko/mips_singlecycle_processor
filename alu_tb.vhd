library ieee; 
use ieee.std_logic_1164.all; 

entity alu_tb is
--Empty entity declaration for test bench.
end alu_tb;  

architecture tb_architecture of alu_tb is 

   signal ctrl_tb: std_logic_vector(3 downto 0) :="0000";  --Initialize all values to 0
   signal a_tb: std_logic_vector(31 downto 0) :="00000000000000000000000000000000"; 
   signal b_tb: std_logic_vector(31 downto 0) :="00000000000000000000000000000000"; 
   signal cout_tb: std_logic  :='0'; 
   signal ovf_tb: std_logic; 
   signal ze_tb : std_logic := '0';
   signal R_tb : std_logic_vector(31 downto 0);
   
   component alu is 
	  port (
	    ctrl  : in std_logic_vector(3 downto 0);
	    A     : in std_logic_vector(31 downto 0);
	    B     : in std_logic_vector(31 downto 0);
	    cout  : out std_logic;  -- ‘1’ -> carry out
	    ovf    : out std_logic;  -- ‘1’ -> overflow
	    ze    : out std_logic;  -- ‘1’ -> is zero
	    R     : out std_logic_vector(31 downto 0) -- result
	  );
   end component; 

begin 

  dut:  alu --instantiate full adder
    port map(
        ctrl =>ctrl_tb,
        A =>a_tb,
		B => b_tb,
        cout =>cout_tb,
        ovf =>ovf_tb,
        ze =>ze_tb,
        R => R_tb
  );
  
  
TESTPROC: process is
begin
	-- Mode 000: Addition, PASSED
	a_tb <= "00000000000000000000000000000001"; 
	b_tb <= "00000000000000000000000000000000";
	ctrl_tb <= "0000";
	wait for 10 ns; 

	a_tb <= "00000000000000000000000000000001"; 
	b_tb <= "00000000000000000000000000000001";
	ctrl_tb <= "0000";
	wait for 10 ns; 

	a_tb <= "00000000000000000000000000000010";
	wait for 10 ns; 

	a_tb <= "11111111111111111111111111111111"; 
	b_tb <= "00000000000000000000000000000001";
	wait for 10 ns; 

	-- Mode 001 SUB, PASSED
	a_tb <= "00000000000000000000000000000011"; 
	b_tb <= "00000000000000000000000000000001";
	ctrl_tb <= "0001";
	wait for 10 ns; 

	a_tb <= "00000000000000000000000000000010"; 
	b_tb <= "00000000000000000000000000000001";
	wait for 10 ns; 

	a_tb <= "00000000000000000000000000000000"; 
	b_tb <= "00000000000000000000000000000001";
	wait for 10 ns; 

	-- Mode 010 AND (Bitwise), PASSED
	a_tb <= "00000000000000000000000000000010"; 
	b_tb <= "00000000000000000000000000000101";
	ctrl_tb <= "0010";
	wait for 10 ns; 

	a_tb <= "00000000000000000000000000000010"; 
	b_tb <= "00000000000000000000000000000111";
	wait for 10 ns; 

	a_tb <= "11111111111111111111111111111111"; 
	b_tb <= "00000000000000000000000000000000";
	wait for 10 ns; 

	a_tb <= "11111111111111111111111111111111"; 
	b_tb <= "11111111111111111111111111111111";
	wait for 10 ns; 

	-- Mode 0011 OR (Bitwise), PASSED
	a_tb <= "00000000000000000000000000000010"; 
	b_tb <= "00000000000000000000000000000101";
	ctrl_tb <= "0011";
	wait for 10 ns; 

	a_tb <= "00000000000000000000000000000010"; 
	b_tb <= "00000000000000000000000000000111";
	wait for 10 ns; 

	a_tb <= "11111111111111111111111111111111"; 
	b_tb <= "00000000000000000000000000000000";
	wait for 10 ns; 

	a_tb <= "11111111111111111111111111111111"; 
	b_tb <= "11110000000000000000000000000000";
	wait for 10 ns;
	-- Mode 0100 SLL
	a_tb <= "00000000000000000000000000000001"; 
	b_tb <= "00000000000000000000000000000011";
	ctrl_tb <= "0100";
	wait for 10 ns;

	a_tb <= "00000000000000000000000000000001"; 
	b_tb <= "00000000000000000000000000000010";
	wait for 10 ns;

	a_tb <= "00000000000000000000000000000010"; 
	b_tb <= "00000000000000000000000000000010";
	wait for 10 ns;

	a_tb <= "00000000000000000000000000000011"; 
	b_tb <= "00000000000000000000000000000010";
	wait for 10 ns;
	-- Mode 0101 SLT, returns 1 if a < b, PASSED
	a_tb <= "00000000000000000000000000000010"; 
	b_tb <= "00000000000000000000000000000001";
	ctrl_tb <= "0101";
	wait for 10 ns; 

	a_tb <= "00000000000000000000000000000001"; 
	b_tb <= "00000000000000000000000000000110";
	wait for 10 ns; 


	a_tb <= "11111111111111111111111111100000"; --Should return 1 b/c 2s comp
	b_tb <= "00000111111111111111111111111111";
	wait for 10 ns; 

	-- Mode 0110 SLTU, returns 1 if a < b (unsigned #s), PASSED
	a_tb <= "00000000000000000000000000000010"; 
	b_tb <= "00000000000000000000000000000001";
	ctrl_tb <= "0110";
	wait for 10 ns; 

	a_tb <= "11111111111111111111111111100000"; --Should return 1
	b_tb <= "00000111111111111111111111111111";
	wait for 10 ns; 

	a_tb <= "00000000000000000000000000000001"; 
	b_tb <= "00000000000000000000000000000110";
	wait for 10 ns; 
	a_tb <= "00000000000000000000000000000001"; 
	b_tb <= "00000000000000000000000000000000";
	wait for 10 ns;
	a_tb <= "00000000000000000000000000001110"; 
	b_tb <= "00000000000000000000000000000111";
	wait for 10 ns;
	a_tb <= "11111111111111111111111111111110"; 
	b_tb <= "00000000000000000000000000000111";
	wait for 10 ns;
	-- Test zero bit set
	a_tb <= "00000000000000000000000000000000"; 
	b_tb <= "00000000000000000000000000000000";
	wait for 10 ns; 
wait; --halt process to prevent infinite run
end process TESTPROC;

end architecture tb_architecture; 