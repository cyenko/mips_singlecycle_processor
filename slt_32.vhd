LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.eecs361_gates.all;

ENTITY slt_32 IS
  PORT (
    x, y: IN  std_logic_vector(31 DOWNTO 0);
    result: OUT std_logic_vector(31 DOWNTO 0);
    overflow : OUT std_logic
  );
END slt_32;

ARCHITECTURE struct OF slt_32 IS
signal subtraction : std_logic_vector(31 DOWNTO 0);
signal overflowTemp : std_logic;

signal intermediate : std_logic_vector(31 downto 0) := x"00000000";
COMPONENT bitSubtractor_32 IS
  PORT(
    a,b: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    result: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    overflow: OUT STD_LOGIC);
END COMPONENT bitSubtractor_32;

BEGIN
    -- compute x - y. If negative (i.e., top bit set), then x < y.
    subcalc: bitSubtractor_32 PORT MAP (x, y, subtraction, overflowTemp);
    --intermediate(0) <= subtraction(31); -- set the result based on the sign bit of the difference 
    xorSignOverflow: xor_gate port map(subtraction(31),overflowTemp,intermediate(0));
    result <= intermediate;
    overflow <= overflowTemp;
END struct;