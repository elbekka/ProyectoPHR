LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_entityDetection IS
END tb_entityDetection;

ARCHITECTURE behavior OF tb_entityDetection IS

   signal clk,detectedBit,reset : std_logic := '0';
   signal bitInput : std_logic_vector(7 downto 0) := x"00";
   constant clk_period : time := 10 ns;
   component entityDetection is
    port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
    ) ;
  end component;

BEGIN
 detector: entityDetection port map (clk,reset,bitInput,detectedBit);
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

      bitInput <= x"65";             --e
      wait for clk_period;
      bitInput <= x"6E";             --n
      wait for clk_period;
      bitInput <= x"74";             --t
      wait for clk_period;
      bitInput <= x"69";             --i
      wait for clk_period;
      bitInput <= x"74";             --t
      wait for clk_period;
      bitInput <= x"79";             --y
      wait for clk_period;
      bitInput <= x"20";            --space
      wait for clk_period;
      bitInput <= x"74";             --t
      wait for clk_period;
      bitInput <= x"79";             --y
      wait for clk_period;
      bitInput <= x"74";             --t
      wait for clk_period;
      bitInput <= x"79";             --y
      wait for clk_period;
      bitInput <= x"65";             --e
      wait for clk_period;
      bitInput <= x"6E";             --n
      wait for clk_period;
      bitInput <= x"74";             --t
      wait for clk_period;
      bitInput <= x"69";             --i
      wait for clk_period;
      bitInput <= x"74";             --t
      wait for clk_period;
      bitInput <= x"79";             --y
      wait for clk_period;
      bitInput <= x"20";            --space
      wait for clk_period;
      bitInput <= x"65";             --e
      wait for clk_period;
      bitInput <= x"6E";             --n
      wait for clk_period;
      bitInput <= x"74";             --t
      wait for clk_period;
      bitInput <= x"69";             --i
      wait for clk_period;
      bitInput <= x"74";             --t
      wait for clk_period;
      bitInput <= x"79";             --y
      wait for clk_period;
      bitInput <= x"20";            --space
<<<<<<< HEAD
      wait for clk_period;
      bitInput <= x"79";             --y
      wait for clk_period;
      bitInput <= x"20";            --space
      wait for clk_period;
      wait;              
=======
      wait;                
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
   end process;

END;