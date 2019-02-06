library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_data_memory is
end tb_data_memory;

architecture test of tb_data_memory is
  
  signal CLK : std_logic;
  signal WrEn : std_logic;
  signal Addr : std_logic_vector(5 downto 0) := (others => '0');
  signal DataIn : std_logic_vector(31 downto 0) := (others => '0');
  signal DataOut : std_logic_vector(31 downto 0);
  
  begin
    
    data_memory_0 : entity work.data_memory port map(CLK => CLK, WrEn => WrEn, Addr => Addr, DataIn => DataIn, DataOut => DataOut);
      
    process begin
      CLK <='0';
      wait for 1 ns;
      
      --ecriture
      WrEn <= '1';
      Addr <= std_logic_vector(to_unsigned(23, 6));
      DataIn <= std_logic_vector(to_signed(-32, 32));
      CLK <= '1';
      wait for 1 ns;
      assert DataOut = std_logic_vector(to_signed(-32, 32)) report "assert 1 erreur sur DataOut" severity error;
      
      CLK <= '0';
      wait for 1 ns;
       
      --fausse ecriture
      WrEn <= '0';
      Addr <= std_logic_vector(to_unsigned(23, 6));
      DataIn <= std_logic_vector(to_signed(32, 32));
      CLK <= '1';
      wait for 1 ns;
      assert DataOut = std_logic_vector(to_signed(-32, 32)) report "assert 2 erreur sur DataOut" severity error;
      
      report "fin du test, assurez qu'il n'y ait pas d'erreurs";
      wait;
      
    end process;
    
  end architecture;
  
      
