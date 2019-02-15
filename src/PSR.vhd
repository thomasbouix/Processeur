library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PSR is port(
  DATAIN : in std_logic_vector(31 downto 0);    -- FLAG sur 32 bits !
  RST, CLK, WE : in std_logic;
  DATAOUT : out std_logic_vector(31 downto 0)
  );
end PSR;

architecture RTL of PSR is
  
  signal data : std_logic_vector(31 downto 0);
  
begin
  
  DATAOUT <= data;
  
  process(RST, CLK) begin
    
    if RST = '1' then
      data <= (others => '0');
    end if;
    
    if rising_edge(CLK) then
      if WE = '1' then
        data <= DATAIN;
      end if;
    end if;
    
  end process;
  
end architecture;