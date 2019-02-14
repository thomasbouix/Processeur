library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity unite_traitement_tb is port(

  OK : out boolean := TRUE);
  
end Entity unite_traitement_tb;

architecture test_bench of unite_traitement_tb is 

  signal Clk_i, WE_i: std_logic;
  signal RW_i, RA_i, RB_i : std_logic_vector (3 downto 0);
  signal OP_i : std_logic_vector (1 downto 0);
  signal N_i  : std_logic;
  signal S_i  : std_logic_vector (31 downto 0);

  begin

  traitement_unity: entity work.unite_traitement(RTL) port map (Clk => Clk_i, WE => WE_i , RW => RW_i , RA => RA_i, RB => RB_i, OP => OP_i, N => N_i , S => S_i); 
    
  clock: process begin
    Clk_i <= '0';
    wait for 5 ns;
    Clk_i <= '1';
    wait for 5 ns;
  end process clock;
  
  test: process begin
  
    -- initialisation
    WE_i <= '1'; 
    RW_i <= (others => '0');
    RA_i <= (others => '0');
    RB_i <= (others => '0');
    OP_i <= (others => '0');
    wait for 1 ns;
    
    -- R(1) <= R(15) (=48) 
    OP_i <= "11";      -- Y <= RA  
    RA_i <= "1111";    -- RA = R(15) ; R(15) initialise a 48 de base
    RB_i <= "0001";    -- RB = R(1)
    RW_i <= "0001";    -- R(1) <= R(15)
    wait for 1 ns;     -- permet au test de fonctionner 
    if unsigned(S_i) /= 48 then 
      OK <= FALSE;
    end if;
    
    -- R(1) <= R(1) + R(15) (=96)
    OP_i <= "00";      -- R(1) <= R(15) + R(1)     R(15) = 48; R(1) = 48  
    RW_i <= "0001";    -- R(1)       
    wait for 5 ns;
    if signed(S_i) /= 96 then
      OK <= FALSE;
    end if;
    wait for 10 ns;
    
    -- R(2) <= R(1) + R(15) (=144)  
    OP_i <= "00";      -- Y <= R(1)=96 + R(15)=48 
    RW_i <= "0010";    -- R(2)
    wait for 1 ns;
    if signed(S_i) /= 144 then 
      OK <= FALSE;
    end if;
    wait for 10 ns;
    
    -- R(3) = R(1) - R(15)
    RA_i <= "0001";
    RB_i <= "1111";
    wait for 1 ns;
    OP_i <= "10";
    RW_i <= "0011";   -- on ecrit sur R(3)
    wait for 1 ns;
    if signed(S_i) /= 48 then
      OK <= FALSE;
    end if;
    wait for 10 ns;
     
    -- R(5) = R(7) - R(15)
    RA_i <= "0111";   -- RA = R(7)
    wait for 1 ns;
    RW_i <= "0101";   -- on ecrit sur R(5)
    wait for 1 ns;
    if signed(S_i) /= -48 then
      OK <= FALSE;
    end if;
    wait for 10 ns;
         
    report "fin du test, assurez vous que OK = TRUE";
    wait;
    
  end process;   
end architecture; 



  