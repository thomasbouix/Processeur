library ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
  
    for i in 0 to 6 loop
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
    
    -- R(1) = R(15) = 48 // copie de valeur registre - registre
    RegWr <= '1';           -- ecriture en registre
    WrEn <= '0';            -- ecriture en memoire
    OP <= "01";             -- Y = R(15)
    RW <= "0001";           -- ecriture sur R(1)
    RA <= "0001";           -- RA = R(1)
    RB <= "1111";           -- RB = R(15)
    wait for 6 ns;
    if unsigned(S) /= 48 then
      OK <= FALSE;
    end if;
  
    -- R(2) = R(1) + R(15) // R(2) = 96 // addition de deux registres
    
    RW <= "0010";           -- ecriture sur R(2)
    OP <= "00";             -- operateur addition
    wait for 10 ns;         -- 16ns a la fin du wait 
    if unsigned(S) /= 96 then
      OK <= FALSE;
    end if;
    
    -- R(3) = R(15) + 10 // 48 + 10 // addition registre - immediat
    Imm  <= "00001010";     -- I = 10
    RW   <= "0011";
    wait for 1 ns;          -- 17 ns apres le wait
    COM_1<= '1';            -- R(1) + I  
    wait for 10 ns;         -- 27 ns apres le wait
    if  unsigned(S) /= 58 then
      OK <= FALSE;
    end if;
    
    -- R(3) = R(3) - R(15) // soustraction registre - registre
    RA    <= "0011";        -- RA = R(3) = 58
    RB    <= "1111";        -- RB = R(15) (deja le cas) = 48
    RW    <= "0011";        -- RW = R(3)  (deja le cas)
    COM_1 <= '0';           -- operation entre des registres
    OP    <= "10";          -- operateur soustraction
    wait for 7 ns;          -- 30 ns apres le wait, soit 5 ns avant le front montant
    if unsigned(S) /= 10 then
      OK <= FALSE;
    end if;
    
    -- R(3) = R(3) - 10 // 10 - 10 // soustraction registre - immediat
    wait for 6 ns;          -- 36 ns 
    RW    <= "0011";        -- ecriture sur R3
    RA    <= "0011";        -- RA = R(3)
    OP    <= "10";          -- Y = A - B
    Imm   <= "00001010";    -- Imm = 10
    COM_1 <= '1';           -- operation avec immediat 
    wait for 1 ns;
    if unsigned(S) /= 0 then
      OK <= FALSE;
    end if;    
    wait for 10 ns;         -- 46 ns
        
    -- ecriture d'un registre en memoire
    -- ecriture de R(15) en M(0)
    RegWr <= '0';           -- on stoppe l'ecriture registre
    WrEn <= '1';            -- on autorise l'ecriture en memoire
    RA <= "0011";           -- RA = R(3), le registre contenant l'adresse memoire a ecrire
    RB <= "1111";           -- RB = R(15), le registre contentant la donnee a ecrire
    OP <= "11";             -- Y <= RA
    wait for 10 ns;         -- 56 ns, juste apres le front montant et donc l'ecriture en memoire
    WrEn <= '0';   
    
    -- lecture d'un mot memoire dans un registre
    -- R(5) = M(0)
    RegWr <= '1';           -- autorisation d'ecriture en registre
    RW <= "0101";           -- ecriture sur R(5)    
    COM_2 <= '1';           -- lecture de la memoire en sortie
    RA <= "0011";           -- R(3) contient bien 0, l'adresse de la case memoire a lire (deja le cas)
    OP <= "11";             -- Y = RA (deja le cas)
    wait for 10 ns;
                 
    wait;
  end process test_bench; 
  
end architecture test_bench;