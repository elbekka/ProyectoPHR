library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity charDetector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end charDetector;

architecture Behavioral of CharDetector is
type estado is (C,space);
    signal estado_ini,estado_sig: estado ;
    signal charCaracter,charSpace,estadoAnt: std_logic;
    component esCaracter  is 
    port (
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
 end component;
 component memCompare is
    port (
      charInput : in std_logic_vector(7 downto 0);
      address   : in integer range 0 to 30 ;
      isCorrect : out std_logic
    ) ;
  end component;

begin
    charDec:  esCaracter port map (bitInput,detectedBit=>charCaracter); -- I
    espacio: memCompare port map (bitInput,26,isCorrect=>charSpace);
    process (clk , reset)
    begin   
        if(reset = '1' ) then 
        estado_ini <= C;
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
            estado_sig <=space;
        else
            estado_sig<=space;
        end if;
        when space =>
        if(charSpace = '1')then
            detectedBit<='1';
            estado_sig<=C;
        else
            estado_sig <=C;
            end if;
    end case;
     end process;
end Behavioral ; -- Behavioral
