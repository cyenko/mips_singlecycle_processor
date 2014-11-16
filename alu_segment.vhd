library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use work.mips_singlecycle.all;

ENTITY alu_segment IS
	PORT(
		busA : in std_logic_vector(31 downto 0);
		busB : in std_logic_vector(31 downto 0);
		imm16 : in std_logic_vector(15 downto 0);
		--control signals
		ALUctr: 	in std_logic_vector(3 downto 0);
		MemWr: 		in std_logic;
		MemtoReg: 	in std_logic;
		ExtOp:		in std_logic;
		ALUSrc:		in std_logic;
		--output
		Equal:	 	out std_logic;
		busW:		out std_logic_vector(31 downto 0);
		--clock
		clk : 		in std_logic;
	);
END alu_segment;

ARCHITECTURE struct OF alu_segment IS

	SIGNAL ALU_R:	std_logic_vector(31 downto 0);
	SIGNAL extender:std_logic_vector(31 downto 0);
	SIGNAL bMux:	std_logic_vector(31 downto 0);
	SIGNAL data_out:std_logic_vector(31 downto 0);
	SIGNAL data_in: std_logic_vector(31 downto 0);
	
	COMPONENT alu is
		PORT(
		-- Inputs
		A:  in  std_logic_vector(31 downto 0);
		B:  in  std_logic_vector(31 downto 0);
		ctrl: in std_logic_vector(3 downto 0);
		-- Outputs
		cout: out std_logic;      --'1' if carry out
		overflow: out std_logic;  --'1' if overflow
		ze: out std_logic;        --'1' if zero
		R:  out std_logic_vector(31 downto 0) -- result
	);
	END COMPONENT alu;
	
	COMPONENT extender IS
		PORT(
		imm16: in std_logic_vector(15 downto 0);
		ExtOp: in std_logic;
		outExt: out std_logic_vector(31 downto 0)
		);
	END COMPONENT extender;
	
	BEGIN 
	
	alu_map: alu PORT MAP (A=>busA, B=>busB, ctrl=>ALUctr, cout=>ALU_R, ze=>Equal);
	mux1_map: mux_32 PORT MAP (src0=>)





















