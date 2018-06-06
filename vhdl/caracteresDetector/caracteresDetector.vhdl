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
type estado is (C,espacio);
    signal estado_ini,estado_sig: estado ;
    signal charCaracter,charSpace: std_logic;
    component esCaracter  is 
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
    charDec:  caracteres_Detector port map (bitInput,isCorrect=>charCaracter); -- I
    espacio: memCompare port map (bitInput,26,isCorrect=>charSpace);
    process (clk , reset)
    begin   
        if(reset = '1' ) then 
        estado_ini <= E;
        elsif(rising_edge(clk)) then
            estado_ini<=estado_sig;
        end if;
     end process;
     process (charCaracter,charSpace,estado_ini)
     begin
      case estado_ini is
        when C =>
        if(charCaracter = '1') then
            detectedBit<='0';
            estado_sig <=charCaracter;
        elsif(estadoAnt = '1' and charSpace ='1') then 
            detectedBit<='1';
        else
        detectedBit<='0';
        estadoAnt <='0';
        estado_sig <=trampa;
        end if;
        when space =>
        if(charSpace = '1')then
            detectedBit<='1';
            estadoAnt<='1';
            estado_sig<=E;
        else
            estado_sig<=trampa;
            estadoAnt<= '0';
            end if;
        when trampa =>
        if(charSpace = '1')then
            estado_sig<= C;
        else
            estado_sig <=trampa;
        end if;
        when others => 
            estadoAnt <='0';
            estado_sig<=trampa;  --ocurrido un error;
    end case;
     end process;
end Behavioral ; -- Behavioral
