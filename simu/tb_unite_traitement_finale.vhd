library ieee;
USE ieee.std_logic_1164.all;

Entity tb_unite_traitement_finale is port(

  OK : out boolean := TRUE);

end entity tb_unite_traitement_finale;

Architecture test_bench of tb_unite_traitement_finale is 

  signal Clk : std_logic;
  signal RegWr, WrEn : std_logic;
  signal RW, RA, RB : std_logic_vector (3 downto 0);
  signal COM_1, COM_2 : std_logic;
  signal OP : std_logic_vector (1 downto 0);
  signal Imm : std_logic_vector(7 downto 0);
  
  signal N : std_logic;
  signal S : std_logic;
  

begin
  
  clock: process begin
  
    for i in 0 to 5 loop
      Clk <= '0';
      wait for 5 ns;
      Clk <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process clock;
  
  
  -- initialisation 
  RegWr <= '0';
  WrEn <= '0';
  RA <= '0';
  RB <= '0';
  
end architecture test_bench;