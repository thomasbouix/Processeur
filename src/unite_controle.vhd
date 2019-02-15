library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unite_controle is port(
  instruction : in std_logic_vector(31 downto 0);
  flag        : in std_logic_vector(31 downto 0);
  clk         : in std_logic;
  rst_PSR     : in std_logic;
  
  nPCsel      : out std_logic;
  RegWr       : out std_logic;
  ALUSrc      : out std_logic;
  MemWr       : out std_logic;
  WrSrc       : out std_logic;
  ALUCtr      : out std_logic_vector (1 downto 0);
  
  Ra          : out std_logic_vector (3 downto 0);
  Rw          : out std_logic_vector (3 downto 0);
  Rb          : out std_logic_vector (3 downto 0)); 
  );
end unite_controle;

architecture RLT of unite_controle is
  
  signal RegSel, PSREn      : std_logic;
  signal Rd_multi, Rm_multi : std_logic_vector(3 downto 0);
  signal flag_sortie_PSR    : std_logic_vector(31 downto 0);
  
begin
  
  entity decodeur_instruction_0 : entity work.decodeur_instruction port map(instruction => instruction,
                                                                            flag => flag_sortie_PSR,
                                                                            nPCsel => nPCsel,
                                                                            RegWr => RegWR,
                                                                            ALUSrc => ALUSrc,
                                                                            PSREn => PSREn,
                                                                            MemWr => MemWr,
                                                                            WrSrc => WrSrc,
                                                                            RegSel => RegSel,
                                                                            ALUCtr => ALUCtr,
                                                                            Rn => Ra,
                                                                            Rd => Rd_multi,
                                                                            Rm => Rm_multi
                                                                          );
                                                                          
  entity PSR_0 : entity work.PSR port map ( DATAIN => flag,
                                            RST => rst_PSR, 
                                            CLK => clk, 
                                            WE => PSREn,
                                            DATAOUT => flag_sortie_PSR;
                                          );
                                          
  entity multiplexeur_0 : entity work.multiplexeur_2 port map(A => Rm_multi,
                                                              B => Rd_multi,
                                                              COM => Reg_sel,
                                                              S => Rb
                                                            );
  
end architecture;