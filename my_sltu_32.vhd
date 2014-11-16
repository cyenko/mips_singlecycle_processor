library IEEE;
use IEEE.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_bruno.all;

ENTITY my_sltu_32 IS
	PORT (
		x:	in std_logic_vector(31 downto 0);
		y:	in std_logic_vector(31 downto 0);
		z:	out std_logic_vector(31 downto 0)
	);
end ENTITY my_sltu_32;

ARCHITECTURE structural OF my_sltu_32 IS
--signals
	SIGNAL out_slt: std_logic;
	SIGNAL out_sltu: std_logic;
	SIGNAL temp_mux1: std_logic;
	SIGNAL temp_mux2: std_logic;
	SIGNAL zeros: std_logic_vector(30 downto 0):=(others=>'0');
	SIGNAL z_slt: std_logic_vector(31 downto 0);

BEGIN 
-- structural architecture 

-- if x<y, R=1
-- else, R=0
	
	--sub_map: my_sub_32 PORT MAP (x=>x,y=>y,cin=>'0',cout=>out_sltu);
	
	slt_map: slt_gate_32 PORT MAP (x=>x,y=>y,z=>z_slt);
	out_slt <= z_slt(0);
	mux1_map: mux PORT MAP (sel => x(31),src0=>out_slt,src1=>'0',z=>temp_mux1);
	mux2_map: mux PORT MAP (sel => x(31),src0=>'1',src1=>out_slt,z=>temp_mux2);
	mux3_map: mux PORT MAP (sel => y(31),src0=>temp_mux1,src1=>temp_mux2,z=>out_sltu);
	
	-- now simply take the last bit and put it at the beginning of output
	z <= zeros & out_sltu;
	
	
END ARCHITECTURE structural;
