library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity unite_traitement is port(

  Clk, WE     : in std_logic;
  RW, RA, RB  : in std_logic_vector (3 downto 0);
  W  : in std_logic_vector (31 downto 0);
  OP : in std_logic_vector (1 downto 0);
  
  N  : out std_logic;
  S  : out std_logic_vector (31 downto 0));
  
end entity unite_traitement;

Architecture RTL of unite_traitement is 

  signal busA : std_logic_vector (31 downto 0);
  signal busB : std_logic_vector (31 downto 0); 
  signal busW : std_logic_vector (31 downto 0);

begin
  S <= busW;
  
  banc_registre: entity work.register_bench(RTL) port map ( Clk => Clk, W => busW, WE => WE, RW => RW, RA => RA, RB => RB, A => busA, B => busB);
  UAL : entity work.ALU(RTL) port map (A => busA, B => busB, OP => OP, S => busW, N => N);

end architecture RTL;