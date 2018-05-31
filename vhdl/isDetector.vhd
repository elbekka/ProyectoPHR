library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity is_Detector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end is_Detector;

architecture Behavioral of is_Detector is
    type state_type is (I,S,ESPACIO);
    signal state : state_type := I ;
    signal auxBit2,auxBit1,auxBit : std_logic;
    signal interruption: std_logic;
    
    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30   ;
          isCorrect : out std_logic
        ) ;
      end component;
begin
    memCompare1: memCompare port map (bitInput,8,isCorrect=>auxBit);
    memCompare2: memCompare port map (bitInput,18,isCorrect=>auxBit1); 
    memCompare3 : memCompare port map (bitInput,26,isCorrect=>auxBit2);

    process (clk)
    begin   
        if(reset = '1' or interruption = '1') then 
        detectedBit <='0';
        elsif(rising_edge(clk)) then
            case state is
            
                when I =>
                detectedBit <='0' ;
                if(auxBit = '1') then state <=S;
                else interruption <= '1';
                end if;

                when S =>
                    if(auxBit1 = '1') then state <=ESPACIO ;
                    else interruption <= '1';
                    end if; 
                
                when ESPACIO =>
                    if(auxBit2='1') then detectedBit <= '1' ; 
                    else interruption <= '1';
                    end if;
                when others => NULL;
            end case;
        end if;
     end process;
end Behavioral ; -- Behavioral
