
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_logicDetector IS
END tb_logicDetector;

ARCHITECTURE behavior OF tb_logicDetector IS

signal clk,detectedBit,reset : std_logic := '0';
signal bitInput : std_logic_vector(7 downto 0) := x"00";
<<<<<<< HEAD
signal ErrInic,numErrores : integer:=0;
=======
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
constant clk_period : time := 10 ns;
component logic_Detector is
port (
  clk: in std_logic;
  reset : in std_logic;
  bitInput : in std_logic_vector(7 downto 0);
<<<<<<< HEAD
  ErrInic  : in integer :=0;
  detectedBit : out std_logic ;-- '1' si ha detectado la secuencia.
  numErrores : out integer:=0 
=======
  detectedBit : out std_logic -- '1' si ha detectado la secuencia.
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
) ;
end component;

BEGIN
<<<<<<< HEAD
detector: logic_Detector port map (clk,reset,bitInput,ErrInic,detectedBit,numErrores);
=======
detector: logic_Detector port map (clk,reset,bitInput,detectedBit);
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db

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
bitInput <= x"61";             --a
wait for clk_period;
bitInput <= x"6e";             --n
wait for clk_period;
bitInput <= x"64";             --d
wait for clk_period;
bitInput <= x"20";             --space
wait for clk_period;
bitInput <= x"70";             --d
wait for clk_period;
bitInput <= x"6f";             --d
wait for clk_period;
bitInput <= x"72";             --d
wait for clk_period;
<<<<<<< HEAD
bitInput <= x"20";             --space
=======
bitInput <= x"20";             --d
wait for clk_period;
bitInput <= x"70";             --d
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
wait for clk_period;
bitInput <= x"78";             --d
wait for clk_period;
bitInput <= x"6f";             --d
wait for clk_period;
bitInput <= x"72";             --d
wait for clk_period;
<<<<<<< HEAD
bitInput <= x"20";             --space
=======
bitInput <= x"20";             --d
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
wait for clk_period;
bitInput <= x"70";             --d
wait for clk_period;
bitInput <= x"6e";             --d
wait for clk_period;
bitInput <= x"61";             --d
wait for clk_period;
bitInput <= x"6e";             --d
wait for clk_period;
bitInput <= x"64";             --d
wait for clk_period;
<<<<<<< HEAD
bitInput <= x"20";             --space
=======
bitInput <= x"20";             --d
wait for clk_period;
bitInput <= x"70";             --d
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
wait for clk_period;
bitInput <= x"6e";             --d
wait for clk_period;
bitInput <= x"6f";             --d
wait for clk_period;
bitInput <= x"72";             --d
wait for clk_period;
<<<<<<< HEAD
bitInput <= x"20";             --space
=======
bitInput <= x"20";             --d
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
wait for clk_period;
bitInput <= x"70";             --d
wait for clk_period;
bitInput <= x"78";             --d
wait for clk_period;
bitInput <= x"6e";             --d
wait for clk_period;
bitInput <= x"6f";             --d
wait for clk_period;
bitInput <= x"72";             --d
wait for clk_period;
<<<<<<< HEAD
bitInput <= x"20";             --space
wait for clk_period;
bitInput <= x"61";             --d
=======
bitInput <= x"20";             --d
wait for clk_period;
bitInput <= x"70";             --d
wait for clk_period;
bitInput <= x"6e";             --d
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
wait for clk_period;
bitInput <= x"6f";             --d
wait for clk_period;
bitInput <= x"6e";             --d
wait for clk_period;
bitInput <= x"64";             --d
wait for clk_period;
<<<<<<< HEAD
bitInput <= x"20";             --space
=======
bitInput <= x"20";             --d
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
wait for clk_period;

  wait;        
end process;



END;

