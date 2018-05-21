library ieee;
use ieee.std_logic_1164.all;

entity test_entityDetection is
end entity;

architecture behavior of test_entityDetection is
     signal clk,reset,detectedBit : std_logic := '0';
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
      wait;        
   end process;

END;