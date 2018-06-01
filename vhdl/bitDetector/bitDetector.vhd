library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit_Detector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end bit_Detector;

architecture Behavioral of bit_Detector is
    type state_type is (B,I,T,ESPACIO);
    signal state : state_type := B ;
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
    memCompare1: memCompare port map (bitInput,1,isCorrect=>auxBit);  --B
    memCompare2: memCompare port map (bitInput,8,isCorrect=>auxBit1); --I
    memCompare3: memCompare port map (bitInput,19,isCorrect=>auxBit2);--T
    memCompare4: memCompare port map (bitInput,26,isCorrect=>auxBit3);--ESPACIO
    process (clk)
    begin   
        if(reset = '1' or interruption = '1') then 
        detectedBit <='0' ;

        elsif(rising_edge(clk)) then
            case state is

                when B =>
                detectedBit <='0' ;
                if(auxBit = '1') then
                    state <=I;
                else
                    interruption <= '1';
                end if;

                
                when I =>
                if(auxBit1 = '1') then
                        state <=T ;
                    else
                        interruption <= '1';
                    end if; 


                when T =>
                if(auxBit2 = '1') then
                    state <=ESPACIO;
                else
                    interruption <= '1';
                end if;


                when ESPACIO =>
                if(auxBit3 = '1') then
                    detectedBit <='1' ;
                else
                    interruption <= '1';
                end if;
                when others => interruption <= '1';
            end case;
        end if;
     end process;
end Behavioral ; 
