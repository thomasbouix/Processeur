library ieee;
use ieee.std_logic_1164.all;

entity extension_de_signe is
  generic( N : integer);
  port (  E : in std_logic_vector(N-1 downto 0);
          S : out std_logic_vector(31 downto 0)
        );
end extension_de_signe;

architecture RTL of extension_de_signe is
begin
  S(31 downto N) <= (others => E(N-1));
  S(N-1 downto 0) <= E;
  
end architecture;

