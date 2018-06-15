library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_Detector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    ErrInic  : in integer :=0;
    detectedBit : out std_logic; -- '1' si ha detectado la secuencia.
    numErrores : out integer:=0 
  ) ;
end logic_Detector;

architecture Behavioral of logic_Detector is
type estado is (A,N,D,O,R,X,O1,R1,N1,A1,N3,space,trampa);
    signal estado_ini,estado_sig: estado ;
    signal charA,charN,charD,charO,charR,charX,charSpace,estadoAnt: std_logic:='0';
    signal err : integer := 0;
    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
      end component;
begin
    memCompareA: memCompare port map (bitInput,0,isCorrect=>charA);
    memCompareN: memCompare port map (bitInput,13,isCorrect=>charN);
    memCompareD: memCompare port map (bitInput,3,isCorrect=>charD);
    memCompareO: memCompare port map (bitInput,14,isCorrect=>charO);
    memCompareR: memCompare port map (bitInput,17,isCorrect=>charR);
    memCompareX: memCompare port map (bitInput,23,isCorrect=>charX);
    memCompareSpace : memCompare port map(bitInput,26,isCorrect=>charSpace);
    process (clk , reset)
    begin   
        if(reset = '1') then 
        estado_ini <= A;
        elsif(rising_edge(clk)) then
            estado_ini<=estado_sig;
        end if;
     end process;
     process (charA,charN,charD,charO,charR,charX,charSpace,estado_ini)
     begin
      case estado_ini is
        when A =>
        if(charA = '1') then
            	detectedBit<='0';
            	estado_sig <=N;
	elsif(charO = '1')then
		detectedBit<='0';
		estado_sig <=R;
	elsif(charX = '1')then
		detectedBit<='0';
		estado_sig <=O1;
	elsif(charN = '1')then
		detectedBit<='0';
		estado_sig <=A1;
        elsif(estadoAnt = '1' and charSpace ='1') then 
            detectedBit<='1';
        else
        detectedBit<='0';
        estadoAnt <='0';
        estado_sig <=trampa;
        end if;
------------------------------------------
        when N =>
        if(charN = '1') then
                estado_sig<=D ;
        else
                estado_sig <=trampa;
        end if;
------------------------------------------- 
        when D =>
        if(charD = '1') then
            estado_sig <=space;
        else
            estado_sig <=trampa;
        end if;
--------------------------------------
	when O =>
        if(charO = '1') then
            estado_sig <=R;
        else
            estado_sig <=trampa;
        end if;
--------------------------------------------
	when R =>
        if(charR = '1') then
            estado_sig <=space;
        else
            estado_sig <=trampa;
        end if;
-------------------------------------------------------
	when X =>
        if(charX = '1') then
            estado_sig <=O1;
        else
            estado_sig <=trampa;
        end if;
-----------------------------------
when O1 =>
        if(charO = '1') then
            estado_sig <=R1;
	elsif(charN = '1')then
	    estado_sig <=O;
        else
            estado_sig <=trampa;
        end if;
--------------------------
when R1 =>
        if(charR = '1') then
            estado_sig <=space;
        else
            estado_sig <=trampa;
        end if;
----------------------------
when N1 =>
        if(charN = '1') then
            estado_sig <=A1;
        else
            estado_sig <=trampa;
        end if;
-------------------------------
when A1 =>
        if(charA = '1') then
            estado_sig <=N3;
        else
            estado_sig <=trampa;
        end if;
-------------------------------
when N3 =>
        if(charN = '1') then
            estado_sig <=D;
	elsif(charO = '1')then
	    estado_sig <=O;
        else
            estado_sig <=trampa;
        end if;
-----------------------------
        when space =>
        if(charSpace = '1')then
            detectedBit<='1';
            estadoAnt<='1';
            estado_sig<=A;
        else
            estado_sig<=trampa;
            estadoAnt<= '0';
            end if;
-----------------------------
when trampa =>
if(charSpace = '1')then
    if(err< ErrInic)then
        err <= ErrInic;
end if;
    numErrores <= err + 1 ;
    err <=err +1 ;
    estado_sig<= A;
else
    estado_sig <=trampa;
end if;

        when others => estadoAnt <='0';
    end case;
     end process;
end Behavioral ; -- Behavioral