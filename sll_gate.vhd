library IEEE;
use IEEE.std_logic_1164.all;
use WORK.eecs361_gates.all;
use work.eecs361_bruno.all;
use work.eecs361.all;

entity sll_gate is
	port(
		A:	in std_logic_vector(31 downto 0); --number to shift
		B:	in std_logic_vector(31 downto 0); --shift amount
		Z:	out std_logic_vector(31 downto 0) --output
	);
END ENTITY sll_gate;

ARCHITECTURE structural OF sll_gate IS

-- signals
	SIGNAL shift1: std_logic_vector(31 downto 0);
	TYPE array_shift is array (0 to 4) of std_logic_vector(31 downto 0);
	SIGNAL shift_array : array_shift;
	SIGNAL big_shift: std_logic;
	SIGNAL or_shift: std_logic_vector (31 downto 0):=(others=>'0');
	SIGNAL zeros: std_logic_vector(31 downto 0):=(others=>'0');
BEGIN 

	--have a generate function here 
	shift_first: shift_arr_n generic map (n => 1) PORT MAP (A,B(0),shift_array(0));
	shift_second: shift_arr_n generic map (n=> 2) PORT MAP (shift_array(0),B(1),shift_array(1));
	shift_third: shift_arr_n generic map (n=>3) PORT MAP (shift_array(1),B(2),shift_array(2));
	shift_fourth: shift_arr_n generic map (n=>4) PORT MAP (shift_array(2),B(3),shift_array(3));
	shift_fifth: shift_arr_n generic map (n=>5) PORT MAP (shift_array(3),B(4),shift_array(4));
--	shift_sixth: shift_arr_n generic map (n=>6) PORT MAP (shift_array(4),B(5),shift_array(5));
--	shift_seven: shift_arr_n generic map (n=>7) PORT MAP (shift_array(5),B(6),shift_array(6));
--	shift_eight: shift_arr_n generic map (n=>8) PORT MAP (shift_array(6),B(7),shift_array(7));
	
	-- since we won't shift for more than 2^7 bits (even with a 64-bit ALU) we can just create all zeros if 
	-- any of the other shifts are ON
	big_shift_check: FOR i in 5 to 31 GENERATE
		bs_map: or_gate PORT MAP (x=>B(i),y=>or_shift(i-1),z=>or_shift(i));
	END GENERATE;
	
	big_mux_map: mux_32 PORT MAP (sel=>or_shift(31),src0=>shift_array(4),src1=>zeros,z=>Z);
	
	
--	others_map: FOR i in 1 to 31 GENERATE 
--		shift_map: shift_arr_n GENERIC MAP (n=>i+1) PORT MAP (shift_array(i-1),B(i),shift_array(i));
--	end generate;	
	
	--Z <= shift_array(31);
	
END ARCHITECTURE structural;
