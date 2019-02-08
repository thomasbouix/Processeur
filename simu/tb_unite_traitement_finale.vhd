library ieee;
USE ieee.std_logic_1164.all;

Entity tb_unite_traitement_finale is port(

  OK : out boolean := TRUE);

end entity tb_unite_traitement_finale;

Architecture test_bench of tb_unite_traitement_finale is 

  -- 10 signaux en entree
  signal Clk : std_logic;
  signal RegWr, WrEn : std_logic;
  signal RW, RA, RB : std_logic_vector (3 downto 0);
  signal COM_1, COM_2 : std_logic;
  signal OP : std_logic_vector (1 downto 0);
  signal Imm : std_logic_vector(7 downto 0);
  
  -- 2 signaux en sortie
  signal N : std_logic;
  signal S : std_logic_vector (31 downto 0);
  

begin

  unite_traitement: entity work.unite_traitement_finale(RTL) port map (Clk   => Clk, 
                                                                  RegWr => RegWr,  
                                                                  RW    => RW,
                                                                  RA    => RA,
                                                                  RB    => RB,
                                                                  COM_1 => COM_1,
                                                                  OP    => OP,
                                                                  WrEn  => WrEn, 
                                                                  COM_2 => COM_2,
                                                                  Imm   => Imm,
                                                                  N     => N,
                                                                  S     => S);
                                                                  
  clock: process begin
  
    for i in 0 to 5 loop
      Clk <= '0';
      wait for 5 ns;
      Clk <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process clock;
  
  test_bench: process begin
  
    -- initialisation 
    COM_1 <= '0';           -- operation avec deux registres
    COM_2 <= '0';           -- affichage sortie ALU
    Imm <= (others => '0'); -- immediat a zero
    
    -- R(1) = R(15) 
    RegWr <= '1';           -- ecriture en registre
    WrEn <= '0';            -- ecriture en memoire
    OP <= "01";             -- Y = R(15)
    RW <= "0001";           -- ecriture sur R(1)
    RA <= "0001";           -- RA = R(1)
    RB <= "1111";           -- RB = R(15)
    wait for 5 ns;
  
    wait;
  end process test_bench; 
  
end architecture test_bench;