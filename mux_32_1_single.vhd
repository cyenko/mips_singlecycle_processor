--Selects the right overflow signal to use
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.eecs361.all;

ENTITY mux_32_1_single IS
	PORT(
		selection: IN std_logic_vector(4 downto 0);
		c0: IN std_logic; 
		c1: IN std_logic;
		c2: IN std_logic;
		c3: IN std_logic;
		c4: IN std_logic;
		c5: IN std_logic;
		c6: IN std_logic;
		c7: IN std_logic;
		c8: IN std_logic;
		c9: IN std_logic;
		c10: IN std_logic;
		c11: IN std_logic;
		c12: IN std_logic;
		c13: IN std_logic;
		c14: IN std_logic;
		c15: IN std_logic;
		c16: IN std_logic;
		c17: IN std_logic;
		c18: IN std_logic;
		c19: IN std_logic;
		c20: IN std_logic;
		c21: IN std_logic;
		c22: IN std_logic;
		c23: IN std_logic;
		c24: IN std_logic;
		c25: IN std_logic;
		c26: IN std_logic;
		c27: IN std_logic;
		c28: IN std_logic;
		c29: IN std_logic;
		c30: IN std_logic;
		c31: IN std_logic;
		result: OUT std_logic
		);
END mux_32_1_single;

--OPERATIONS MAPPING: 0000 ADD, 0001 SUB, 0010 AND, 0011 OR
--					  0100 SLL, 0101 SLT, 0110 SLTU
ARCHITECTURE struct OF mux_32_1_single IS
SIGNAL firstFilter_0,firstFilter_1,firstFilter_2,firstFilter_3 : std_logic;
SIGNAL secondFilter_0,secondFilter_1 : std_logic;
SIGNAL tempSig : std_logic_vector(3 downto 0);
COMPONENT mux_8_1_single IS
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
END COMPONENT mux_8_1_single;

	BEGIN
	--This determines the first filter of selection
    tempSig <= "0" & selection(4 downto 2);
    mux1:mux_8_1_single port map (selection(3 downto 0),c0,c1,c2,c3,c4,c5,c6,c7,firstFilter_0);
    mux2:mux_8_1_single port map (selection(3 downto 0),c8,c9,c10,c11,c12,c13,c14,c15, firstFilter_1);
    mux3:mux_8_1_single port map (selection(3 downto 0),c16,c17,c18,c19,c20,c21,c22,c23, firstFilter_2);
    mux4:mux_8_1_single port map (selection(3 downto 0),c24,c25,c26,c27,c28,c29,c30,c31, firstFilter_3);
    mux7:mux_8_1_single port map (tempSig,firstFilter_0, firstFilter_1,firstFilter_2,firstFilter_3,'0','0','0','0', result); --we dont use s4

END struct;