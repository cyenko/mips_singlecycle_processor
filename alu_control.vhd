library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

ENTITY alu_control is
	PORT (
		ALUOp  : in std_logic_vector(1 downto 0);
		func   : in std_logic_vector(5 downto 0);
		ALUctr : out std_logic_vector(3 downto 0)
	);
END pc_logic;