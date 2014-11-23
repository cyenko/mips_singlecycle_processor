library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

--use work.mips_singlecycle.all;

ENTITY alu_segment IS
	generic (
		mem_file : string
	);
	PORT(
		--input data
		Rs : in std_logic_vector(4 downto 0);
		Rd : in std_logic_vector(4 downto 0);
		Rt : in std_logic_vector(4 downto 0);
		Imm16 : in std_logic_vector(15 downto 0);
		shamt: in std_logic_vector(4 downto 0);
		--control signals
		RegDst:		in std_logic;
		RegWr:		in std_logic;
		ALUctr: 	in std_logic_vector(3 downto 0);
		MemWr: 		in std_logic;
		MemtoReg: 	in std_logic;
		ExtOp:		in std_logic;
		ALUSrc:		in std_logic;
		MemRead:	in std_logic;
		--output
		Equal:	 	out std_logic;
		busW:		out std_logic_vector(31 downto 0);
		--clock
		clk : 		in std_logic;
		--reset
		reset:		in std_logic
	);
END ENTITY alu_segment;

ARCHITECTURE struct OF alu_segment IS

	SIGNAL ALU_R:	std_logic_vector(31 downto 0);	--result of ALU
	SIGNAL signExtend:std_logic_vector(31 downto 0); --sign extender
	SIGNAL bMux:	std_logic_vector(31 downto 0);  --not really sure
	SIGNAL data_out:std_logic_vector(31 downto 0);	--output of data memory
	SIGNAL ALU_B:	std_logic_vector(31 downto 0); --input B on ALU (result of a mux)
	SIGNAL Rw:		std_logic_vector(4 downto 0);	--Rw (Rd or Rt as input) for register file
	SIGNAL busA:	std_logic_vector(31 downto 0);	--bus A out of register file
	SIGNAL busB:	std_logic_vector(31 downto 0);	--bus B out of register file
	SIGNAL busW_in:	std_logic_vector(31 downto 0);
	SIGNAL bs_cout : std_logic;
	SIGNAL bs_ovf : std_logic;
	COMPONENT syncram IS
	--COMPONENT sram is
	  generic (
		mem_file : string
	  );
	  port (
		clk   : in  std_logic;
		cs	  : in	std_logic;
		oe	  :	in	std_logic;
		we	  :	in	std_logic;
		addr  : in	std_logic_vector(31 downto 0);
		din	  :	in	std_logic_vector(31 downto 0);
		dout  :	out std_logic_vector(31 downto 0)
	  );
	--end COMPONENT sram;
	END COMPONENT syncram;
	
	COMPONENT alu is
	  port (
	    ctrl  : in std_logic_vector(3 downto 0);
	    A     : in std_logic_vector(31 downto 0);
	    B     : in std_logic_vector(31 downto 0);
		shamt : in std_logic_vector(4 downto 0);
	    cout  : out std_logic;  -- ‘1’ -> carry out
	    ovf    : out std_logic;  -- ‘1’ -> overflow
	    ze    : out std_logic;  -- ‘1’ -> is zero
	    R     : out std_logic_vector(31 downto 0) -- 	result
	  );
	END COMPONENT alu;
	
	COMPONENT extender IS
		PORT(
		imm16: in std_logic_vector(15 downto 0);
		ExtOp: in std_logic;
		R: out std_logic_vector(31 downto 0)
		);
	END COMPONENT extender;
	
	COMPONENT registerfile32 IS
	PORT(
		rd : in std_logic_vector(4 downto 0);
		rs : in std_logic_vector(4 downto 0);
		rt : in std_logic_vector(4 downto 0);
		busW : in std_logic_vector(31 downto 0);
		clk : in std_logic;
		writeEnable : in std_logic;
		busA: out std_logic_vector(31 downto 0);
		busB : out std_logic_vector(31 downto 0);
		reset: in std_logic
		);
	END COMPONENT registerfile32;
	
	COMPONENT mux_32 is
	port (
		sel   : in  std_logic;
		src0  : in  std_logic_vector(31 downto 0);
		src1  : in  std_logic_vector(31 downto 0);
		z	    : out std_logic_vector(31 downto 0)
	);
	END COMPONENT mux_32;
	
	COMPONENT mux_n is
	  generic (
		n	: integer
	  );
	  port (
		sel	  : in	std_logic;
		src0  :	in	std_logic_vector(n-1 downto 0);
		src1  :	in	std_logic_vector(n-1 downto 0);
		z	  : out std_logic_vector(n-1 downto 0)
	  );
	end COMPONENT mux_n;	
	
	
	BEGIN 
	
	rsrt_map: mux_n GENERIC MAP (n => 5) PORT MAP (
		sel=>RegDst,
		src0=>Rt,
		src1=>Rd,
		z=>Rw
	);
		
	regfile_map: registerfile32 PORT MAP (
		rd=>Rw,
		rs=>Rs,
		rt=>Rt,
		busW=>busW_in, 
		clk=>clk, 
		writeEnable=>RegWr,
		busA=>busA, 
		busB=>busB,
		reset=>reset
	);
	
	alu_map: alu PORT MAP (
		A=>busA, 
		B=>ALU_B, 
		shamt=>shamt,
		ctrl=>ALUctr,
		R=>ALU_R, 
		ze=>Equal,
		cout=> bs_cout,
		ovf => bs_ovf
	);
	
	sextender: extender PORT MAP (
		imm16=>Imm16,
		ExtOp=>ExtOp,
		R=>signExtend
	);
	
	mux1_map: mux_32 PORT MAP (
		sel=>ALUSrc,
		src0=>busB,
		src1=>signExtend,
		z=>ALU_B
	);
	
	--memory_map: sram
	memory_map: syncram 
		GENERIC MAP (mem_file => mem_file)
		PORT MAP (
			clk=>clk,
			cs => '1',
			oe=>MemRead,
			we=>MemWr,
			addr=>ALU_R, 
			din=>busB, 
			dout=>data_out
		);
	
	mux2_map: mux_32 PORT MAP (sel=>MemtoReg,src0=>ALU_R,src1=>data_out,z=>busW_in);
	
	busW <= busW_in;

END ARCHITECTURE struct;
