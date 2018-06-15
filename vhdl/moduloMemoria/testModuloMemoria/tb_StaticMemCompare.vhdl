
library ieee;
use ieee.std_logic_1164.all;

entity tb_StaticMemCompare is
end entity;

architecture dataFlow of tb_StaticMemCompare is
 signal charInput : std_logic_vector(7 downto 0);
 signal isCorrect : std_logic;
<<<<<<< HEAD
 signal address : integer range 0 to 30 ;
    component memCompare
    port (   charInput : in std_logic_vector(7 downto 0);
             address   : in integer range 0 to 30 ;
=======
 signal address : integer range 0 to 25 ;
    component memCompare
    port (   charInput : in std_logic_vector(7 downto 0);
             address   : in integer range 0 to 25 ;
>>>>>>> 3b763639ed0bad0f997d313038832aae96ef71db
             isCorrect : out std_logic
    );
    end component;

begin
U1: memCompare port map(charInput,address,isCorrect);
charInput <= "00000000" after 0 ns , "00001000" after 1 ns ,
             "00000000" after 2 ns , x"61" after 3 ns , x"62" after 6 ns , x"11" after 7 ns;
address <= 0 after 0 ns , 1 after 5 ns , 1 after 6 ns , 20 after 7 ns ;
end dataFlow ;
