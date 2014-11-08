 library IEEE;
 use IEEE.std_logic_1164.all;
 use work.eecs361_gates.all;
 
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
