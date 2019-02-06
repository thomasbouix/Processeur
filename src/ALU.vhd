Library IEEE;

use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU is port(
  A, B : in std_logic_vector(31 downto 0);
  OP : in std_logic_vector(1 downto 0);
  S : out std_logic_vector(31 downto 0);
  N : out std_logic
  );
end entity ALU;

architecture RTL of ALU is 

  signal res: signed(31 downto 0);

begin
  
  process(OP, A, B) begin
    
    if OP = "00" then
      res <= signed(A) + signed(B);
    
    elsif OP = "01" then
      res <= signed(B);
      
    elsif OP = "10" then
      res <= signed(A) - signed(B);
      
    elsif OP = "11" then
      res <= signed(A);
      
    else
      res <= (others => '-');
    end if;
  end process;
  
  S <= std_logic_vector(res);
  N <= res(31);
  
end architecture;
