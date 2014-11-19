library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

ENTITY alu_control is
	PORT (
		ALUOp  : in std_logic_vector(1 downto 0);
		func   : in std_logic_vector(5 downto 0);
		ALUCtrl : out std_logic_vector(3 downto 0)
	);
END alu_control;

ARCHITECTURE struct OF alu_control IS
	SIGNAL R_type : std_logic;
	SIGNAL branch : std_logic;
	SIGNAL notop0 : std_logic;
	SIGNAL notop1 : std_logic;
	SIGNAL notfunc0 : std_logic;
	SIGNAL notfunc1 : std_logic;
	SIGNAL notfunc2 : std_logic;
	SIGNAL notfunc3 : std_logic;
	SIGNAL notfunc4 : std_logic;
	SIGNAL notfunc5 : std_logic;
	SIGNAL func3ornot5 : std_logic;
	SIGNAL func3and0 : std_logic;
	SIGNAL func2or3and0 : std_logic;
	SIGNAL case1 : std_logic;
	SIGNAL case2 : std_logic;
	SIGNAL case2temp : std_logic;
	SIGNAL case3 : std_logic;
	SIGNAL combine1 : std_logic;
	SIGNAL combine2 : std_logic;
	SIGNAL checkR : std_logic;
	BEGIN
		InvertOp0: not_gate PORT MAP(
			x => ALUOp(0),
			z => notop0
		);
		InvertOp1: not_gate PORT MAP(
			x => ALUOp(1),
			z => notop1
		);
		InvertFunc0: not_gate PORT MAP(
			x => func(0),
			z => notfunc0
		);
		InvertFunc1: not_gate PORT MAP(
			x => func(1),
			z => notfunc1
		);
		InvertFunc2: not_gate PORT MAP(
			x => func(2),
			z => notfunc2
		);
		InvertFunc3: not_gate PORT MAP(
			x => func(3),
			z => notfunc3
		);
		InvertFunc4: not_gate PORT MAP(
			x => func(4),
			z => notfunc4
		);
		InvertFunc5: not_gate PORT MAP(
			x => func(5),
			z => notfunc5
		);
		GetR: and_gate PORT MAP(
			x => ALUOp(1),
			y => notop0,
			z => R_type
		);
		GetBranch: and_gate PORT MAP(
			x => ALUOp(0),
			y => notop1,
			z => branch
		);
		Get3ornot5: or_gate PORT MAP(
			x => func(3),
			y => notfunc5,
			z => func3ornot5
		);
		Get2: and_gate PORT MAP(
			x => R_type,
			y => func3ornot5,
			z => ALUCtrl(2)
		);
		Get3and0: and_gate PORT MAP(
			x => func(3),
			y => func(0),
			z => func3and0
		);
		Get2or3and0: or_gate PORT MAP(
			x => func(2),
			y => func3and0,
			z => func2or3and0
		);
		Get1: and_gate PORT MAP(
			x => R_type,
			y => func2or3and0,
			z => ALUCtrl(1)
		);
		GetCase1: and_gate PORT MAP(
			x => func(1),
			y => notfunc0,
			z => case1
		);
		GetCase2Temp: and_gate PORT MAP(
			x => func(1),
			y => func(0),
			z => case2temp
		);
		GetCase2: and_gate PORT MAP(
			x => case2temp,
			y => notfunc3,
			z => case2
		);
		GetCase3: and_gate PORT MAP(
			x => func(2),
			y => func(0),
			z => case3
		);
		GetCombine1: or_gate PORT MAP(
			x => case1,
			y => case2,
			z => combine1
		);
		GetCombine2: or_gate PORT MAP(
			x => combine1,
			y => case3,
			z => combine2
		);
		GetCheckR: and_gate PORT MAP(
			x => combine2,
			y => R_type,
			z => checkR
		);
		Get0: or_gate PORT MAP(
			x => branch,
			y => checkR,
			z => ALUCtrl(0)
		);
		ALUCtrl(3) <= '0';