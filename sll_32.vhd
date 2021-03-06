library IEEE;
use IEEE.std_logic_1164.all;
use WORK.eecs361.all;

entity sll_32 is

	port(
		A:	in std_logic_vector(31 downto 0); --number to shift
		shamt: in std_logic_vector(4 downto 0);
		--B:	in std_logic_vector(31 downto 0); --shift amount
		Z:	out std_logic_vector(31 downto 0) --output
	);

END sll_32;

ARCHITECTURE struct OF sll_32 IS

COMPONENT shift_32 is
	GENERIC ( --Similar to prebuilt components, have generic # shift
		n: integer);
	PORT(
		x:	in std_logic_vector(31 downto 0);
		y:	in std_logic; --select signal for mux
		z:	out std_logic_vector(31 downto 0)
	);

END COMPONENT shift_32;
-- signals
	SIGNAL shift1: std_logic_vector(31 downto 0);
	TYPE array_shift is array (0 to 4) of std_logic_vector(31 downto 0);
	SIGNAL shift_array : array_shift;
	--SIGNAL zeros: std_logic_vector((n-1) downto 0);
BEGIN 

	--have a generate function here 
	shift_first: shift_32 generic map (n => 1) PORT MAP (A,shamt(0),shift_array(0));
	shift_second: shift_32 generic map (n=> 2) PORT MAP (shift_array(0),shamt(1),shift_array(1));
	shift_third: shift_32 generic map (n=>3) PORT MAP (shift_array(1),shamt(2),shift_array(2));
	shift_fourth: shift_32 generic map (n=>4) PORT MAP (shift_array(2),shamt(3),shift_array(3));
	shift_fifth: shift_32 generic map (n=>5) PORT MAP (shift_array(3),shamt(4),shift_array(4));
	
	Z <= shift_array(4);
	
END ARCHITECTURE struct;
