library ieee;
use ieee.std_logic_1164.all;
use WORK.eecs361_gates.all;

entity my_sub_32 is
	port (
		cin	:	in std_logic;
		x	:	in std_logic_vector(31 downto 0);
		y	:	in std_logic_vector(31 downto 0);
		cout:	out std_logic;
		overflow: out std_logic;
		z	:	out std_logic_vector(31 downto 0)
	);
end my_sub_32;

architecture structural of my_sub_32 is
component myfulladder is
	port (
		x	: in std_logic;
		y	: in std_logic;
		c	: in std_logic;
		z	: out std_logic;
		cout: out std_logic
	);
end COMPONENT myfulladder;
component my_adder_32 is
	port (
		cin	:	in std_logic;
		x	:	in std_logic_vector(31 downto 0);
		y	:	in std_logic_vector(31 downto 0);
		cout:	out std_logic;
		overflow: out std_logic;
		z	:	out std_logic_vector(31 downto 0)
	);
end COMPONENT my_adder_32;

--SIGNAL carryout : std_logic_vector(31 downto 0);
SIGNAL noty: std_logic_vector(31 downto 0);
SIGNAL negy: std_logic_vector(31 downto 0);
SIGNAL one: std_logic_vector(31 downto 0):="00000000000000000000000000000001";
SIGNAL negy_cout: std_logic;
SIGNAL o_flow: std_logic;

BEGIN
	--
	-- we need to negate y and add 1
	noty_map: not_gate_32 PORT MAP (x=>y,z=>noty);
	negy_map: my_adder_32 PORT MAP (x=>noty,y=>one,z=>negy,cin=>'0',cout=>negy_cout);
	--now map the signal in to the full adders
	-- and use ripple carry to do the addition
	add_map: my_adder_32 PORT MAP (x=>x,y=>negy,cin=>cin,z=>z,cout=>cout,overflow=>o_flow);
	
	overflow <= o_flow;
	--cout <= carryout(31);
	
END ARCHITECTURE structural;