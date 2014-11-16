library IEEE;
use IEEE.std_logic_1164.all;
use WORK.eecs361.all;

entity sll_32_alt is

	port(
		A:	in std_logic_vector(31 downto 0); --number to shift
		B:	in std_logic_vector(31 downto 0); --shift amount
		Z:	out std_logic_vector(31 downto 0) --output
	);

END sll_32_alt;

ARCHITECTURE struct OF sll_32_alt IS
component mux_32_1 is
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
end component mux_32_1;
-- signals
	SIGNAL na : std_logic := '0';
	SIGNAL ctrl : std_logic_vector(4 downto 0);
	SIGNAL result: std_logic_vector(31 downto 0);
	TYPE array_shift is array (0 to 4) of std_logic_vector(31 downto 0);
	SIGNAL shift_array : array_shift;
	--SIGNAL zeros: std_logic_vector((n-1) downto 0);
BEGIN 
ctrl <= B(4 downto 0);
	--have a generate function here 
m1:mux_32_1 port map(ctrl,A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,Z(0));
m2:mux_32_1 port map(ctrl,A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,Z(1));
m3:mux_32_1 port map(ctrl,A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,Z(2));
m4:mux_32_1 port map(ctrl,A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,Z(3));
m5:mux_32_1 port map(ctrl,A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(4));
m6:mux_32_1 port map(ctrl,A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(5));
m7:mux_32_1 port map(ctrl,A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(6));
m8:mux_32_1 port map(ctrl,A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(7));
m9:mux_32_1 port map(ctrl,A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(8));
m10:mux_32_1 port map(ctrl,A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(9));
m11:mux_32_1 port map(ctrl,A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(10));
m12:mux_32_1 port map(ctrl,A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(11));
m13:mux_32_1 port map(ctrl,A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(12));
m14:mux_32_1 port map(ctrl,A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(13));
m15:mux_32_1 port map(ctrl,A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(14));
m16:mux_32_1 port map(ctrl,A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(15));
m17:mux_32_1 port map(ctrl,A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(16));
m18:mux_32_1 port map(ctrl,A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(17));
m19:mux_32_1 port map(ctrl,A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(18));
m20:mux_32_1 port map(ctrl,A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,na,result=>Z(19));
m21:mux_32_1 port map(ctrl,A(20),A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,na,result=>Z(20));
m22:mux_32_1 port map(ctrl,A(21),A(20),A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,na,result=>Z(21));
m23:mux_32_1 port map(ctrl,A(22),A(21),A(20),A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,na,result=>Z(22));
m24:mux_32_1 port map(ctrl,A(23),A(22),A(21),A(20),A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,na,result=>Z(23));
m25:mux_32_1 port map(ctrl,A(24),A(23),A(22),A(21),A(20),A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,na,result=>Z(24));
m26:mux_32_1 port map(ctrl,A(25),A(24),A(23),A(22),A(21),A(20),A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,na,result=>Z(25));
m27:mux_32_1 port map(ctrl,A(26),A(25),A(24),A(23),A(22),A(21),A(20),A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,na,result=>Z(26));
m28:mux_32_1 port map(ctrl,A(27),A(26),A(25),A(24),A(23),A(22),A(21),A(20),A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,na,result=>Z(27));
m29:mux_32_1 port map(ctrl,A(28),A(27),A(26),A(25),A(24),A(23),A(22),A(21),A(20),A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,na,result=>Z(28));
m30:mux_32_1 port map(ctrl,A(29),A(28),A(27),A(26),A(25),A(24),A(23),A(22),A(21),A(20),A(19),A(18),A(17),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,na,result=>Z(29));
m31:mux_32_1 port map(ctrl,A(30),A(29),A(28),A(27),A(26),A(25),A(24),A(23),A(22),A(21),A(20),A(19),A(18),A(17),A(14),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),na,result=>Z(30));
m32:mux_32_1 port map(ctrl,A(31),A(30),A(29),A(28),A(27),A(26),A(25),A(24),A(23),A(22),A(21),A(20),A(19),A(18),A(13),A(16),A(15),A(14),A(13),A(12),A(11),A(10),A(9),A(8),A(7),A(6),A(5),A(4),A(3),A(2),A(1),A(0),result=>Z(31));
END ARCHITECTURE struct;
