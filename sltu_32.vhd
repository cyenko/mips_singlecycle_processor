LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.eecs361_gates.all;

ENTITY sltu_32 IS
  PORT (
    x, y: IN  std_logic_vector(31 DOWNTO 0);
    result: OUT std_logic_vector(31 DOWNTO 0);
    overflow : OUT std_logic
  );
END sltu_32;

ARCHITECTURE struct OF sltu_32 IS
signal subtraction : std_logic_vector(31 DOWNTO 0);
signal intermediate : std_logic_vector(31 downto 0) := x"00000000";
signal overflowTemp : std_logic;
signal coutTemp : std_logic;
COMPONENT bitSubtractor_32 IS
	PORT(
		a,b: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		result: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		overflow: OUT STD_LOGIC;
		cout: OUT STD_LOGIC
	);
END COMPONENT bitSubtractor_32;

BEGIN
    -- compute x - y. If negative (i.e., top bit set), then x < y.
    --We check overflow - if overflow = 1, then a < b, return 1. But overflow doesnt work in unsigned
    --Thus we check not cout, if = 1 then a < b
    subcalc: bitSubtractor_32 PORT MAP (x, y, subtraction, overflowTemp,coutTemp);
    overflow <= overflowTemp; 
    notCout: not_gate port map (coutTemp,intermediate(0));
    --intermediate(0) <= overflowTemp;
    result <= intermediate;

END struct;