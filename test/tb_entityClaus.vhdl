LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_entityClaus IS
END tb_entityClaus;

ARCHITECTURE behavior OF tb_entityClaus IS

   signal clk,detectedBit,reset : std_logic := '0';
   signal bitInput : std_logic_vector(7 downto 0) := x"00";
   constant clk_period : time := 10 ns;
   component entityClaus is
    port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
    ) ;
  end component;

BEGIN
 entityClausDetector: entityClaus port map (clk,reset,bitInput,detectedBit);
   -- Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;

   -- Stimulus process : Apply the bits in the sequence one by one.
   stim_proc: process
   begin       
      bitInput <= x"65";           --E  
      wait for clk_period;
      bitInput <= x"6E";           --EN
      wait for clk_period;
      bitInput <= x"74";           --ENT
      wait for clk_period;
      bitInput <= x"69";           --ENTI
      wait for clk_period;
      bitInput <= x"74";           --ENTIT
      wait for clk_period;
      bitInput <= x"79";           --ENTITY
      wait for clk_period;
      bitInput <= x"20";           --ENTITY SPACE
      wait for clk_period;
      bitInput <= x"65";           --ENTITY SPACE E 
      wait for clk_period;         
      bitInput <= x"6E";           --ENTITY SPACE EN 
      wait for clk_period;
        bitInput <= x"64";         --ENTITY SPACE END  
      wait for clk_period;
      bitInput <= x"20";           --ENTITY SPACE END SPACE
      wait for clk_period;
      bitInput <= x"3B";           --ENTITY SPACE END SPACE ;     
      wait for clk_period;
      wait;        
   end process;

END;