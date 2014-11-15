library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;
use work.eecs361_bruno.all;

entity myfulladder_demo is
    port (
        z   : out std_logic;
        cout: out std_logic
    );
END myfulladder_demo;

ARCHITECTURE structural OF myfulladder_demo IS
    COMPONENT myfulladder IS
       port (
           x   : in std_logic;
           y   : in std_logic;
           c   : in std_logic;
           z   : out std_logic;
           cout : out std_logic
        );
END COMPONENT myfulladder;

signal xin : std_logic;
signal yin : std_logic;
signal cin : std_logic;
signal inbus : std_logic_vector (2 downto 0);

BEGIN
    fulladder_map : myfulladder port map (x => xin, y => yin, c => cin, z => z, cout => cout);
    cin <= inbus(2);
    yin <= inbus(1);
    xin <= inbus(0);
    
    test_proc : PROCESS
    BEGIN
        inbus <= "000";
        wait for 5 ns;
        inbus <= "001";
        wait for 5 ns;
        inbus <= "010";
        wait for 5 ns;
        inbus <= "011";
        wait for 5 ns;
        inbus <= "100";
        wait for 5 ns;
        inbus <= "101";
        wait for 5 ns;
        inbus <= "110";
        wait for 5 ns;
        inbus <= "111";
        wait for 5 ns;
        wait;
   END PROCESS;
  END ARCHITECTURE structural;
    