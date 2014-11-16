library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361_bruno.all;

entity my_adder_32 is
	port (
		cin	:	in std_logic;
		x	:	in std_logic_vector(31 downto 0);
		y	:	in std_logic_vector(31 downto 0);
		cout:	out std_logic;
		overflow: out std_logic;
		z	:	out std_logic_vector(31 downto 0)
	);
end my_adder_32;

architecture structural of my_adder_32 is

SIGNAL carryout : std_logic_vector(31 downto 0);

BEGIN
	--now map the signal in to the full adders
	-- and use ripple carry to do the addition
	first_map: myfulladder PORT MAP (x(0),y(0),cin,z(0),carryout(0));
	others_map: FOR i IN 1 to 31 GENERATE
		adder_map: myfulladder PORT MAP (x(i),y(i),carryout(i-1),z(i),carryout(i));
	END GENERATE;
	
	--now simply map the last of the carry out into the actual cout
	cout <= carryout(31);
	overflow_map : xor_gate PORT MAP (x=>carryout(30),y=>carryout(31),z=>overflow);
	
END ARCHITECTURE structural;