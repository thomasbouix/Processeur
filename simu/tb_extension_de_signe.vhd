library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_extension_de_signe is
end tb_extension_de_signe;

architecture test of tb_extension_de_signe is
  
  signal E : std_logic_vector(8 downto 0);
  signal S : std_logic_vector(31 downto 0);
  
begin
  
  extension_de_signe_0 : entity work.extension_de_signe generic map( N => 9) port map (E => E, S => S);
    
  process begin
    E <= std_logic_vector(to_signed(23, 9));
    wait for 1 ns;
    assert S = std_logic_vector(to_signed(23, 32)) report "erreur assert 1 mauvaise valeur de S" severity error;
    
    E <= std_logic_vector(to_signed(-23, 9));
    wait for 1 ns;
    assert S = std_logic_vector(to_signed(-23, 32)) report "erreur assert 2 mauvaise valeur de S" severity error;
    
    report "fin du test, assurez qu'il n'y a pas d'erreurs";
    wait;
    
  end process;
end architecture;