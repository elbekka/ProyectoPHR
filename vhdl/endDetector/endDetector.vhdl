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
type estado is (E,N,D,space);
    signal estado_ini,estado_sig: estado ;
    signal charE,charN,charD,charSpace,estadoAnt: std_logic:='0';
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
    process (clk , reset)
    begin   
        if(reset = '1') then 
        estado_ini <= E;
        elsif(rising_edge(clk)) then
            estado_ini<=estado_sig;
        end if;
     end process;
     process (charE,charN,charD,charSpace,estado_ini)
     begin
      case estado_ini is
        when E =>
        if(charE = '1') then
            detectedBit<='0';
            estado_sig <=N;
        elsif(estadoAnt = '1' and charSpace ='1') then 
            detectedBit<='1';
        else
        detectedBit<='0';
        estadoAnt <='0';
        estado_sig <=E;
        end if;
        when N =>
        if(charN = '1') then
                estado_sig<=D ;
        else
                estado_sig <=E;
        end if; 
        when D =>
        if(charD = '1') then
            estado_sig <=space;
        else
            estado_sig <=E;
        end if;
        when space =>
        if(charSpace = '1')then
            detectedBit<='1';
            estadoAnt<='1';
            estado_sig<=E;
        else
            estado_sig<=E;
            estadoAnt<= '0';
            end if;
        when others => estadoAnt <='0';
    end case;
     end process;
end Behavioral ; -- Behavioral
