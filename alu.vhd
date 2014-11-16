library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity alu is
  port (
    ctrl  : in std_logic_vector(3 downto 0);
    A     : in std_logic_vector(31 downto 0);
    B     : in std_logic_vector(31 downto 0);
    cout  : out std_logic;  -- ‘1’ -> carry out
    ovf    : out std_logic;  -- ‘1’ -> overflow
    ze    : out std_logic;  -- ‘1’ -> is zero
    R     : out std_logic_vector(31 downto 0) -- result
  );
end alu;

ARCHITECTURE struct OF alu IS
	--Define signals to store 32-bit results for: AND, OR, ADD, SUB, SLL, SLT, SLTU
	SIGNAL andS,orS,addS,subS,sllS,sltS,sltUS : std_logic_vector(31 downto 0);
	--Store the overflow for each of the above operations
	SIGNAL overflowResult: std_logic_vector(6 downto 0);
	SIGNAL coutResult: std_logic_vector(6 downto 0);
	SIGNAL tempZeroOr1,tempZeroOr2 : std_Logic;
	SIGNAL none : std_logic_vector(31 downto 0) := x"00000000";

	--Define the components we will be using
	COMPONENT and_gate_32
	  port (
	    x   : in  std_logic_vector(31 downto 0);
	    y   : in  std_logic_vector(31 downto 0);
	    z   : out std_logic_vector(31 downto 0)
	  );
	END COMPONENT;
	COMPONENT or_gate_32
	  port (
	    x   : in  std_logic_vector(31 downto 0);
	    y   : in  std_logic_vector(31 downto 0);
	    z   : out std_logic_vector(31 downto 0)
	  );
	END COMPONENT;	
	COMPONENT bitAdder_32
	  port (
	    x,y   : in  std_logic_vector(31 downto 0);
	    carry : in std_logic;
	    resultVector   : out std_logic_vector(31 downto 0);
	    overflow : out std_logic;
	    cout: out std_logic
	  );
	END COMPONENT;
	COMPONENT bitSubtractor_32
		PORT(
			a,b: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			result: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			overflow: OUT STD_LOGIC;
			cout : OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT sll_32 
	port(
		A:	in std_logic_vector(31 downto 0); --number to shift
		B:	in std_logic_vector(31 downto 0); --shift amount
		Z:	out std_logic_vector(31 downto 0) --output
	);
	END COMPONENT;
	COMPONENT slt_32 
	  PORT (
	    x, y: IN  std_logic_vector(31 DOWNTO 0);
	    result: OUT std_logic_vector(31 DOWNTO 0);
	    overflow : OUT std_logic
	  );
	END COMPONENT;
	COMPONENT sltu_32
 	 PORT (
   	 x, y: IN  std_logic_vector(31 DOWNTO 0);
   	 result: OUT std_logic_vector(31 DOWNTO 0);
   	 overflow : OUT std_logic
 	 );
	END COMPONENT;
	COMPONENT mux_8by32_1 
	PORT(
		selection: IN std_logic_vector(3 downto 0);
		choice0: IN std_logic_vector(31 downto 0); --000 ADD
		choice1: IN std_logic_vector(31 downto 0); --100 SLL
		choice2: IN std_logic_vector(31 downto 0); --010 AND
		choice3: IN std_logic_vector(31 downto 0); --110 SLTU
		choice4: IN std_logic_vector(31 downto 0); --001 SUB
		choice5: IN std_logic_vector(31 downto 0); --101 SLT
		choice6: IN std_logic_vector(31 downto 0); --011 OR
		choice7: IN std_logic_vector(31 downto 0); --111 NONE
		result: OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT mux_8_1 
	PORT(
		selection: IN std_logic_vector(3 downto 0);
		choice0: IN std_logic; --000 ADD
		choice1: IN std_logic; --100 SLL
		choice2: IN std_logic; --010 AND
		choice3: IN std_logic; --110 SLTU
		choice4: IN std_logic; --001 SUB
		choice5: IN std_logic; --101 SLT
		choice6: IN std_logic; --011 OR
		choice7: IN std_logic; --111 NONE
		result: OUT std_logic
		);
	END COMPONENT;
	component sll_32_alt
	port(
		A:	in std_logic_vector(31 downto 0); --number to shift
		B:	in std_logic_vector(31 downto 0); --shift amount
		Z:	out std_logic_vector(31 downto 0) --output
	);
	end component;

	component nor_32
	PORT(
		A: in std_logic_vector(31 downto 0);
		result: out std_logic
	);
	end component;
	BEGIN
	--Map all the operations mentioned above
	--OPERATIONS MAPPING: 0000 ADD, 0001 SUB, 0010 AND, 0011 OR
	--					  0100 SLL, 0101 SLT, 0110 SLTU
	addMap: bitAdder_32 PORT MAP(x => A,
								 y => B,
								 carry => '0',
								 resultVector =>addS,
								 overflow => overflowResult(0),
								 cout => coutResult(0));
	subMap: bitSubtractor_32 PORT MAP(A,B,subS,overflowResult(1),coutResult(1));
	andMap: and_gate_32 PORT MAP(A,B,andS);
	orMap: or_gate_32 PORT MAP(A,B,orS);
	sllMap: sll_32_alt PORT MAP(A,B,sllS);
	sltMap: slt_32 PORT MAP(A,B,sltS,overflowResult(5));
	sltuMap: sltu_32 PORT MAP(A,B,sltuS,overflowResult(6));
	--SLTU mapping goes here

	--Finally route through the mux
    routeOutput: mux_8by32_1 port map (ctrl, addS, subS, andS, orS, sllS, sltS, sltuS, none, R);
    routeOverflowStuff: mux_8_1 port map(ctrl,overflowResult(0),overflowResult(1),'0','0','0',overflowResult(5),overflowResult(6),'0',ovf);
    routeCoutStuff: mux_8_1 port map(ctrl,coutResult(0),coutResult(1),'0','0','0','0','0','0',cout);
    getZeros: nor_32 PORT MAP(A,tempZeroOr1);
    getZeros2: nor_32 PORT MAP(B,tempZeroOr2);
    zeroBitSet: and_gate PORT MAP(tempZeroOr1,tempZeroOr2,ze);
END struct;