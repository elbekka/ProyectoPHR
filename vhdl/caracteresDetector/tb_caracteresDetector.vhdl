LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_charDetector IS
END tb_charDetector;

ARCHITECTURE behavior OF tb_charDetector IS

   signal clk,detectedBit,reset : std_logic := '0';
   signal bitInput : std_logic_vector(7 downto 0) := x"00";
   constant clk_period : time := 10 ns;
   component charDetector is
    port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
    ) ;
  end component;

BEGIN
 detector: charDetector port map (clk,reset,bitInput,detectedBit);
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
   bitInput <= x"69";            
   wait for clk_period;
   bitInput <= x"73";             
   wait for clk_period;
   bitInput <= x"20";             
   wait for clk_period;
   bitInput <= x"69";            
   wait for clk_period;
   bitInput <= x"73";             
   wait for clk_period;
   bitInput <= x"20";             
   wait for clk_period;
   bitInput <= x"70";            
   wait for clk_period;
   bitInput <= x"73";             
   wait for clk_period;
   bitInput <= x"20";             
   wait for clk_period;
      wait;                
   end process;

END;