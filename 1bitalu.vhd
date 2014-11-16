use work.eecs361_gates.all

entity 1bitalu is
  port (
    ctrl  : in std_logic_vector(3 downto 0);
    A     : in std_logic;
    B     : in std_logic;
    cin   : in std_logic;
    cout  : out std_logic;  -- ‘1’ -> carry out
    of    : out std_logic;  -- ‘1’ -> overflow
     R     : out std_logic -- result
  );
end 1bitalu;


ARCHITECTURE struct OF alu IS
	--Define output signals for all valid operations ADD,SUB,AND,OR,SLL,SLT,SLTU

	SIGNAL addS,subS,andS,orS,sllS,sltS,sltuS;
	--Define the components we will be using:
	COMPONENT and_gate
		PORT(x,y: IN STD LOGIC;
			 z: OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT or_gate
		PORT(x,y: IN STD LOGIC;
			 z: OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT mux_n
		PORT(
				sel	  : in	std_logic;
				src0  :	in	std_logic_vector(n-1 downto 0);
				src1  :	in	std_logic_vector(n-1 downto 0);
				z	  : out std_logic_vector(n-1 downto 0)
			);
	END COMPONENT;

	--Finally wire them together
	BEGIN
	addOp: 
	andOp: and_gate PORT MAP(x => A,y => B,z => andS);
	orOp: or_gate PORT MAP(x=>A,y=>B,z=>orS);

	END struct;