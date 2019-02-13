library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity PC_register is port(

  clk : in std_logic;
  rst : in std_logic;
  Win : in std_logic_vector (31 downto 0);
  Wout: out std_logic_vector (31 downto 0));
  
end Entity PC_register;

Architecture RTL of PC_register is 

  signal data: std_logic_vector (31 downto 0);

begin
  
  process(clk, rst) begin
    
    if (rst = '1') then
      data <= (others => '0');
    end if;
    
    if (rising_edge(clk)) then
      data <= Win;
    end if;
    
  end process;
  
  Wout <= data;
  
end Architecture RTL;


  
  