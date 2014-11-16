library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361.all;

ENTITY pc_logic is
	PORT (
		imm16 : in std_logic_vector(15 downto 0);
		clk : in std_logic;
		nPC_sel : in std_logic;
		outpc : out std_logic_vector(31 downto 0)
	);
END pc;

ARCHITECTURE struct OF pc IS
	COMPONENT register32 IS
		PORT(
			inData : in std_logic_vector(31 downto 0);
			clk: in std_logic;
			writeEnable: in std_logic;
			outData : out std_logic_vector(31 downto 0)
		);
	END register32;
	COMPONENT bitAdder_32 IS
		PORT(
			x,y   : in  std_logic_vector(31 downto 0);
			carry : in std_logic;
			resultVector   : out std_logic_vector(31 downto 0);
			overflow : out std_logic;
			cout: out std_logic
		);
	END bitAdder_32;
	COMPONENT extender IS
		PORT(
			imm16:	in std_logic_vector(15 downto 0);
			ExtOp:	in std_logic;
			R	 :	out std_logic_vector(31 downto 0)
		);
	END extender;
	SIGNAL pc_data : std_logic_vector(31 downto 0);
	SIGNAL pc_new : std_logic_vector(31 downto 0);
	SIGNAL no_branch_pc : std_logic_vector(31 downto 0);
	SIGNAL imm_extend : std_logic_vector(31 downto 0);
	SIGNAL branch_pc : std_logic_vector(31 downto 0);
	SIGNAL pcresult : std_logic_vector(31 downto 0);
	
	BEGIN
		extendImm: extender PORT MAP (
			imm16 => imm16,
			ExtOp => '1',
			R => imm_extend
		);
		getNoBranchPC: bitAdder_32 PORT MAP (
			x => x"00000004",
			y => pcresult,
			carry => '0',
			resultVector => no_branch_pc
		);
		getBranchPC: bitAdder_32 PORT MAP (
			x => no_branch_pc,
			y => imm_extend,
			carry => '0',
			resultVector => branch_pc
		);
		mux1: mux_32 PORT MAP (
			sel => nPC_sel,
			src0 => no_branch_pc,
			src1 => branch_pc,
			z => pc_new
		);
		pcreg: register32 PORT MAP (
			inData => pc_new,
			clk => clk,
			writeEnable => 1,
			outData => pcresult
		);
		outpc <= pcresult;
		
END struct;