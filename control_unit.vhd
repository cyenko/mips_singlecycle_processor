library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

ENTITY control_unit IS
	PORT (
		opCode   : in std_logic_vector(5 downto 0);
		ALUOp    : out std_logic_vector(1 downto 0);
		RegDst   : out std_logic;
		RegWr    : out std_logic;
		ALUSrc   : out std_logic;
		PCSrc    : out std_logic;
		MemRead  : out std_logic;
		MemWr    : out std_logic;
		MemtoReg : out std_logic
	);
END control_unit;

ARCHITECTURE struct OF control_unit IS
	