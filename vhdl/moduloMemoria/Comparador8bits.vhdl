library ieee;
use ieee.std_logic_1164.all;

entity comp8bits is
  port (
    charInputA : in std_logic_vector (7 downto 0);
    charInputB : in std_logic_vector (7 downto 0);
    bitOutput : out std_logic
  ) ;
end comp8bits;

architecture dataFlow of comp8bits is

    signal a1,a2,a3,a4,a5,a6,a7,a8 : std_logic;
begin

    a1<= charInputA(0) xnor charInputB(0);
    a2<= charInputA(1) xnor charInputB(1);
    a3<= charInputA(2) xnor charInputB(2);
    a4<= charInputA(3) xnor charInputB(3);

    a5<= charInputA(4) xnor charInputB(4);
    a6<= charInputA(5) xnor charInputB(5);
    a7<= charInputA(6) xnor charInputB(6);
    a8<= charInputA(7) xnor charInputB(7);

    bitOutput <= a1 and a2 and a3 and a4 and a5 and a6 and a7 and a8 ;

end dataFlow ; -- dataFlow