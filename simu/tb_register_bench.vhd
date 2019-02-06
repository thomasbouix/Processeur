library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_register_bench is
end tb_register_bench;

architecture test of tb_register_bench is

  signal CLK: std_logic := '0';
  signal W  : std_logic_vector (31 downto 0) := (others => '0');   -- bus de donnee en ecriture
  signal RA : std_logic_vector (3 downto 0) := "0000";    -- bus d'adresses en lecture du port A
  signal RB : std_logic_vector (3 downto 0) := "0000";    -- bus d'adresses en lecture du port B
  signal RW : std_logic_vector (3 downto 0) := "0000";    -- bus d'adresses en ecriture 
  signal WE : std_logic := '0';                        -- write enable
  signal A :  std_logic_vector(31 downto 0) := (others => '0');    -- bus de donnees en lecture du port A
  signal B :  std_logic_vector(31 downto 0) := (others => '0');   -- bus de donnees en lecture du port B
  
  begin
    
    register_bench_0 : entity work.register_bench port map( CLK => CLK,
                                                            W => W,
                                                            RA => RA,
                                                            RB => RB,
                                                            RW => RW,
                                                            WE => WE,
                                                            A => A,
                                                            B => B);
    process begin
      
      CLK <= '0';
      wait for 1 ns;
      
      
      --eciture sur 1
      WE <= '1';
      RW <= "0001";
      W <= std_logic_vector(to_signed(16, 32));
      CLK <= '1';
      wait for 1 ns;
      
      --lecture de 1
      RA <= "0001";
      wait for 1 ns;
      assert A = std_logic_vector(to_signed(16, 32)) report "asset 1 erreur en lecture de A" severity warning;
      
      
      --ecriture sur 5
      CLK <= '0';
      wait for 1 ns;
      WE <= '1';
      RW <= "0101";
      W <= std_logic_vector(to_signed(-10, 32));
      CLK <= '1';
      wait for 1 ns;
      
      --fausse ecriture sur 5 (WE = '0')
      CLK <= '0';
      wait for 1 ns;
      WE <= '0';
      RW <= "0101";
      W <= std_logic_vector(to_signed(10, 32));
      CLK <= '1';
      wait for 1 ns;
      
      --lecture de 5
      RB <= "0101";
      wait for 1 ns;
      assert B = std_logic_vector(to_signed(-10, 32)) report "assert 2 erreur de lecture de B" severity warning;
      
      
      --lecture de 15
      RA <= "1111";
      wait for 1 ns;
      assert A = std_logic_vector(to_signed(48, 32)) report "assert 3 erreur de lecture de B" severity warning;
      
      report "End of test. Verify that no error was reported.";
		  wait;
		 end process;
		 
	end architecture;
      