library ieee;
use ieee.std_logic_1164.all;

entity memCompare is
  port (
    charInput : in std_logic_vector(7 downto 0);
    isCorrect : out std_logic
  ) ;
end memCompare;

architecture arquitectura of memCompare is

    signal auxVector : std_logic_vector(25 downto 0);
    signal aux1 : std_logic_vector(7 downto 0);
    signal auxDataB : std_logic_vector(7 downto 0);
    component rom24x8
    port (
    address: in integer range 0 to 25;
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
  UR1 : rom24x8 port map (0,data => auxData);
  UC1 : comp8bits port map (charInput,auxData,auxVector(0));
  UR2 : rom24x8 port map (1,data => auxDataB);
  UC2 : comp8bits port map (charInput,auxDataB,auxVector(1));
  isCorrect <= auxVector(0) or auxVector(1);
end arquitectura ; -- arquitectura