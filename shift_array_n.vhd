library IEEE;
use IEEE.std_logic_1164.all;
use WORK.eecs361.all;

entity shift_arr_n is
	generic (
		n: integer);
	port(
		A:	in std_logic_vector(31 downto 0);
		s:	in std_logic;
		Z:	out std_logic_vector(31 downto 0)
	);
END ENTITY shift_arr_n;

ARCHITECTURE structural OF shift_arr_n IS

-- signals
	--WE NEED:
	--INPUT SIGNAL AS ONE INPUT TO THE MUX (0 SIDE)
	--SHIFTED SIGNAL FOR SECOND PART OF MUX (1 SIDE)
	SIGNAL shifted_signal: std_logic_vector(31 downto 0);
	SIGNAL zeros: std_logic_vector(((2**(n-1))-1) downto 0):=(others=>'0');
BEGIN 
	shifted_signal <= A((31-(2**(n-1))) downto 0)&zeros;
	
	mux_map: mux_32 PORT MAP (sel => s, src0=>A,src1=>shifted_signal,z=>Z);
	
END ARCHITECTURE structural;
