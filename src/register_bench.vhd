-- Le banc possede 16 registres 32 bits

Library IEEE;

use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

Entity register_bench is port(

  CLK: in std_logic;
  W  : in std_logic_vector (31 downto 0);   -- bus de donnee en ecriture
  WE : in std_logic;                        -- write enable
  RW : in std_logic_vector (3 downto 0);    -- bus d'adresses en ecriture 
  RA : in std_logic_vector (3 downto 0);    -- bus d'adresses en lecture du port A
  RB : in std_logic_vector (3 downto 0);    -- bus d'adresses en lecture du port B                         
  A : out std_logic_vector(31 downto 0);    -- bus de donnees en lecture du port A
  B : out std_logic_vector(31 downto 0));   -- bus de donnees en lecture du port B
  
end entity register_bench;


Architecture RTL of register_bench is 

  type table is array (15 downto 0) of 
  std_logic_vector(31 downto 0);        -- declaration type tableau memoire
  
  function init_banc return table is    -- initialisation du banc de registres
  variable result: table;  
  begin
    for i in 14 downto 0 loop
      result(i) := (others => '0');
    end loop;
    result(15) := X"00000030";
    return result;
  end init_banc;
  
  signal Banc: table :=init_banc;       -- declaration & initialisation du banc

begin
  
  A <= Banc (To_integer(unsigned (RA)));  -- A <= Banc (RA) 
  B <= Banc (To_integer(unsigned (RB)));  -- B <= Banc (RB)
  
  ecriture : process (CLK) begin
  
    if (rising_edge(CLK)) and (WE = '1') then
        Banc (To_integer(unsigned(RW))) <= W;
    end if;
    
  end process ecriture;
      
  
end Architecture RTL;


 
  
   