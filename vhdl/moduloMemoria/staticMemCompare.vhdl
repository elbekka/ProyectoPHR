library ieee;
use ieee.std_logic_1164.all;

entity memCompare is
  port (
    charInput : in std_logic_vector(7 downto 0);
    address   : in integer range 0 to 30 ;
    isCorrect : out std_logic
  ) ;
end memCompare;

architecture arquitectura of memCompare is

    
    signal auxData : std_logic_vector(7 downto 0);
    component rom
    port (
    address: in integer range 0 to 30;
    data:out std_logic_vector(7 downto 0)
    );
    end component;
    component comp8bits 
    port (
      charInputA : in std_logic_vector (7 downto 0);
      charInputB : in std_logic_vector (7 downto 0);
      bitOutput : out std_logic
    ) ;
  end component;
begin
  rom1 : rom port map (address,auxData);
  comparador : comp8bits port map (charInput,auxData,isCorrect);
 -- UR2 : rom24x8 port map (1,data => auxDataB);
  --UC2 : comp8bits port map (charInput,auxDataB,auxVector(1));
  --isCorrect <= auxVector(0) or auxVector(1);
end arquitectura ; -- arquitectura