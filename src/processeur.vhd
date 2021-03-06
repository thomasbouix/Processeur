library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processeur is port(
  clk : in std_logic;
  rst_PC_extender, rst_PSR : in std_logic
  );
end processeur;

architecture RTL of processeur is

  signal nPCsel, RegWr, ALUSrc, MemWr, WrSrc : std_logic;
  signal ALUCtr : std_logic_vector (1 downto 0);
  signal RW, RA, RB : std_logic_vector (3 downto 0);
  signal instruction, flag : std_logic_vector(31 downto 0);
  
begin
  
  gestion_instruction_0 : entity work.gestion_instructions port map (clk         => clk, 
                                                                     rst         => rst_PC_extender, 
                                                                     nPCsel      => nPCsel, 
                                                                     offset      => instruction(23 downto 0),
                                                                     instruction => instruction
                                                                    );
  
  unite_traitement_finale_0 : entity work.unite_traitement_finale port map(Clk   => clk, 
                                                                           RegWr => RegWr,
                                                                           RW    => RW, 
                                                                           RA    => RA, 
                                                                           RB    => RB,
                                                                           COM_1 => ALUSrc,  
                                                                           OP    => ALUCtr,
                                                                           WrEn  => MemWr,
                                                                           COM_2 => WrSrc,
                                                                           Imm   => instruction(7 downto 0),
                                                                           N     => flag
                                                                          );
                                                                        
  unite_controle_0 : entity work.unite_controle port map ( instruction=> instruction,
                                                           flag       => flag,
                                                           clk        => clk,
                                                           rst_PSR    => rst_PSR,
                                                           nPCsel     => nPCsel,
                                                           RegWr      => RegWr,
                                                           ALUSrc     => ALUSrc,
                                                           MemWr      => MemWr,
                                                           WrSrc      => WrSrc,
                                                           ALUCtr     => ALUCtr,
                                                           Ra         => RA,
                                                           Rw         => RW,
                                                           Rb         => RB
                                                           );
end architecture RTL;                                  
                                                           