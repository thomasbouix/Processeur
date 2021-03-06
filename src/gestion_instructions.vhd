library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity gestion_instructions is port(

  clk    : in std_logic;
  rst    : in std_logic;
  nPCsel : in std_logic;
  offset : in std_logic_vector (23 downto 0);
  
  instruction : out std_logic_vector (31 downto 0));
  
end entity gestion_instructions;

Architecture RTL of gestion_instructions is 

  signal extender_out : std_logic_vector (31 downto 0);
  signal bus_adresse  : std_logic_vector (31 downto 0);
  signal mux_out      : std_logic_vector (31 downto 0);
 
  
  
begin
  
  extender : entity work.extension_de_signe(RTL) generic map(N => 24)
                                                 port map   (E => offset,
                                                             S => extender_out);
                                                              
  
  multiplexeur : entity work.mux_PC(RTL) port map (nPCsel     => nPCsel,
                                                   adresse_in => bus_adresse,
                                                   offset     => extender_out,
                                                   adresse_out=> mux_out);
                                                
  PC : entity work.PC_register(RTL) port map (clk  => clk,
                                              rst  => rst,
                                              Win  => mux_out,
                                              Wout => bus_adresse);
                                            
  memory : entity work.instruction_memory(RTL) port map (PC          => bus_adresse,
                                                         Instruction => instruction);
                                                
end Architecture RTL; 


                                                                                                                 
   
