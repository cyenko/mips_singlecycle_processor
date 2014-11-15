 library IEEE;
 use IEEE.std_logic_1164.all;
 use work.eecs361_gates.all;
 
 entity my_mux_1 is
	PORT (
		--inputs 
		ctrl:	in std_logic_vector(3 downto 0);
		and_of:	in std_logic;
		or_of:	in std_logic;
		sll_of:	in std_logic;
		add_of:	in std_logic;
		sub_of:	in std_logic;
		slt_of:	in std_logic;
		sltu_of: in std_logic;
		R	: out std_logic
	);
end ENTITY my_mux_1;

ARCHITECTURE structural of my_mux_1 IS
	COMPONENT mux IS 
	  port (
		sel   : in  std_logic;
		src0  : in  std_logic;
		src1  : in  std_logic;
		z	    : out std_logic
	  );
	 END COMPONENT mux;
	 
	 signal addsub	: std_logic;
	 signal slt_u	: std_logic;
	 signal sll_and	: std_logic;
	 signal or_x	: std_logic;
	 signal top_1	: std_logic;
	 signal bot_1	: std_logic;
	 signal zeros	: std_logic:= '0';
	 BEGIN 
	 --first level of mux decoding
	 add_sub_map	: mux PORT MAP (ctrl(0),add_of,sub_of,addsub);
	 slt_u_map		: mux PORT MAP (ctrl(0),sltu_of,slt_of,slt_u);
	 sll_and_map	: mux PORT MAP (ctrl(0),sll_of,and_of,sll_and);
	 or_x_map		: mux PORT MAP (ctrl(0),or_of,zeros,or_x);
	 
	 --second level
	 top1_map	: mux PORT MAP (ctrl(1),addsub,slt_u,top_1);
	 bot1_map	: mux PORT MAP (ctrl(1),sll_and,or_x,bot_1);
	 
	 --third (final) level
	 last_mux_map : mux PORT MAP (ctrl(2),top_1,bot_1,R);
	 
END ARCHITECTURE structural;