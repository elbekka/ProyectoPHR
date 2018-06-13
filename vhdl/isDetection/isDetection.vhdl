library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity is_Detection is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    ErrInic  : in integer :=0;
    detectedBit : out std_logic;
    numErrores : out integer:=0 -- '1' si ha detectado la secuencia.
  ) ;
end is_Detection;

architecture Behavioral of is_Detection is
type estado is (I,S,space,trampa);
    signal estado_ini,estado_sig: estado ;
    signal charI,charS,charSpace,estadoAnt: std_logic:='0';
    signal err : integer := 0;
    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
      end component;
begin
    memCompareI: memCompare port map (bitInput,8,isCorrect=>charI);
    memCompareS: memCompare port map (bitInput,18,isCorrect=>charS);
    memCompareSpace : memCompare port map(bitInput,26,isCorrect=>charSpace);
    process (clk , reset)
    begin   
        if(reset = '1' ) then 
        estado_ini <= I;
        elsif(rising_edge(clk)) then
            estado_ini<=estado_sig;
        end if;
     end process;
     process (charI,charS,charSpace,estado_ini)
     begin
        
      case estado_ini is
        when I =>
        if(charI = '1') then
            detectedBit<='0';
            estado_sig <=S;
        elsif(estadoAnt = '1' and charSpace ='1') then 
            detectedBit<='1';
        else
        detectedBit<='0';
        estadoAnt <='0';
        estado_sig <=trampa;
        end if;
        when S =>
        if(charS = '1') then
                estado_sig<=space ;
        else
                estado_sig <=trampa;
        end if; 
        when space =>
        if(charSpace = '1')then
            detectedBit<='1';
            estadoAnt<='1';
            estado_sig<=I;
        else
            estado_sig<=trampa;
            estadoAnt<= '0';
            end if;
        when trampa =>
        if(charSpace = '1')then
            if(err< ErrInic)then
                err <= ErrInic;
        end if;
            numErrores <= err + 1 ;
            err <=err +1 ;
            estado_sig<= I;
        else
            estado_sig <=trampa;
        end if;
        when others => 
            estadoAnt <='0';
            estado_sig<=trampa;  --ocurrido un error;
    end case;
     end process;
end Behavioral ; -- Behavioral
