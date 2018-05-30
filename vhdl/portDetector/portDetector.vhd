library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity port_Detector is
  port (
    clk: in std_logic;
    --reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end port_Detector;

architecture Behavioral of port_Detector is
type state_type is (A,B,C,D);
    signal state : state_type := A ;
    signal auxBit3,auxBit2,auxBit1,auxBit : std_logic;
    
    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 25 ;
          isCorrect : out std_logic
        ) ;
      end component;
begin
    memCompare1: memCompare port map (bitInput,15,isCorrect=>auxBit);
    memCompare2: memCompare port map (bitInput,14,isCorrect=>auxBit1);
    memCompare3: memCompare port map (bitInput,17,isCorrect=>auxBit2);
    memCompare4: memCompare port map (bitInput,19,isCorrect=>auxBit3);
    process (clk)
    begin   
        if(reset = '1') then 
        detectedBit <='0' ;
        state <= A;
        elsif(rising_edge(clk)) then
            case state is
                when A =>
                detectedBit <='0' ;
                if(auxBit = '1') then
                    state <=B;
                else
                    state <=A;
                end if;
                when B =>
                if(auxBit1 = '1') then
                    state <=C;
                else
                    state <=A;
                end if;
                when C =>
                if(auxBit2 = '1') then
                        state <=D ;
                    else
                        state <= A;
                    end if; 
                when C =>
                if(auxBit3 = '1') then
                    detectedBit <='1' ;
                    state <=A;
                else
                    state <=A;
                end if;
                when others => NULL;
            end case;
        end if;
     end process;
end Behavioral ; -- Behavioral