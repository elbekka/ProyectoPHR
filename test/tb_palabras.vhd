LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_palabrasDetector IS
END tb_palabrasDetector;

ARCHITECTURE behavior OF tb_palabrasDetector IS

   signal clk,reset,detectedBit : std_logic := '0';
   signal bitInput : std_logic_vector(7 downto 0) := x"00";
   constant clk_period : time := 10 ns;
   component palabras_Detector is
    port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
    ) ;
  end component;

BEGIN
 detector: palabras_Detector port map (clk,reset,bitInput,detectedBit);
    -- Instantiate the Unit Under Test (UUT)
   --uut: is_Detector PORT MAP (
     --     clk => clk,
       --   reset => reset,
         -- bitInput => bitInput,
          --detectedBit => detectedBit
        --);

   -- Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;

   -- Stimulus process     : Apply the bits in the sequence one by one.
   stim_proc: process
   begin      
      bitInput <= x"70";             --110
      wait for clk_period;
      bitInput <= x"6F";             --1101
      wait for clk_period;
      bitInput <= x"6C";             --11011
      wait for clk_period;
      bitInput <= x"6C";           --110111
      wait for clk_period;
      bitInput <= x"61";           --1101110
      wait for clk_period;
      bitInput <= x"67";             --11011101
      wait for clk_period;
      bitInput <= x"6F";             --110111010
      wait for clk_period;
        bitInput <= x"72";             --11011101
        wait for clk_period;
        bitInput <= x"64";             --110111010
        wait for clk_period;
          bitInput <= x"61";             --11011101
      wait for clk_period;
      bitInput <= x"32";             --110111010
      wait for clk_period;
      wait;        
   end process;
-- (A:61, B:62, C:63, D:64, E:65, F:66, G:67, H:68, I:69, J:6A,
-- K:6B, L:6C, M:6D, N:6E, O:6F, P:70, Q:71, R:72, S:73, T:74, U:75, V:76, W:77, X:78, Y:79, Z:7A)
END;