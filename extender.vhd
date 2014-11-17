library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361_gates.all;

ENTITY extender IS
	PORT(
		imm16:	in std_logic_vector(15 downto 0);
		ExtOp:	in std_logic;
		R	 :	out std_logic_vector(31 downto 0)
	);
end extender;

ARCHITECTURE struct of extender IS

	SIGNAL signExt: std_logic_vector(15 downto 0):=(others=>'0');
	SIGNAL sign: std_logic;
BEGIN

	--sign extender or 0 extender
	--if ExtOp=0, keep at 0
	--if ExtOp=1, extend the 15th bit of the imm16
	
	sign_map: or_gate PORT MAP (x=>imm16(15),y=>'0',z=>sign);
	loop_map: FOR i in 0 to 15 generate
		mapsign: signExt(i) <= sign;
	END GENERATE;
	
	R(15 downto 0) <= imm16;
	R(31 downto 16) <= signExt;

end struct;
