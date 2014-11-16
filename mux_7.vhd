 library IEEE;
 use IEEE.std_logic_1164.all;
 use work.eecs361_gates.all;
 
 entity mux_7 is
	PORT (
		--inputs 
		ctrl:	in std_logic_vector(3 downto 0);
		R_and:	in std_logic_vector(31 downto 0);
		R_or:	in std_logic_vector(31 downto 0);
		R_sll:	in std_logic_vector(31 downto 0);
		R_add:	in std_logic_vector(31 downto 0);
		R_sub:	in std_logic_vector(31 downto 0);
		R_slt:	in std_logic_vector(31 downto 0);
		R_sltu: in std_logic_vector(31 downto 0);
		R	: 	out std_logic_vector(31 downto 0)
	);
end ENTITY mux_7;

ARCHITECTURE structural of mux_7 IS
	COMPONENT mux_32 IS 
	  port (
		sel   : in  std_logic;
		src0  : in  std_logic_vector(31 downto 0);
		src1  : in  std_logic_vector(31 downto 0);
		z	    : out std_logic_vector(31 downto 0)
	  );
	 END COMPONENT mux_32;
	 
	 signal addsub	: std_logic_vector(31 downto 0);
	 signal slt_u	: std_logic_vector(31 downto 0);
	 signal sll_and	: std_logic_vector(31 downto 0);
	 signal or_x	: std_logic_vector(31 downto 0);
	 signal top_1	: std_logic_vector(31 downto 0);
	 signal bot_1	: std_logic_vector(31 downto 0);
	 signal zeros	: std_logic_vector(31 downto 0):= (others=>'0');
	 
	 BEGIN 
	 -- add - x0
	 -- sub - x1
	 -- sltu - x2
	 -- slt - x3
	 -- sll - x4
	 -- and - x5
	 -- or - x6
	 -- XXX - x7
	 
	 --first level of mux decoding
	 add_sub_map	: mux_32 PORT MAP (ctrl(0),R_add,R_sub,addsub);
	 slt_u_map		: mux_32 PORT MAP (ctrl(0),R_sltu,R_slt,slt_u);
	 sll_and_map	: mux_32 PORT MAP (ctrl(0),R_sll,R_and,sll_and);
	 or_x_map		: mux_32 PORT MAP (ctrl(0),R_or,zeros,or_x);
	 
	 --second level
	 top1_map	: mux_32 PORT MAP (ctrl(1),addsub,slt_u,top_1);
	 bot1_map	: mux_32 PORT MAP (ctrl(1),sll_and,or_x,bot_1);
	 
	 --third (final) level
	 last_mux_map : mux_32 PORT MAP (ctrl(2),top_1,bot_1,R);
	 
END ARCHITECTURE structural;