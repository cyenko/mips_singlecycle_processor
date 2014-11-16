LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE WORK.eecs361.all;

ENTITY shift_32 IS
	GENERIC ( --Similar to prebuilt components, have generic # shift
		n: integer);
	PORT(
		x:	in std_logic_vector(31 downto 0);
		y:	in std_logic; --select signal for mux
		z:	out std_logic_vector(31 downto 0)
	);


END shift_32;

ARCHITECTURE struct OF shift_32 IS
	SIGNAL zeros: std_logic_vector(((2**(n-1))-1) downto 0);
	SIGNAL newSignal: std_logic_vector(31 downto 0);

BEGIN 
	newSignal <= x((31-(2**(n-1))) downto 0)&zeros;
	
	muxes: mux_32 PORT MAP (sel => y, src0=>x,src1=>newSignal,z=>z);
	
END ARCHITECTURE struct;
