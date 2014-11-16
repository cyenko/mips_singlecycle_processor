<<<<<<< HEAD
 library IEEE;
 use IEEE.std_logic_1164.all;
 use work.eecs361_gates.all;
 --32-1 32bit MUX
 entity mux_32_1 is
	PORT (
		--inputs 
		ctrl:	in std_logic_vector(4 downto 0);
		R_0:	in std_logic_vector(31 downto 0);
		R_1:	in std_logic_vector(31 downto 0);
		R_2:	in std_logic_vector(31 downto 0);
		R_3:	in std_logic_vector(31 downto 0);
		R_4:	in std_logic_vector(31 downto 0);
		R_5:	in std_logic_vector(31 downto 0);
		R_6: 	in std_logic_vector(31 downto 0);
		R_7:	in std_logic_vector(31 downto 0);
		R_8:	in std_logic_vector(31 downto 0);
		R_9:	in std_logic_vector(31 downto 0);
		R_10:	in std_logic_vector(31 downto 0);
		R_11:	in std_logic_vector(31 downto 0);
		R_12:	in std_logic_vector(31 downto 0);
		R_13:	in std_logic_vector(31 downto 0);
		R_14:	in std_logic_vector(31 downto 0);
		R_15:	in std_logic_vector(31 downto 0);
		R_16:	in std_logic_vector(31 downto 0);
		R_17:	in std_logic_vector(31 downto 0);
		R_18:	in std_logic_vector(31 downto 0);
		R_19:	in std_logic_vector(31 downto 0);
		R_20:	in std_logic_vector(31 downto 0);
		R_21:	in std_logic_vector(31 downto 0);
		R_22:	in std_logic_vector(31 downto 0);
		R_23:	in std_logic_vector(31 downto 0);
		R_24:	in std_logic_vector(31 downto 0);
		R_25:	in std_logic_vector(31 downto 0);
		R_26:	in std_logic_vector(31 downto 0);
		R_27:	in std_logic_vector(31 downto 0);
		R_28:	in std_logic_vector(31 downto 0);
		R_29:	in std_logic_vector(31 downto 0);
		R_30:	in std_logic_vector(31 downto 0);
		R_31:	in std_logic_vector(31 downto 0);	
		R	: 	out std_logic_vector(31 downto 0)
	);
end ENTITY mux_32_1;

ARCHITECTURE structural of mux_32_1 IS
	COMPONENT mux_32 IS 
	  port (
		sel   : in  std_logic;
		src0  : in  std_logic_vector(31 downto 0);
		src1  : in  std_logic_vector(31 downto 0);
		z	    : out std_logic_vector(31 downto 0)
	  );
	 END COMPONENT mux_32;
	 COMPONENT mux_8_1 is
		PORT (
			--inputs 
			ctrl:	in std_logic_vector(2 downto 0);
			R_0:	in std_logic_vector(31 downto 0);
			R_1:	in std_logic_vector(31 downto 0);
			R_2:	in std_logic_vector(31 downto 0);
			R_3:	in std_logic_vector(31 downto 0);
			R_4:	in std_logic_vector(31 downto 0);
			R_5:	in std_logic_vector(31 downto 0);
			R_6: 	in std_logic_vector(31 downto 0);
			R_7:	in std_logic_vector(31 downto 0);
			R	: 	out std_logic_vector(31 downto 0)
		);
	 end COMPONENT mux_8_1;
	 signal RR_0	: std_logic_vector(31 downto 0);
	 signal RR_1	: std_logic_vector(31 downto 0);
	 signal RR_2	: std_logic_vector(31 downto 0);
	 signal RR_3	: std_logic_vector(31 downto 0);
	 signal RR_4	: std_logic_vector(31 downto 0);
	 signal RR_5	: std_logic_vector(31 downto 0);
	 
	 BEGIN 
 
	 --first level of mux decoding
	R0_map 	mux_8_1	PORT MAP (ctrl(2 downto 0),R_0,R_1,R_2,R_3,R_4,R_5,R_6,R_7,RR_0);
	R1_map	mux_8_1 PORT MAP (ctrl(2 downto 0),R_8,R_9,R_10,R_11,R_12,R_13,R_14,R_15,RR_1);
	R2_map	mux_8_1	PORT MAP (ctrl(2 downto 0),R_16,R_17,R_18,R_19,R_20,R_21,R_22,R_23,RR_2);
	R3_map	mux_8_1 PORT MAP (ctrl(2 downto 0),R_24,R_25,R_26,R_27,R_28,R_29,R_30,R_31,RR_3);
	 
	 --second level
	 R4_map	: mux_32 PORT MAP (ctrl(3),RR_0,RR_1,RR_4);
	 R5_map	: mux_32 PORT MAP (ctrl(3),RR_2,RR_3,RR_5);
	 
	 --third (final) level
	 last_mux_map : mux_32 PORT MAP (ctrl(4),RR_4,RR_5,R);
	 
END ARCHITECTURE structural;
=======
--Selects the right overflow signal to use
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.eecs361.all;

ENTITY mux_32_1 IS
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
END mux_32_1;

--OPERATIONS MAPPING: 0000 ADD, 0001 SUB, 0010 AND, 0011 OR
--					  0100 SLL, 0101 SLT, 0110 SLTU
ARCHITECTURE struct OF mux_32_1 IS
SIGNAL firstFilter_0,firstFilter_1,firstFilter_2,firstFilter_3 : std_logic;
SIGNAL secondFilter_0,secondFilter_1 : std_logic;
SIGNAL tempSig : std_logic_vector(3 downto 0);
COMPONENT mux_8_1 IS
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
END COMPONENT mux_8_1;

	BEGIN
	--This determines the first filter of selection
    tempSig <= "0" & selection(4 downto 2);
    mux1:mux_8_1 port map (selection(3 downto 0),c0,c1,c2,c3,c4,c5,c6,c7,firstFilter_0);
    mux2:mux_8_1 port map (selection(3 downto 0),c8,c9,c10,c11,c12,c13,c14,c15, firstFilter_1);
    mux3:mux_8_1 port map (selection(3 downto 0),c16,c17,c18,c19,c20,c21,c22,c23, firstFilter_2);
    mux4:mux_8_1 port map (selection(3 downto 0),c24,c25,c26,c27,c28,c29,c30,c31, firstFilter_3);
    mux7:mux_8_1 port map (tempSig,firstFilter_0, firstFilter_1,firstFilter_2,firstFilter_3,'0','0','0','0', result); --we dont use s4

END struct;
>>>>>>> origin/master
