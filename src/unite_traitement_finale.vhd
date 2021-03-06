Library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

Entity unite_traitement_finale is port(

  Clk, RegWr : in std_logic;
  RW, RA, RB  : in std_logic_vector (3 downto 0);
  COM_1 : in std_logic;
  OP : in std_logic_vector (1 downto 0);
  WrEn : in std_logic;
  COM_2 : in std_logic;
  Imm : in std_logic_vector (7 downto 0);
  
  N  : out std_logic_vector (31 downto 0); -- N sur 32 bits !
  S  : out std_logic_vector (31 downto 0));
  
end entity unite_traitement_finale;

Architecture RTL of unite_traitement_finale is 

  signal busA, busB  : std_logic_vector (31 downto 0);
  signal extender_out: std_logic_vector (31 downto 0);
  signal mux_21_out  : std_logic_vector (31 downto 0);
  signal ALU_out     : std_logic_vector (31 downto 0);
  signal data_out    : std_logic_vector (31 downto 0);
  signal busW        : std_logic_vector (31 downto 0);

begin
  
  S <= busW;  
  
  register_bank : entity work.register_bench port map (CLK=> Clk,
                                                       W  => busW,
                                                       WE => RegWr,
                                                       RW => RW,
                                                       RA => RA,
                                                       RB => RB,
                                                       A  => busA,
                                                       B  => busB);
                                                       
  imm_extender  : entity work.extension_de_signe generic map (N => 8)
                                                 port    map (E => Imm,
                                                              S => extender_out);                                                      
                                                       
                                                       
  mux_21        : entity work.multiplexeur_2 generic map (N   => 32)
                                             port    map (A   => busB,
                                                          B   => extender_out,
                                                          COM => COM_1,
                                                          S   => mux_21_out);
                                                          
  mux_22        : entity work.multiplexeur_2 generic map (N   => 32)
                                             port    map (A   => ALU_out,
                                                          B   => data_out,
                                                          COM => COM_2,
                                                          S   => busW);                                                       
                                                           
  UAL           : entity work.ALU            port map (A  => busA,
                                                       B  => mux_21_out,
                                                       OP => OP,
                                                       S  => ALU_out,
                                                       N  => N);
                                                       
  data_memory   : entity work.data_memory    port map (CLK    => Clk, 
                                                       WrEn   => WrEn,
                                                       Addr   => ALU_out (5 downto 0),
                                                       DataIn => busB,
                                                       DataOut=> data_out);
  
end Architecture RTL;


