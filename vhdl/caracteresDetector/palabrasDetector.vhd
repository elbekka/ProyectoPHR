
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity palabras_Detector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end palabras_Detector;

architecture Behavioral of palabras_Detector is
type state_type is (A,B);
    signal state : state_type := A;
    signal auxBit1,auxBit : std_logic;
    signal interruption: std_logic;

    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
    end component;

    component caracteres_Detector
        port (
            bitInput : in std_logic_vector(7 downto 0);
            detectedBit : out std_logic
        ) ;
    end component;

      
begin
    memCompare1: caracteres_Detector port map (bitInput,detectedBit=>auxBit);
    memCompare4: memCompare port map (bitInput,26,isCorrect=>auxBit1);
    process (clk)
    begin   
        if(reset = '1' or interruption = '1') then 
        detectedBit <='0';
        elsif(rising_edge(clk)) then
            case state is

                when A =>
                detectedBit <='0' ;
                if(auxBit = '1') then state <=B;
                else interruption <= '1';
                end if;

                when  B=>
                if(auxBit = '1') then state <=B;
                else if(auxBit1 = '1') then detectedBit <='1';
                     else interruption <= '1';
                    end if;
                end if;

                when others => interruption <= '1';
            end case;
        end if;
     end process;
end Behavioral ; -- Behavioral
