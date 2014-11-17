--Selects the right overflow signal to use
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.eecs361.all;

ENTITY mux_8_1 IS
	PORT(
		selection: IN std_logic_vector(2 downto 0);
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
END mux_8_1;

--OPERATIONS MAPPING: 0000 ADD, 0001 SUB, 0010 AND, 0011 OR
--					  0100 SLL, 0101 SLT, 0110 SLTU
ARCHITECTURE struct OF mux_8_1 IS
SIGNAL firstFilter_0,firstFilter_1,firstFilter_2,firstFilter_3 : std_logic_vector(31 downto 0);
SIGNAL secondFilter_0,secondFilter_1 : std_logic_vector(31 downto 0);
	BEGIN
	--This determines the first filter of selection
    mux1:mux_32 port map (selection(0),choice0, choice1, firstFilter_0);
    mux2:mux_32 port map (selection(0),choice2, choice3, firstFilter_1);
    mux3:mux_32 port map (selection(0),choice4, choice5, firstFilter_2);
    mux4:mux_32 port map (selection(0),choice6, choice7, firstFilter_3);
    mux5:mux_32 port map (selection(1),firstFilter_0, firstFilter_1,secondFilter_0);
    mux6:mux_32 port map (selection(1),firstFilter_2, firstFilter_3, secondFilter_1);
    mux7:mux_32 port map (selection(2),secondFilter_0, secondFilter_1, result);

END struct;