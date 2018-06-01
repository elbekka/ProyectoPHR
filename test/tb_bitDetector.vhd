LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_bitDetecctor IS
END tb_bitDetecctor;

ARCHITECTURE behavior OF tb_bitDetecctor IS

   signal clk,reset,detectedBit : std_logic := '0';
   signal bitInput : std_logic_vector(7 downto 0) := x"00";
   constant clk_period : time := 10 ns;
   component bit_Detector is
    port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
    ) ;
  end component;

BEGIN
 detector: bit_Detector port map (clk,reset,bitInput,detectedBit);
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
      bitInput <= x"62";             --110
      wait for clk_period;
      bitInput <= x"69";             --1101
      wait for clk_period;
      bitInput <= x"74";             --11011
      wait for clk_period;
      bitInput <= x"32";           --110111
      wait for clk_period;
      bitInput <= x"10";           --1101110
      wait for clk_period;
      bitInput <= x"61";             --11011101
      wait for clk_period;
      bitInput <= x"03";             --110111010
      wait for clk_period;
        bitInput <= x"00";           --1101110101
      wait for clk_period;
      wait;        
   end process;

END;