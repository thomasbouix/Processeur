library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity unite_traitement_tb is port(

  OK : out boolean := TRUE);
  
end Entity unite_traitement_tb;

architecture test_bench of unite_traitement_tb is 

  signal Clk_i, WE_i: std_logic;
  signal RW_i, RA_i, RB_i : std_logic_vector (3 downto 0);
  signal W_i  : std_logic_vector (31 downto 0);
  signal OP_i : std_logic_vector (1 downto 0);
  signal N_i  : std_logic;
  signal S_i  : std_logic_vector (31 downto 0);

  begin

  traitement_unity: entity work.unite_traitement(RTL) port map (Clk => Clk_i, WE => WE_i , RW => RW_i , RA => RA_i, RB => RB_i, W => W_i, OP => OP_i, N => N_i , S => S_i); 
    
  clock: process begin
  Clk_i <= '0';
  wait for 5 ns;
  Clk_i <= '1';
  wait for 5 ns;
  end process clock;
  
  test: process begin
  
    -- initialisation
    WE_i <= '0';
    RW_i <= (others => '0');
    RA_i <= (others => '0');
    RB_i <= (others => '0');
    W_i  <= (others => '0');
    OP_i <= (others => '0');
    
    wait for 100 ns;
    
    -- ecriture sur tab(0) et tab(1)
    WE_i <= '1';
    
    W_i <= (others => '0');
    W_i(0) <= '1';    
    RW_i <= "0000";  
    
    wait for 100 ns;
    
    W_i <= (others => '0');
    W_i(1) <= '1'; 
    RW_i <= "0001";
    wait for 100 ns;
    
    wait;
    
  end process; 
    
    
  
end architecture; 

  