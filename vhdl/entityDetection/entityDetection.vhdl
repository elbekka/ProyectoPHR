library ieee;
use ieee.std_logic_1164.all;

entity entityDetection is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end entity;

architecture arquitectura of entityDetection is
 type estado is (E,N,T1,I,T2,Y, space,trampa);
    signal estado_ini,estado_sig: estado ;
    signal charE,charN,charT,charI,charY,charSpace,estadoAnt: std_logic:='0';
    signal estadoTrampa : std_logic:= '0' ;
    component memCompare
    port (
    charInput : in std_logic_vector(7 downto 0);
    address   : in integer range 0 to 27 ;
    isCorrect : out std_logic
  ) ;
    end component;

begin
--LLAMADAS A LAS ENTIDADES

memCompareE : memCompare port map (bitInput,4,isCorrect=>charE);
memCompareN : memCompare port map (bitInput,13,isCorrect=>charN);
memCompareT : memCompare port map (bitInput,19,isCorrect=>charT);
memCompareI : memCompare port map (bitInput,8,isCorrect=>charI);
memCompareY : memCompare port map (bitInput,24,isCorrect=>charY);
memCompareSpace : memCompare port map(bitInput,26,isCorrect=>charSpace);
process (clk , reset)
begin   
    if(reset = '1') then 
    estado_ini <= E;
    elsif(rising_edge(clk)) then
        estado_ini<=estado_sig;
    end if;
 end process;
 process (charE,charN,charT,charI,charY,charSpace,estado_ini)
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
    estado_sig <=trampa;
    end if;
    when N =>
    if(charN = '1') then
            estado_sig<=T1 ;
    else
            estado_sig <=trampa;
    end if; 
    when T1 =>
    if(charT = '1') then
        estado_sig <=I;
    else
        estado_sig <=trampa;
    end if;
    when I =>
    if(charI = '1') then
        estado_sig <=T2;
        else
            estado_sig <= trampa;
    end if;
    when T2 =>
    if(charT = '1') then
        estado_sig <= Y ;
        else 
            estado_sig <= trampa;
    end if;
    when Y =>
    if(charY = '1')then
        estado_sig <= space;
        else
            estado_sig <= trampa;
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
        estado_sig<= E;
    else
        estado_sig <=trampa;
        detectedBit<='0';
    end if;
    when others => 
        estadoAnt <='0';
        estado_sig<=trampa;  --ocurrido un error;
end case;
 end process;
end arquitectura;
