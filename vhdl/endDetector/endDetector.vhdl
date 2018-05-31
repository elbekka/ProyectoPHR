library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity end_Detector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end end_Detector;

architecture Behavioral of end_Detector is
type state_type is (E,N,D,ESPACIO);
    signal state : state_type := E ;
    signal auxBit3,auxBit2,auxBit1,auxBit : std_logic;
    signal interruption: std_logic;

    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
      end component;
begin
    memCompare1: memCompare port map (bitInput,4,isCorrect=>auxBit);
    memCompare2: memCompare port map (bitInput,13,isCorrect=>auxBit1);
    memCompare3: memCompare port map (bitInput,3,isCorrect=>auxBit2);
    memCompare4: memCompare port map (bitInput,26,isCorrect=>auxBit3);
    process (clk)
    begin   
        if(reset = '1' or interruption = '1') then 
        detectedBit <='0';
        elsif(rising_edge(clk)) then
            case state is


                when E =>
                detectedBit <='0' ;
                if(auxBit = '1') then state <=N;
                else interruption <= '1';
                end if;


                when N =>
                if(auxBit1 = '1') then state <=D ;
                else interruption <= '1';
                end if; 


                when D =>
                if(auxBit2 = '1') then state <=ESPACIO;
                else interruption <= '1';
                end if;


                when ESPACIO =>
                if(auxBit3= '1') then  detectedBit <='1';
                else interruption <= '1';
                end if;
                    
                when others => NULL;
            end case;
        end if;
     end process;
end Behavioral ; -- Behavioral
