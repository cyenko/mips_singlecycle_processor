--Selects the right overflow signal to use
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.eecs361.all;

ENTITY mux_8_1_single IS
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
END mux_8_1_single;

--OPERATIONS MAPPING: 0000 ADD, 0001 SUB, 0010 AND, 0011 OR
--					  0100 SLL, 0101 SLT, 0110 SLTU
ARCHITECTURE struct OF mux_8_1_single IS
SIGNAL firstFilter_0,firstFilter_1,firstFilter_2,firstFilter_3 : std_logic;
SIGNAL secondFilter_0,secondFilter_1 : std_logic;
	BEGIN
	--This determines the first filter of selection
    mux1:mux port map (selection(0),choice0, choice1, firstFilter_0);
    mux2:mux port map (selection(0),choice2, choice3, firstFilter_1);
    mux3:mux port map (selection(0),choice4, choice5, firstFilter_2);
    mux4:mux port map (selection(0),choice6, choice7, firstFilter_3);
    mux5:mux port map (selection(1),firstFilter_0, firstFilter_1,secondFilter_0);
    mux6:mux port map (selection(1),firstFilter_2, firstFilter_3, secondFilter_1);
    mux7:mux port map (selection(2),secondFilter_0, secondFilter_1, result);

END struct;