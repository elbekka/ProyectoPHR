library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CharDetector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end CharDetector;

architecture Behavioral of CharDetector is
type state_type is (C,espacio);
    signal state : state_type := A ;
    signal auxBit,auxBit1: std_logic;
    component caracteres_Detector  is 
    port (
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
 end component;
 component memCompare is
    port (
      charInput : in std_logic_vector(7 downto 0);
      address   : in integer range 0 to 25 ;
      isCorrect : out std_logic
    ) ;
  end component;

begin
    charDec:  caracteres_Detector port map (bitInput,isCorrect=>auxBit); -- I
    espacio: memCompare port map (bitInput,26,isCorrect=>auxBit1);
    process (clk)
    begin   
        if(reset = '1') then 
        detectedBit <='0' ;
        state <= C;
        elsif(rising_edge(clk)) then
            case state is
                when C =>
                detectedBit <='0';
                if(auxBit = '1') then
                    state <=C;
                else
                    state <=espacio;
                end if;
                when espacio =>
                if(auxBit1 = '1') then 
                    detectedBit <= '1';
                end if;
                when others => NULL;
            end case;
        end if;
     end process;
end Behavioral ; -- Behavioral
