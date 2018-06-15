library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity port_Detector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    ErrInic  : in integer :=0;
    detectedBit : out std_logic; -- '1' si ha detectado la secuencia.
    numErrores : out integer:=0
    ) ;
end port_Detector;

architecture Behavioral of port_Detector is
type estado is (P,O,R,T,space,trampa);
    signal estado_ini,estado_sig: estado ;
    signal charP,charO,charR,charT,charSpace,estadoAnt: std_logic:='0';
    signal err : integer := 0;
    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
      end component;
begin
    memCompareP: memCompare port map (bitInput,15,isCorrect=>charP);
    memCompareO: memCompare port map (bitInput,14,isCorrect=>charO);
    memCompareR: memCompare port map (bitInput,17,isCorrect=>charR);
    memCompareT: memCompare port map (bitInput,19,isCorrect=>charT);
    memCompareSpace : memCompare port map(bitInput,26,isCorrect=>charSpace);
    process (clk , reset)
    begin   
        if(reset = '1') then 
        estado_ini <= P;
        elsif(rising_edge(clk)) then
            estado_ini<=estado_sig;
        end if;
     end process;
     process (charP,charO,charR,charT,charSpace,estado_ini)
     begin
      case estado_ini is
------------------------------------------------------------------------------------------------
    when P =>
        if(charP = '1') then
            detectedBit<='0';
            estado_sig <=O;
        elsif(estadoAnt = '1' and charSpace ='1') then 
            detectedBit<='1';
        else
        detectedBit<='0';
        estadoAnt <='0';
        estado_sig <=trampa;
------------------------------------------------------------------------------------------------
        end if;
   when O =>
        if(charO = '1') then
                estado_sig<=R ;
        else
                estado_sig <=trampa;
        end if; 
------------------------------------------------------------------------------------------------
   when R =>
        if(charR = '1') then
                estado_sig<=T ;
        else
                estado_sig <=trampa;
        end if; 
------------------------------------------------------------------------------------------------
   when T =>
        if(charT = '1') then
            estado_sig <=space;
        else
            estado_sig <=trampa;
        end if;
------------------------------------------------------------------------------------------------
   when space =>
        if(charSpace = '1')then
            detectedBit<='1';
            estadoAnt<='1';
            estado_sig<=P;
        else
            estado_sig<=trampa;
            estadoAnt<= '0';
            end if;
------------------------------------------------------------------------------------------------
    when trampa =>
            if(charSpace = '1')then
                if(err< ErrInic)then
                    err <= ErrInic;
            end if;
                numErrores <= err + 1 ;
                err <=err +1 ;
                estado_sig<= P;
            else
                estado_sig <=trampa;
            end if;
        when others => estadoAnt <='0';
                estado_sig<=trampa;  --ocurrido un error;
    end case;
     end process;
end Behavioral ; -- Behavioral
