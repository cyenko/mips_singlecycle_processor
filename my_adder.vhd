library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity myfulladder is
	port (
		x	: in std_logic;
		y	: in std_logic;
		c	: in std_logic;
		z	: out std_logic;
		cout: out std_logic
	);
end myfulladder;

ARCHITECTURE structural OF myfulladder IS
	SIGNAL xor0	:	std_logic;
	SIGNAL and0	:	std_logic;
	SIGNAL and1	:	std_logic;
BEGIN 
    xor0_map : xor_gate port map (x => x, y => y, z => xor0);
    xor1_map : xor_gate port map (x => xor0, y=> c, z => z);
    and0_map : and_gate port map (x => x, y=> y, z => and0);
    and1_map : and_gate port map (x => xor0, y => c, z => and1);
    or0_map  : or_gate  port map (x => and0, y => and1, z => cout);
END ARCHITECTURE structural;