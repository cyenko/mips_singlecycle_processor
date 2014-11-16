 library ieee;
 use ieee.std_logic_1164.all;
 package eecs361_bruno is
 
component slt_gate_32 IS
	PORT (
		x:	in std_logic_vector(31 downto 0);
		y:	in std_logic_vector(31 downto 0);
		z:	out std_logic_vector(31 downto 0)
	);
END component slt_gate_32;

component sll_gate is
	port(
		A:	in std_logic_vector(31 downto 0); --number to shift
		B:	in std_logic_vector(31 downto 0); --shift amount
		Z:	out std_logic_vector(31 downto 0) --output
	);
END component sll_gate;

component shift_arr_n is
	generic (
		n: integer);
	port(
		A:	in std_logic_vector(31 downto 0);
		s:	in std_logic;
		Z:	out std_logic_vector(31 downto 0)
	);
END component shift_arr_n;

component my_zero_32 IS
	PORT (
		x:	in std_logic_vector(31 downto 0);
		z:	out std_logic
	);
END component my_zero_32;

 component my_mux_1 is
	PORT (
		--inputs 
		ctrl:	in std_logic_vector(3 downto 0);
		and_of:	in std_logic;
		or_of:	in std_logic;
		sll_of:	in std_logic;
		add_of:	in std_logic;
		sub_of:	in std_logic;
		slt_of:	in std_logic;
		sltu_of: in std_logic;
		R	: out std_logic
	);
end component my_mux_1;

component my_adder_32 is
	port (
		cin	:	in std_logic;
		x	:	in std_logic_vector(31 downto 0);
		y	:	in std_logic_vector(31 downto 0);
		cout:	out std_logic;
		overflow: out std_logic;
		z	:	out std_logic_vector(31 downto 0)
	);
end component my_adder_32;

component myfulladder is
	port (
		x	: in std_logic;
		y	: in std_logic;
		c	: in std_logic;
		z	: out std_logic;
		cout: out std_logic
	);
end component myfulladder;

 component mux_7 is
	PORT (
		--inputs 
		ctrl:	in std_logic_vector(3 downto 0);
		R_and:	in std_logic_vector(31 downto 0);
		R_or:	in std_logic_vector(31 downto 0);
		R_sll:	in std_logic_vector(31 downto 0);
		R_add:	in std_logic_vector(31 downto 0);
		R_sub:	in std_logic_vector(31 downto 0);
		R_slt:	in std_logic_vector(31 downto 0);
		R_sltu: in std_logic_vector(31 downto 0);
		R	: 	out std_logic_vector(31 downto 0)
	);
end component mux_7;

component my_sltu_32 IS
	PORT (
		x:	in std_logic_vector(31 downto 0);
		y:	in std_logic_vector(31 downto 0);
		z:	out std_logic_vector(31 downto 0)
	);
end component my_sltu_32;

component my_sub_32 is
	port (
		cin	:	in std_logic;
		x	:	in std_logic_vector(31 downto 0);
		y	:	in std_logic_vector(31 downto 0);
		cout:	out std_logic;
		overflow: out std_logic;
		z	:	out std_logic_vector(31 downto 0)
	);
end component my_sub_32;

end;
