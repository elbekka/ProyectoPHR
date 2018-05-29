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
 
	signal charE,charN,charT,charI,charY,charSpace,interrupcion:std_logic:='0';
	signal seguimiento : std_logic_vector(6 downto 0) ;
    type state_type is (E,N,T1,I,T2,Y,space);
    signal state : state_type := E ;

    component memCompare
    port (
    charInput : in std_logic_vector(7 downto 0);
    address   : in integer range 0 to 30 ;
    isCorrect : out std_logic
  ) ;
    end component;

begin
--LLAMADAS A LAS ENTIDADES

memCompareE: memCompare port map (bitInput,4,isCorrect=>charE);
memCompareN: memCompare port map (bitInput,13,isCorrect=>charN);
memCompareT: memCompare port map (bitInput,19,isCorrect=>charT);
memCompareI : memCompare port map (bitInput,8,isCorrect=>charI);
memCompareY : memCompare port map (bitInput,24,isCorrect=>charY);
memCompareSpace : memCompare port map (bitInput,26,charSpace);

process (clk)
    begin
	if(reset='1' or interrupcion = '1') then
		detectedBit <='0';
		state <= E;
		interrupcion <= '0';
	elsif(rising_edge(clk)) then
		case state is
			when E=>
                detectedBit <='0' ;
                if(charE = '1') then
					 state <=N;
				else
                    interrupcion <='1';
               	end if;
			when N=>
				if(charN = '1') then
                 	state <=T1;
				else
                    interrupcion<='1';
               	end if;
			when T1=>
				if(charT = '1') then
                	state <=I;
				else
                    interrupcion<='1';
               	end if;
			when I=>
				if(charI = '1') then
                	state <=T2;
				else
                    interrupcion<='1';
               	end if;
			when T2=>
				if(charT= '1') then
                 	state <=Y;
				else
                    interrupcion <= '1';
               			end if;
			when Y=>
				if(charY = '1') then
                    state <=space;
                else
                    interrupcion <= '1';
			end if;
			when space =>
				if(charSpace = '1') then
					detectedBit <= '1';
					state <= E;
				else
					interrupcion <='1';
				end if;
			when others=>NULL;
		end case;
	end if;
   end process;
end arquitectura;
