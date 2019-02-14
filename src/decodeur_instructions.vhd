library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity decodeur_instructions is 
port(

  instruction : in std_logic_vector (31 downto 0);
  flag        : in std_logic_vector (31 downto 0);    -- Flag sur 32 bits !
  
  nPCsel      : out std_logic;
  RegWr       : out std_logic;
  ALUSrc      : out std_logic;
  PSREn       : out std_logic;
  MemWr       : out std_logic;
  WrSrc       : out std_logic;
  RegSel      : out std_logic;
  ALUCtr      : out std_logic_vector(1 downto 0));
  
end entity decodeur_instructions;

Architecture RTL of decodeur_instructions is 

  type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
  
  signal instruction_courante: enum_instruction;
    
begin

  decodage: process(instruction) begin
    
    if    (instruction(31 downto 20) = X"E3A") then   -- MOV 
      instruction_courante <= MOV;
      
    elsif (instruction(31 downto 20) = X"E61") then   -- LDR 
      instruction_courante <= LDR;   
      
    elsif (instruction(31 downto 20) = X"E28") then   -- ADDi 
      instruction_courante <= ADDi;
      
    elsif (instruction(31 downto 20) = X"E08") then   -- ADDr 
      instruction_courante <= ADDr;    

    elsif (instruction(31 downto 20) = X"E35") then   -- CMP 
      instruction_courante <= CMP;
      
    elsif (instruction(31 downto 24) = X"BA")  then   -- BLT 
      instruction_courante <= BLT;
      
    elsif (instruction(31 downto 20) = X"E60") then   -- STR 
      instruction_courante <= STR;
       
    elsif (instruction(31 downto 24) = X"EA")  then   -- BAL
      instruction_courante <= BAL;
      
    end if;
            
  end process decodage;
  
  
  generation: process (instruction_courante, flag) begin    -- question des dependances ??
  
    if    (instruction_courante = MOV) then           -- MOV
      nPCsel <= '0';
      RegWr  <= '1';
      ALUSrc <= '1';
      ALUCtr <= "01";
      PSREn  <= '0';
      MemWr  <= '0';
      WrSrc  <= '0';
      RegSel <= '0';
         
    elsif (instruction_courante = LDR) then           -- LDR
      nPCsel <= '0';
      RegWr  <= '1';
      ALUSrc <= '1';
      ALUCtr <= "00";
      PSREn  <= '0';
      MemWr  <= '0';
      WrSrc  <= '1';
      RegSel <= '0';
      
    elsif (instruction_courante = ADDi) then          -- ADDi
      nPCsel <= '0';
      RegWr  <= '1';
      ALUSrc <= '1';
      ALUCtr <= "00";
      PSREn  <= '0';
      MemWr  <= '0';
      WrSrc  <= '0';
      RegSel <= '0';
      
    elsif (instruction_courante = ADDr) then          -- ADDr 
      nPCsel <= '0';
      RegWr  <= '1';
      ALUSrc <= '0';
      ALUCtr <= "00";
      PSREn  <= '0';
      MemWr  <= '0';
      WrSrc  <= '0';
      RegSel <= '0';
      
    elsif (instruction_courante = CMP) then           -- CMP
      nPCsel <= '0';
      RegWr  <= '0';
      ALUSrc <= '1';
      ALUCtr <= "10";
      PSREn  <= '1';
      MemWr  <= '0';
      WrSrc  <= '0';
      RegSel <= '0';
      
    elsif (instruction_courante = BLT) then           -- BLT      
      if (flag = X"00000001") then  -- condition respectee
        nPCsel <= '1';
        RegWr  <= '0';
        ALUSrc <= '-';   
        ALUCtr <= "--";
        PSREn  <= '0';
        MemWr  <= '0';
        WrSrc  <= '-';
        RegSel <= '0';        
      else                  -- condition non respectee
        nPCsel <= '0';
        RegWr  <= '0';
        ALUSrc <= '-';   
        ALUCtr <= "--";
        PSREn  <= '0';
        MemWr  <= '0';
        WrSrc  <= '-';
        RegSel <= '0'; 
      end if;    
      
    elsif (instruction_courante = STR) then           -- STR
      nPCsel <= '0';
      RegWr  <= '0';
      ALUSrc <= '1';
      ALUCtr <= "00";
      PSREn  <= '0';
      MemWr  <= '1';
      WrSrc  <= '-';
      RegSel <= '1';      
      
    elsif (instruction_courante = BAL) then           -- BAL
      nPCsel <= '1';
      RegWr  <= '0';
      ALUSrc <= '-';
      ALUCtr <= "--";
      PSREn  <= '0';
      MemWr  <= '0';
      WrSrc  <= '0';
      RegSel <= '0';
          
    end if;
     
  end process;
 
end architecture RTL;

