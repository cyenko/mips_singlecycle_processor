library IEEE;
use IEEE.std_logic_1164.all;
use WORK.eecs361.all;
use work.eecs361_gates.all;
use work.eecs361_bruno.all;

entity alu is
  port(
    -- Inputs
    A:  in  std_logic_vector(31 downto 0);
    B:  in  std_logic_vector(31 downto 0);
    ctrl: in std_logic_vector(3 downto 0);
    -- Outputs
    cout: out std_logic;      --'1' if carry out
    overflow: out std_logic;  --'1' if overflow
    ze: out std_logic;        --'1' if zero
    R:  out std_logic_vector(31 downto 0) -- result
  );
end entity alu;

architecture alu_architecture of alu is
  
  -- signals
  signal and_result : std_logic_vector(31 downto 0);
  signal or_result: std_logic_vector(31 downto 0);
  signal sll_result: std_logic_vector(31 downto 0);
  signal add_result: std_logic_vector(31 downto 0);
  signal sub_result: std_logic_vector(31 downto 0);
  signal slt_result: std_logic_vector(31 downto 0);
  signal sltu_result: std_logic_vector(31 downto 0);
  signal add_overflow: std_logic;
  signal add_cout: std_logic;
  signal sub_overflow: std_logic;
  signal sub_cout: std_logic;  
  signal slt_of: std_logic;
  signal sltu_of: std_logic;
  signal result: std_logic_vector(31 downto 0);
  
  
  
begin
  -- simply port map everything to its corresponding components
  and_map:  and_gate_32 port map(A,B,and_result);
  or_map:   or_gate_32  port map(A,B,or_result);
  add_map:  my_adder_32 port map(x=>A,y=>B,cin=>'0',z=>add_result,overflow=>add_overflow,cout=>add_cout);
  sub_map:  my_sub_32 port map (x=>A,y=>B,cin=>'0',z=>sub_result,overflow=>sub_overflow,cout=>sub_cout);
  sll_map:  sll_gate port map (A,B,sll_result);
  slt_map:  slt_gate_32 port map (A,B,slt_result);
  sltu_map: my_sltu_32 port map (A,B,sltu_result);

  
  -- now mux based on the control
  -- use my own mux
  final_mux:  mux_7 port map (ctrl,and_result,or_result,sll_result,add_result,sub_result,slt_result,sltu_result,result);
  
  overflow_map: my_mux_1 port map (ctrl,'0','0','0',add_overflow,sub_overflow,'0','0',overflow);
  --overflow <= '1';
  carryout_map: my_mux_1 port map (ctrl,'0','0','0',add_cout,sub_cout,'0','0',cout);
  --carryout_map: my_mux_1 port map (ctrl,add_cout,sub_cout,cout);
  
    
  zeros_map: my_zero_32 port map (result,ze);
  R <= result;
  
  
end architecture alu_architecture;
  
    