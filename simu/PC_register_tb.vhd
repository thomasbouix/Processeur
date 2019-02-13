library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_register_tb is
end PC_register_tb;

architecture test of PC_register_tb is
  
  signal clk, rst : std_logic;
  signal Win, Wout : std_logic_vector(31 downto 0);
  
begin
  
  PC_register_0 : entity work.PC_register port map(clk => clk, rst => rst, Win => Win, Wout => Wout);
  
  process begin
    
    rst <= '0';
    clk <= '0';
    wait for 1 ns;
    Win <= std_logic_vector(to_unsigned(22, 32));
    clk <= '1';
    wait for 1 ns;
    assert Wout = std_logic_vector(to_unsigned(22, 32)) report "assert(1) erreur en sortie" severity error;
    
    clk <= '0';
    wait for 1 ns;
    Win <= std_logic_vector(to_unsigned(48, 32));
    wait for 1 ns;
    assert Wout = std_logic_vector(to_unsigned(22, 32)) report "assert(2) erreur en sortie" severity error;
    
    clk <= '0';
    wait for 1 ns;
    rst <= '1';
    wait for 1 ns;
    assert Wout = std_logic_vector(to_unsigned(0, 32)); report "assert(2) erreur en sortie" severity error;
    
    report "fin du test, assurez qu'il n'y ait pas d'erreurs";
    wait;
    
  end process;
end architecture;
      