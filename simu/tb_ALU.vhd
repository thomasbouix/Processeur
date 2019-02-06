library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ALU is
end tb_ALU;

architecture test of tb_ALU is
  
  signal OP : std_logic_vector(1 downto 0);
  signal A, B : std_logic_vector(31 downto 0);
  signal S : std_logic_vector(31 downto 0);
  signal N : std_logic;
  
begin
  
  ALU_0 : entity work.ALU port map(OP => OP, A => A, B => B, S => S, N => N);
  
  process begin
    
    --test OP = "00" Y=A+B
    OP <= "00";
    A <= std_logic_vector(to_signed(2001641,32));
    B <= std_logic_vector(to_signed(400,32));
    wait for 5 ns;
    assert to_integer(signed(S)) = 2002041 report  "erreur S addition 1" severity warning;
    assert N = '0' report "erreur N addition 1" severity warning;
    
    OP <= "00";
    A <= std_logic_vector(to_signed(-2001641,32));
    B <= std_logic_vector(to_signed(400,32));
    wait for 5 ns;
    assert to_integer(signed(S)) = -2001241 report  "erreur S addition 2" severity warning;
    assert N = '1' report "erreur N addition 2" severity warning;
    
    --test OP = "10" Y=A-B
    OP <= "10";
    A <= std_logic_vector(to_signed(10,32));
    B <= std_logic_vector(to_signed(2,32));
    wait for 5 ns;
    assert to_integer(signed(S)) = 8 report  "erreur S soustraction 1" severity warning;
    assert N = '0' report "erreur N soustraction 1" severity warning;
    
    OP <= "10";
    A <= std_logic_vector(to_signed(-10,32));
    B <= std_logic_vector(to_signed(2,32));
    wait for 5 ns;
    assert to_integer(signed(S)) = -12 report  "erreur S sosutraction 2" severity warning;
    assert N = '1' report "erreur N soustraction 2" severity warning;
    
    --test OP = "01" Y=B
    OP <= "01";
    A <= std_logic_vector(to_signed(1,32));
    B <= std_logic_vector(to_signed(123456789,32));
    wait for 5 ns;
    assert to_integer(signed(S)) = 123456789 report  "erreur S sur Y = B 1" severity warning;
    assert N = '0' report "erreur N sur Y = B 1" severity warning;
    
    OP <= "01";
    A <= std_logic_vector(to_signed(1,32));
    B <= std_logic_vector(to_signed(-123456789,32));
    wait for 5 ns;
    assert to_integer(signed(S)) = -123456789 report  "erreur S sur Y = B 2" severity warning;
    assert N = '1' report "erreur N Y = B 2" severity warning;
    
    --test OP = "11" Y=A
    OP <= "11";
    A <= std_logic_vector(to_signed(123456789,32));
    B <= std_logic_vector(to_signed(1,32));
    wait for 5 ns;
    assert to_integer(signed(S)) = 123456789 report  "erreur S sur Y = A 1" severity warning;
    assert N = '0' report "erreur N addition 0" severity warning;
    
    
    OP <= "11";
    A <= std_logic_vector(to_signed(-123456789,32));
    B <= std_logic_vector(to_signed(1,32));
    wait for 5 ns;
    assert to_integer(signed(S)) = -123456789 report  "erreur S sur Y = A 2" severity warning;
    assert N = '1' report "erreur N Y = A 2" severity warning;
    
    report "End of test. Verify that no error was reported.";
		wait;
		
		end process;
		
	end architecture;