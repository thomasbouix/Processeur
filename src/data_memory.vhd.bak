library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
  port( CLK : in std_logic;
        WrEn : in std_logic;
        Addr : in std_logic_vector(5 downto 0);
        DataIn : in std_logic_vector(31 downto 0);
        DataOut : out std_logic_vector(31 downto 0)
      );
end data_memory;

architecture RTL of data_memory is
  
  type table is array(63 downto 0) of std_logic_vector(31 downto 0);
  
  function init_banc return table is
  variable result : table;
  
  begin
    for i in 63 downto 0 loop
      result(i) := (others => '0');
    end loop;
    return result;
  end init_banc;
  
  signal Banc : table := init_banc;
  
begin
  
  --lecture
  DataOut <= Banc(to_integer(unsigned(Addr)));
  
  --ecriture
  process(CLK) begin
    if rising_edge(CLK) then
      if WrEn = '1' then
        Banc(to_integer(unsigned(Addr))) <= DataIn;
      end if;
    end if;      
  end process;
  
end architecture;
  
