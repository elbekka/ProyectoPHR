
library ieee;
use ieee.std_logic_1164.all;

entity tb_StaticMemCompare is
end entity;

architecture dataFlow of tb_StaticMemCompare is
 signal charInput : std_logic_vector(7 downto 0);
 signal isCorrect : std_logic;
    component memCompare
    port (charInput : in std_logic_vector(7 downto 0);
        isCorrect : out std_logic
    );
    end component;

begin
U1: memCompare port map(charInput,isCorrect);
charInput <= "00000000" after 0 ns , "00001000" after 1 ns ,
             "00000000" after 2 ns , x"61" after 3 ns , x"62" after 6 ns , x"11" after 7 ns;
end dataFlow ;
