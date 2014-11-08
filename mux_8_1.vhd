 library IEEE;
 use IEEE.std_logic_1164.all;
 use work.eecs361_gates.all;
 
 entity mux_8_1 is
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
end ENTITY mux_8_1;

ARCHITECTURE structural of mux_8_1 IS
	COMPONENT mux_32 IS 
	  port (
		sel   : in  std_logic;
		src0  : in  std_logic_vector(31 downto 0);
		src1  : in  std_logic_vector(31 downto 0);
		z	    : out std_logic_vector(31 downto 0)
	  );
	 END COMPONENT mux_32;
	 
	 signal R_01	: std_logic_vector(31 downto 0);
	 signal R_23	: std_logic_vector(31 downto 0);
	 signal R_45	: std_logic_vector(31 downto 0);
	 signal R_67	: std_logic_vector(31 downto 0);
	 signal R_0123	: std_logic_vector(31 downto 0);
	 signal R_4567	: std_logic_vector(31 downto 0);
	 
	 BEGIN 
 
	 --first level of mux decoding
	 R01_map	: mux_32 PORT MAP (ctrl(0),R_0,R_1,R_01);
	 R23_map	: mux_32 PORT MAP (ctrl(0),R_2,R_3,R_23);
	 R45_map	: mux_32 PORT MAP (ctrl(0),R_4,R_5,R_45);
	 R67_map	: mux_32 PORT MAP (ctrl(0),R_6,R_7,R_67);
	 
	 --second level
	 R0123_map	: mux_32 PORT MAP (ctrl(1),R_01,R_23,R_0123);
	 R4567_map	: mux_32 PORT MAP (ctrl(1),R_45,R_67,R_4567);
	 
	 --third (final) level
	 last_mux_map : mux_32 PORT MAP (ctrl(2),R_0123,R_4567,R);
	 
END ARCHITECTURE structural;