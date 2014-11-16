library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;

ENTITY my_zero_32 IS
	PORT (
		x:	in std_logic_vector(31 downto 0);
		z:	out std_logic
	);
END ENTITY my_zero_32;

ARCHITECTURE structural of my_zero_32 is
	
	SIGNAL or_signals : std_logic_vector(15 downto 0);
	SIGNAL or_1_signals : std_logic_vector(7 downto 0);
	SIGNAL or_2_signals : std_logic_vector(3 downto 0);
	SIGNAL or_3_signals : std_logic_vector(1 downto 0);
	SIGNAL or_4: std_logic;
	
	
	BEGIN 
	
	-- structural architecture 
	or1:	or_gate PORT MAP (x(31),x(30),or_signals(15));
	or2:	or_gate PORT MAP (x(29),x(28),or_signals(14));
	or3:	or_gate PORT MAP (x(27),x(26),or_signals(13));
	or4:	or_gate PORT MAP (x(25),x(24),or_signals(12));
	or5:	or_gate PORT MAP (x(23),x(22),or_signals(11));
	or6:	or_gate PORT MAP (x(21),x(20),or_signals(10));
	or7:	or_gate	PORT MAP (x(19),x(18),or_signals(9));
	or8:	or_gate PORT MAP (x(17),x(16),or_signals(8));
	or9:	or_gate PORT MAP (x(15),x(14),or_signals(7));
	or10:	or_gate PORT MAP (x(13),x(12),or_signals(6));
	or11:	or_gate PORT MAP (x(11),x(10),or_signals(5));
	or12:	or_gate PORT MAP (x(9),x(8),or_signals(4));
	or13:	or_gate PORT MAP (x(7),x(6),or_signals(3));
	or14:	or_gate PORT MAP (x(5),x(4),or_signals(2));
	or15:	or_gate PORT MAP (x(3),x(2),or_signals(1));
	or16:	or_gate PORT MAP (x(1),x(0),or_signals(0));
	
	or17:	or_gate PORT MAP (or_signals(15),or_signals(14),or_1_signals(7));
	or18:	or_gate PORT MAP (or_signals(13),or_signals(12),or_1_signals(6));
	or19:	or_gate PORT MAP (or_signals(11),or_signals(10),or_1_signals(5));
	or20:	or_gate PORT MAP (or_signals(9),or_signals(8),or_1_signals(4));
	or21:	or_gate PORT MAP (or_signals(7),or_signals(6),or_1_signals(3));
	or22:	or_gate PORT MAP (or_signals(5),or_signals(4),or_1_signals(2));
	or23:	or_gate PORT MAP (or_signals(3),or_signals(2),or_1_signals(1));
	or24:	or_gate	PORT MAP (or_signals(1),or_signals(0),or_1_signals(0));
	
	or25:	or_gate PORT MAP (or_1_signals(7),or_1_signals(6),or_2_signals(3));
	or26:	or_gate PORT MAP (or_1_signals(5),or_1_signals(4),or_2_signals(2));
	or28:	or_gate PORT MAP (or_1_signals(1),or_1_signals(0),or_2_signals(0));
	or27:	or_gate PORT MAP (or_1_signals(3),or_1_signals(2),or_2_signals(1));
	
	or29:	or_gate PORT MAP (or_2_signals(3),or_2_signals(2),or_3_signals(1));
	or30:	or_gate PORT MAP (or_2_signals(1),or_2_signals(0),or_3_signals(0));
	
	or31:	or_gate PORT MAP (or_3_signals(1),or_3_signals(0),or_4);
	
	end_map:	not_gate PORT MAP (or_4,z);
	
	
END ARCHITECTURE structural;