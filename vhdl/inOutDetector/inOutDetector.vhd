library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inOut_Detector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end inOut_Detector;

architecture Behavioral of inOut_Detector is
type estado is (I,N,U,T,space);
    signal estado_ini,estado_sig: estado ;
    signal charI,charN,charO,charU,charT,charSpace,estadoAnt: std_logic:='0';
    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
      end component;
begin
    memCompareI: memCompare port map (bitInput,8,isCorrect=>charI);
    memCompareN: memCompare port map (bitInput,13,isCorrect=>charN);
memCompareO: memCompare port map (bitInput,14,isCorrect=>charO);
	memCompareU: memCompare port map (bitInput,20,isCorrect=>charU);
    memCompareT: memCompare port map (bitInput,19,isCorrect=>charT);
	memCompareSpace : memCompare port map(bitInput,26,isCorrect=>charSpace);
	

    process (clk , reset)
    begin   
        if(reset = '1') then 
        estado_ini <= I;
        elsif(rising_edge(clk)) then
            estado_ini<=estado_sig;
        end if;
	 end process;
	 

     process (charI,charN,charO,charU,charT,charSpace,estado_ini)
     begin
	  case estado_ini is
---------------------------------------------------------------------------------------------------
        when I =>
        if(charI = '1') then
            detectedBit<='0';
	    estado_sig <=N;
	    elsif(charO = '1') then 
			detectedBit<='0';
			estado_sig <=U;
        		elsif(estadoAnt = '1' and charSpace ='1') then 	
				detectedBit<='1';
        else
            detectedBit<='0';
            estadoAnt <='0';
            estado_sig <=I;
	end if;
---------------------------------------------------------------------------------------------
        when N =>
        if(charN = '1') then
                estado_sig<=space ;
        else
                estado_sig <=I;
	end if; 
----------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
		when U =>
        if(charU = '1') then
			estado_sig<=T ;
		else
			estado_sig <=I;
		end if;
--------------------------------------------------------------------------------------------
		when T =>
        if(charT = '1') then
			estado_sig<=space ;
		else
			estado_sig <=I;
		end if;
---------------------------------------------------------------------------------------
        when space =>
        if(charSpace = '1')then
            detectedBit<='1';
            estadoAnt<='1';
            estado_sig<=I;
        else
            estado_sig<=I;
            estadoAnt<= '0';
            end if;
-----------------------------------------------------------------------------------------
        when others => estadoAnt <='0';
    end case;
     end process;
end Behavioral ; -- Behavioral	
