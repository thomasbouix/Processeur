library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PSR_tb is
end PSR_tb;

architecture test of PSR_tb is
  
  signal DATAIN, DATAOUT : std_logic_vector(31 downto 0);
  signal WE, RST, CLK : std_logic;
  
begin
  
  PSR_0 : entity work.PSR port map (DATAIN => DATAIN, WE => WE, RST => RST, CLK => CLK, DATAOUT => DATAOUT);
    
  process begin
    
    DATAIN <= std_logic_vector(to_signed(123456789, 32));
    CLK <= '0';
    wait for 1 ns;
    
    CLK <= '1';
    WE <= '1';
    wait for 1 ns;
    assert DATAOUT = std_logic_vector(to_signed(123456789, 32)) report "assert(1) erreur DATAOUT" severity error;
    
    CLK <= '0';
    wait for 1 ns;
    WE <= '0';
    DATAIN <= std_logic_vector(to_signed(-123456789, 32));
    CLK <= '1';
    wait for 1 ns;
    assert DATAOUT = std_logic_vector(to_signed(123456789, 32)) report "assert(2) erreur DATAOUT" severity error;
    
    RST <= '1';
    wait for 1 ns;
    assert DATAOUT = std_logic_vector(to_signed(0, 32)) report "assert(3) erreur DATAOUT" severity error;
    
    report "Fin du test, assurez qu'il n'y ait pas d'erreur";
    wait;
    
  end process;
  
end architecture;
    