library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361_bruno.all;

ENTITY slt_gate_32 IS
	PORT (
		x:	in std_logic_vector(31 downto 0);
		y:	in std_logic_vector(31 downto 0);
		z:	out std_logic_vector(31 downto 0)
	);
END ENTITY slt_gate_32;

ARCHITECTURE structural of slt_gate_32 is	
	SIGNAL slt_of: std_logic;
	SIGNAL slt_signal: std_logic;
	SIGNAL temp_s: std_logic_vector(31 downto 0);
	SIGNAL result: std_logic;
	SIGNAL zeros: std_logic_vector(30 downto 0):=(others=>'0');
	SIGNAL carryout: std_logic;
	
	BEGIN 
	-- structural architecture 
	sub_map: my_sub_32 PORT MAP (cin => '0', x => x, y => y, cout => carryout, z=> temp_s, overflow => slt_of);

	res_map: xor_gate PORT MAP (x=>temp_s(31),y=>slt_of,z=>result);
	
	--not_of_map: not_gate PORT MAP (x=>sltu_of,z=>slt_signal);
	z <= zeros & result;
	
END ARCHITECTURE structural;