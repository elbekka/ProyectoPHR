library ieee;
use ieee.std_logic_1164.all;

entity tb_comp8bits is
end entity;

architecture test of tb_comp8bits is

    signal charInputA,charInputB : std_logic_vector(7 downto 0);
    signal bitOutput : std_logic;
    component comp8bits 
        port (
          charInputA : in std_logic_vector (7 downto 0);
          charInputB : in std_logic_vector (7 downto 0);
          bitOutput : out std_logic
        ) ;
      end component;
begin
UT :  comp8bits port map(charInputA,charInputB,bitOutput);
charInputA <= "00000000" after 0 ns , "00001000" after 1 ns ,
             "00000000" after 2 ns , "00001100" after 3 ns ;
charInputB <= "00000000" after 0 ns , "00000000" after 1 ns ,
            "00010000" after 2 ns , "00000000" after 3 ns ;
end test ; -- test