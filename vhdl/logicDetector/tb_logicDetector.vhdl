
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_logicDetector IS
END tb_logicDetector;

ARCHITECTURE behavior OF tb_logicDetector IS

signal clk,detectedBit,reset : std_logic := '0';
signal bitInput : std_logic_vector(7 downto 0) := x"00";
signal ErrInic,numErrores : integer:=0;
constant clk_period : time := 10 ns;
component logic_Detector is
port (
  clk: in std_logic;
  reset : in std_logic;
  bitInput : in std_logic_vector(7 downto 0);
  ErrInic  : in integer :=0;
  detectedBit : out std_logic ;-- '1' si ha detectado la secuencia.
  numErrores : out integer:=0 
) ;
end component;

BEGIN
detector: logic_Detector port map (clk,reset,bitInput,ErrInic,detectedBit,numErrores);

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
bitInput <= x"20";             --space
wait for clk_period;
bitInput <= x"78";             --d
wait for clk_period;
bitInput <= x"6f";             --d
wait for clk_period;
bitInput <= x"72";             --d
wait for clk_period;
bitInput <= x"20";             --space
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
bitInput <= x"20";             --space
wait for clk_period;
bitInput <= x"6e";             --d
wait for clk_period;
bitInput <= x"6f";             --d
wait for clk_period;
bitInput <= x"72";             --d
wait for clk_period;
bitInput <= x"20";             --space
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
bitInput <= x"20";             --space
wait for clk_period;
bitInput <= x"61";             --d
wait for clk_period;
bitInput <= x"6f";             --d
wait for clk_period;
bitInput <= x"6e";             --d
wait for clk_period;
bitInput <= x"64";             --d
wait for clk_period;
bitInput <= x"20";             --space
wait for clk_period;

  wait;        
end process;



END;

