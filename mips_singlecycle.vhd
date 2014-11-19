library ieee;
use work.eecs361_gates.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.eecs361.all;

 
ENTITY mips_single_cycle IS
	  GENERIC (
		mem_file : string
	  );
	PORT(
		clk: 	in std_logic;
		pcOut:	out std_logic_vector(31 downto 0);
		busWout:	out std_logic_vector(31 downto 0)
	);
END ENTITY mips_single_cycle;

ARCHITECTURE struct OF mips_single_cycle IS
	COMPONENT alu_control is
		PORT (
			ALUOp  : in std_logic_vector(1 downto 0);
			func   : in std_logic_vector(5 downto 0);
			ALUCtrl : out std_logic_vector(3 downto 0)
		);
	END COMPONENT alu_control;
	
	COMPONENT alu_segment IS
		generic (
		mem_file : string
		);
		PORT(
			--input data
			Rs : in std_logic_vector(4 downto 0);
			Rd : in std_logic_vector(4 downto 0);
			Rt : in std_logic_vector(4 downto 0);
			Imm16 : in std_logic_vector(15 downto 0);
			--control signals
			RegDst:		in std_logic;
			RegWr:		in std_logic;
			ALUctr: 	in std_logic_vector(3 downto 0);
			MemWr: 		in std_logic;
			MemtoReg: 	in std_logic;
			ExtOp:		in std_logic;
			ALUSrc:		in std_logic;
			--output
			Equal:	 	out std_logic;
			busW:		out std_logic_vector(31 downto 0);
			--clock
			clk : 		in std_logic
		);
	END COMPONENT alu_segment;
	
	COMPONENT control_unit IS
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
	END COMPONENT control_unit;
	
	COMPONENT pc_logic is
		generic (
			mem_file : string
		);
		PORT (
			imm16 : in std_logic_vector(15 downto 0);
			clk : in std_logic;
			nPC_sel : in std_logic;
			Instruction : out std_logic_vector(31 downto 0)
		);
	END COMPONENT pc_logic;
	
	SIGNAL Rs:		std_logic_vector(4 downto 0);
	SIGNAL Rd:		std_logic_vector(4 downto 0);
	SIGNAL Rt:		std_logic_vector(4 downto 0);
	SIGNAL Imm16:	std_logic_vector(15 downto 0);
	SIGNAL RegDst:	std_logic;
	SIGNAL RegWr:	std_logic;
	SIGNAL ALUCtrl:	std_logic_vector(3 downto 0);
	SIGNAL MemWr:	std_logic;
	SIGNAL MemRead: std_logic;
	SIGNAL MemtoReg:std_logic;
	SIGNAL ExtOp:	std_logic;
	SIGNAL ALUSrc:	std_logic;
	
	SIGNAL ALUOp:	std_logic_vector(1 downto 0);
	SIGNAL PCSrc:	std_logic;
	
	SIGNAL Equal:	std_logic;
	SIGNAL busW:	std_logic_vector(31 downto 0);
	
	SIGNAL Instruction:	std_logic_vector(31 downto 0);

	SIGNAL nPC_sel:	std_logic;
	
	SIGNAL opcode : std_logic_vector(5 downto 0);
	SIGNAL funct:	std_logic_vector(5 downto 0);
	SIGNAL shamt:	std_logic_vector(4 downto 0);
	
	BEGIN 
	busWout <= busW;
	pcOut <= Instruction;
	opcode <= Instruction (31 downto 26);
	Rs <= Instruction (25 downto 21);
	Rt <= Instruction (20 downto 16);
	Rd <= Instruction (15 downto 11);
	funct <= Instruction (5 downto 0);
	shamt <= Instruction (10 downto 6);
	Imm16 <= Instruction (15 downto 0);
	
	pc_map: pc_logic GENERIC MAP (mem_file => mem_file) PORT MAP (
		clk=>clk,
		imm16=>Imm16,
		Instruction=>Instruction,
		nPC_sel=>nPC_sel
	);
	
	branch_map: and_gate PORT MAP (
		x=>Equal,
		y=>PCSrc,
		z=> nPC_sel
	);
	
	control_map: control_unit PORT MAP (
		opCode=>opcode,
		ALUOp => ALUOp,
		RegDst => RegDst,
		RegWr => RegWr,
		ALUSrc => ALUSrc,
		PCSrc => PCSrc,
		MemRead => MemRead,
		MemWr => MemWr,
		MemtoReg => MemtoReg,
		ExtOp => ExtOp		
	);	
		
	aluctr_map:	alu_control PORT MAP (
		ALUOp => ALUOp,
		func => funct,
		ALUCtrl => ALUCtrl
	);
	
	datapath: alu_segment GENERIC MAP (mem_file => mem_file) PORT MAP (
		Rs => Rs,
		Rd => Rd,
		Rt => Rt,
		Imm16 => Imm16,
		RegDst => RegDst,
		RegWr => RegWr,
		ALUctr => ALUCtrl,
		MemWr => MemWr,
		MemtoReg => MemtoReg,
		ExtOp => ExtOp,
		ALUSrc => ALUSrc,
		Equal => Equal,
		busW => busW,
		clk=>clk
	);
	
END ARCHITECTURE struct;
	
		
		
		


