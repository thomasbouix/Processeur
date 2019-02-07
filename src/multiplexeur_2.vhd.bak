library ieee;
use ieee.std_logic_1164.all;

entity multiplexeur_2 is
  generic( N : integer);
  port ( A, B : in std_logic_vector(N-1 downto 0);
            COM : in std_logic;
            S : out std_logic_vector(N-1 downto 0)
          );
end multiplexeur_2;

architecture RTL of multiplexeur_2 is
  begin
  
  process(A ,B, COM) begin
    
    case COM is
    when '0' =>
      S <= A;
    when '1' =>
      S <= B;
    when others =>
      S <= (others => '-');
    end case;
    
  end process;
  
end architecture; 