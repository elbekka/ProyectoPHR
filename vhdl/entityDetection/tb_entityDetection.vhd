LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_entityDetection IS
END tb_entityDetection;

ARCHITECTURE behavior OF tb_entityDetection IS

   signal clk,detectedBit,reset : std_logic := '0';
   signal numErrores,ErrInic : integer :=0;
   signal bitInput : std_logic_vector(7 downto 0) := x"00";
   constant clk_period : time := 10 ns;
   component entityDetection is
    port (
      ErrInic  : in integer :=0;
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic; -- '1' si ha detectado la secuencia.
      numErrores : out integer
    ) ;
  end component;

BEGIN
 detector: entityDetection port map (ErrInic,clk,reset,bitInput,detectedBit,numErrores);
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
      wait for clk_period;
      bitInput <= x"79";             --y
      wait for clk_period;
      bitInput <= x"20";            --space
      wait for clk_period;
      wait;              
   end process;

END;