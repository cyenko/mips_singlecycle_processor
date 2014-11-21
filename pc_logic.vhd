library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
ENTITY pc_logic is
	generic (
		mem_file : string
	);
	PORT (
		imm16 : in std_logic_vector(15 downto 0);
		clk : in std_logic;
		nPC_sel : in std_logic;
		Instruction : out std_logic_vector(31 downto 0);
		override: in std_logic
	);
END ENTITY pc_logic;

ARCHITECTURE struct OF pc_logic IS
	COMPONENT mux_32 IS
	  PORT (
		sel   : in  std_logic;
		src0  : in  std_logic_vector(31 downto 0);
		src1  : in  std_logic_vector(31 downto 0);
		z	    : out std_logic_vector(31 downto 0)
	  );
	END COMPONENT mux_32;
	
	COMPONENT register32 IS 
		PORT(
			inData : in std_logic_vector(31 downto 0);
			clk: in std_logic;
			writeEnable: in std_logic;
			outData : out std_logic_vector(31 downto 0);
			reset:	in std_logic
		);
	END COMPONENT register32;
	
	COMPONENT bitAdder_32 IS
		PORT(
			x,y   : in  std_logic_vector(31 downto 0);
			carry : in std_logic;
			resultVector   : out std_logic_vector(31 downto 0);
			overflow : out std_logic;
			cout: out std_logic
		);
	END COMPONENT bitAdder_32;
	
	COMPONENT extender IS 
		PORT(
			imm16:	in std_logic_vector(15 downto 0);
			ExtOp:	in std_logic;
			R	 :	out std_logic_vector(31 downto 0)
		);
	END COMPONENT extender;

	COMPONENT sll_32_alt IS
		PORT(
			A:	in std_logic_vector(31 downto 0); --number to shift
			B:	in std_logic_vector(31 downto 0); --shift amount
			Z:	out std_logic_vector(31 downto 0) --output
		);
	END COMPONENT sll_32_alt;
	
	COMPONENT sram IS
	--COMPONENT syncram IS
		GENERIC (
				mem_file : string
		);
		PORT (
			--clk   : in  std_logic;
			cs	  : in	std_logic;
			oe	  :	in	std_logic;
			we	  :	in	std_logic;
			addr  : in	std_logic_vector(31 downto 0);
			din	  :	in	std_logic_vector(31 downto 0);
			dout  :	out std_logic_vector(31 downto 0)
		);
	END COMPONENT sram;
	--END COMPONENT syncram;
	
	SIGNAL start: std_logic_vector(31 downto 0):=x"00400020";
	SIGNAL outpc: std_logic_vector(31 downto 0);
	SIGNAL pc_data : std_logic_vector(31 downto 0);
	SIGNAL pc_new : std_logic_vector(31 downto 0);
	SIGNAL pc_new1 : std_logic_vector(31 downto 0);
	SIGNAL no_branch_pc : std_logic_vector(31 downto 0);
	SIGNAL imm_extend : std_logic_vector(31 downto 0);
	SIGNAL branch_pc : std_logic_vector(31 downto 0);
	SIGNAL pcresult : std_logic_vector(31 downto 0);
	SIGNAL extend_shifted : std_logic_vector(31 downto 0);
	
	BEGIN
		startup: mux_32 PORT MAP (
			sel => override,
			src0 => pc_new,
			src1 => start,
			z => pc_new1
		);
		extendImm: extender PORT MAP (
			imm16 => imm16,
			ExtOp => '1',
			R => imm_extend
		);
		multiplyby4: sll_32_alt PORT MAP (
			A => imm_extend,
			B => x"00000004",
			Z => extend_shifted
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
			inData => pc_new1,
			clk => clk,
			writeEnable => '1',
			outData => pcresult,
			reset=>'0'
		);
		get_instruction: sram GENERIC MAP (
		--get_instruction: syncram GENERIC MAP (
			mem_file => mem_file) PORT MAP (
			--clk=>clk,
			cs=>'1',
			oe=>'1',
			we=>'0',
			din => pcresult,
			addr=>pcresult,
			dout => Instruction
		);	
		outpc <= pcresult;
		
END ARCHITECTURE struct;