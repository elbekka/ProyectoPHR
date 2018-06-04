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

    
    signal charI,charS,charSpace : std_logic := '0' ;
    signal interrupcion : std_logic :='0';

    type state_type is (I,S,Space);
    signal state : state_type :=S ;
    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
      end component;
begin
    compI: memCompare port map (bitInput,8,isCorrect=>charI);   --I
    compS: memCompare port map (bitInput,18,isCorrect=>charS);  --S
    compSpace : memCompare port map (bitInput,26,charSpace);    --Space
    process (clk)
    begin   
        if(reset = '1' or interrupcion = '1') then 
        detectedBit <='0' ;
        interrupcion<='0';
        state <= I;
        elsif(rising_edge(clk)) then
            detectedBit <='0' ;
            case state is
                when I =>
                if(charI = '1') then
                    state <=S;
                else 
                    interrupcion <= '1';
                end if;
                when S =>
                    if(charS = '1') then
                        state <= Space ;
                    else
                        interrupcion <= '1'; 
                    end if;
                when Space =>
                    if(charSpace = '1') then 
                        detectedBit <= '1';
                    end if;
                
            end case;
        end if;
     end process;
end Behavioral ; -- Behavioral


        