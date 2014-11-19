library ieee;
use ieee.std_logic_1164.all;

entity control_unit_tb is
	--Empty declaration for test bech
END control_unit_tb;

ARCHITECTURE struct OF control_unit_tb IS
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
--The test signals
signal opcode_tb : std_logic_vector(5 downto 0);
signal aluop_tb : std_logic_vector(1 downto 0);
signal regdst_tb : std_logic;
signal regwr_tb : std_logic;
signal alusrc_tb : std_logic;
signal pcsrc_tb : std_logic;
signal memread_tb : std_logic;
signal memwr_tb : std_logic;
signal memtoreg_tb : std_logic;
signal extop_tb : std_logic;


BEGIN
	controllogic_map: control_unit port map (
		opCode => opcode_tb,
		ALUOp => aluop_tb,
		RegDst => regdst_tb,
		RegWr => regwr_tb,
		ALUSrc => alusrc_tb,
		PCSrc => pcsrc_tb,
		MemRead => memread_tb,
		MemWr => memwr_tb,
		MemToReg => memtoreg_tb,
		ExtOp => extop_tb);

    test_proc : PROCESS
    --Test Checklist: Rtype, beq, bne, Addi, Lw, Sw
    BEGIN
    	--BEGIN BASE TESTS
    	--R, aluop=10,regdst=1,regwr=1
    	--alusrc=0,pcsrc=0,memread=0,memwr=0,memreg=0,extop=1
        opcode_tb <= "000000";
		wait for 5 ns;

    	--beq, aluop=01,regdst=X,regwr=0
    	--alusrc=0,pcsrc=1,memread=0,memwr=0,memreg=X,extop=1
        opcode_tb <= "000100";
		wait for 5 ns;

    	--bne, aluop=01,regdst=X,regwr=0
    	--alusrc=0,pcsrc=1,memread=0,memwr=0,memreg=X,extop=1
        opcode_tb <= "000101";
		wait for 5 ns;

    	--addi, aluop=11,regdst=0,regwr=1
    	--alusrc=1,pcsrc=1,memread=0,memwr=0,memreg=X,extop=1
        opcode_tb <= "001000";
		wait for 5 ns;

    	--lw, aluop=00,regdst=0,regwr=1
    	--alusrc=1,pcsrc=0,memread=1,memwr=0,memreg=1,extop=1
        opcode_tb <= "100011";
		wait for 5 ns;

    	--sw, aluop=00,regdst=X,regwr=1
    	--alusrc=1,pcsrc=0,memread=0,memwr=1,memreg=x,extop=1
        opcode_tb <= "101011";
		wait for 5 ns;

        wait;
   END PROCESS;
  END ARCHITECTURE struct;
    