library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity bitAdder_1 is
   port (
      a, b, cin : in std_logic;
      result, cout : out std_logic
    );
end bitAdder_1;

architecture struct of bitAdder_1 is
  signal aXorCin : std_logic;
  signal aAndB,aAndCin,bAndCin : std_logic;
  signal orIntermediate: std_logic;
begin 
    --result = a xor b xor cin
    --cout = (a and b) or (a and cin) or (b and cin)
    firstXor: xor_gate port map (x=> cin,y=>a,z=>aXorCin);
    secondXor: xor_gate port map (x=>b,y=>aXorCin,z=>result);
    firstAnd: and_gate port map (x=>a,y=>b,z=>aAndB);
    secondAnd: and_gate port map (x=>a,y=>cin,z=>aAndCin);
    thirdAnd: and_gate port map (x=>b,y=>cin,z=>bAndCin);
    firstOr: or_gate port map(x=>aAndB,y=>aAndCin,z=>orIntermediate);
    secondOr: or_gate port map(x=>orIntermediate,y=>bAndCin,z=>cout);

end architecture struct;