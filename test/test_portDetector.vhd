
library ieee;

use ieee.std_logic_1164.all;



entity test_portDetection is

end entity;



architecture behavior of test_portDetection is

     signal clk,reset,detectedBit : std_logic := '0';

     signal bitInput : std_logic_vector(7 downto 0) := x"00";

     constant clk_period : time := 10 ns;

     component port_DetectorESpacio is

     port (

      clk: in std_logic;

     reset : in std_logic;

      bitInput : in std_logic_vector(7 downto 0);

      detectedBit : out std_logic -- '1' si ha detectado la secuencia.

    ) ;

  end component;



BEGIN

 detector:  port_DetectorESpacio port map (clk,reset,bitInput,detectedBit);



clk_process :process

   begin

        clk <= '0';

        wait for clk_period/2;

        clk <= '1';

        wait for clk_period/2;

   end process;

   



   stim_proc: process

   begin       

      bitInput <= x"6F";             --P

      wait for clk_period;

      bitInput <= x"6E";             --O

      wait for clk_period;

      bitInput <= x"71";             --R

      wait for clk_period;

	bitInput <= x"73";             --T

      wait for clk_period;
       
         bitInput<= x"32";      --Espacio

       wait for clk_period;


      wait;        

   end process;


END;