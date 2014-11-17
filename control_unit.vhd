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
		MemtoReg : out std_logic;
		ExtOp    : out std_logic
	);
END control_unit;

ARCHITECTURE struct OF control_unit IS
	SIGNAL not0 : std_logic;
	SIGNAL not1 : std_logic;
	SIGNAL not2 : std_logic;
	SIGNAL not3 : std_logic;
	SIGNAL not5 : std_logic;
	SIGNAL ALUOp0Intermediate : std_logic;
	BEGIN
		Invert0: not_gate PORT MAP(
			x => opCode(0),
			z => not0
		);
		Invert1: not_gate PORT MAP(
			x => opCode(1),
			z => not1
		);
		Invert2: not_gate PORT MAP(
			x => opCode(2),
			z => not2
		);
		Invert3: not_gate PORT MAP(
			x => opCode(3),
			z => not3
		);
		Invert5: not_gate PORT MAP(
			x => opCode(5),
			z => not5
		);
		GetIntermediate: and_gate PORT MAP(
			x => opCode(3),
			y => not1,
			z => ALUOp0Intermediate
		);
		GetALUOp0: or_gate PORT MAP(
			x => opCode(2),
			y => ALUOp0Intermediate,
			z => ALUOp(0)
		);
		GetALUOp1: nor_gate PORT MAP(
			x => opCode(2),
			y => opCode(1),
			z => ALUOp(1)
		);
		GetRegDst: nor_gate PORT MAP(
			x => opCode(3),
			y => opCode(0),
			z => RegDst
		);
		GetALUSrc: or_gate PORT MAP(
			x => opCode(3),
			y => opCode(5),
			z => ALUSrc
		);
		PCSrc <= opCode(2);
		GetMemRead: and_gate PORT MAP(
			x => opCode(5),
			y => not3,
			z => MemRead
		);
		GetMemWr: and_gate PORT MAP(
			x => opCode(5),
			y => opCode(3),
			z => MemWr
		);
		MemtoReg <= opCode(5);