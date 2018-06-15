LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_clausEntity IS
END tb_clausEntity;

ARCHITECTURE behavior OF tb_clausEntity IS

   signal clk,detectedBit,reset : std_logic := '0';
   signal bitInput : std_logic_vector(7 downto 0) := x"00";
<<<<<<< HEAD

=======
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
   constant clk_period : time := 10 ns;
   component entityClaus is
    port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
<<<<<<< HEAD
      detectedBit : out std_logic-- '1' si ha detectado la secuencia.
     
=======
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
    ) ;
  end component;

BEGIN
 detector: entityClaus port map (clk,reset,bitInput,detectedBit);
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
   bitInput <= x"65";            
   wait for clk_period;
   bitInput <= x"6e";             
   wait for clk_period;
   bitInput <= x"74";             
   wait for clk_period;
   bitInput <= x"69";
   wait for clk_period;
   bitInput <= x"74";            
   wait for clk_period;
<<<<<<< HEAD
   bitInput <= x"79";  
   wait for clk_period;
   bitInput <= x"20";       
   wait for clk_period;
   bitInput <= x"69";             
   wait for clk_period;
   bitInput <= x"63";             
   wait for clk_period;
   bitInput <= x"20";       
=======
   bitInput <= x"79";            
   wait for clk_period;
   bitInput <= x"20";             
   wait for clk_period;
   bitInput <= x"64";             
   wait for clk_period;
   bitInput <= x"20";
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
   wait for clk_period;
   bitInput <= x"69";             
   wait for clk_period;
   bitInput <= x"73";             
   wait for clk_period;
   bitInput <= x"20";            
   wait for clk_period;
   bitInput <= x"65";             
   wait for clk_period;
   bitInput <= x"6e";             
   wait for clk_period;
   bitInput <= x"64";
   wait for clk_period;
   bitInput <= x"20";            
   wait for clk_period;
   bitInput <= x"65";            
   wait for clk_period;
   bitInput <= x"6e";             
   wait for clk_period;
   bitInput <= x"74";             
   wait for clk_period;
   bitInput <= x"69";
   wait for clk_period;
   bitInput <= x"74";            
   wait for clk_period;
   bitInput <= x"79";            
   wait for clk_period;
   bitInput <= x"20";             
   wait for clk_period;
   bitInput <= x"3b";
<<<<<<< HEAD
   wait for clk_period;
=======
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
      wait;                
   end process;

END;