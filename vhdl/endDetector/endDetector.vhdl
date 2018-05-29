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
type state_type is (E,N,D,space);
    signal state : state_type := E ;
    signal charE,charN,charD,charSpace,interrupcion : std_logic:='0';
    
    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
      end component;
begin
    memCompareE: memCompare port map (bitInput,4,isCorrect=>charE);
    memCompareN: memCompare port map (bitInput,13,isCorrect=>charN);
    memCompareD: memCompare port map (bitInput,3,isCorrect=>charD);
    memCompareSpace : memCompare port map(bitInput,26,isCorrect=>charSpace);
    process (clk)
    begin   
        if(reset = '1' or interrupcion='1') then 
        detectedBit <='0' ;
        state <= E;
        interrupcion <= '0';
        elsif(rising_edge(clk)) then
            case state is
                when E =>
                detectedBit <='0' ;
                if(charE = '1') then
                    state <=N;
                else
                    interrupcion<='1';
                end if;
                when N =>
                if(charN = '1') then
                        state <=D ;
                    else
                        interrupcion <= '1';
                    end if; 
                when D =>
                if(charD = '1') then
                    state <=space;
                else
                    interrupcion<='1';
                end if;
                when space =>
                if(charSpace = '1')then
                    detectedBit<='1';
                else
                    interrupcion<='1';
                    end if;
                when others => NULL;
            end case;
        end if;
     end process;
end Behavioral ; -- Behavioral
