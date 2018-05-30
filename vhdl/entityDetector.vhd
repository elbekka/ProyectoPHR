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
 
    signal auxCorrect0,auxCorrect1,auxCorrect2,auxCorrect3,auxCorrect4,auxCorrect5,auxCorrect6:std_logic;
    signal interrupcion: std_logic;
    type state_type is (E,N,T,I,F,Y,ESPACIO);
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

comp1 : memCompare port map (bitInput,4,isCorrect=>auxCorrect0); --E
comp2 : memCompare port map (bitInput,13,isCorrect=>auxCorrect1);--N
comp3 : memCompare port map (bitInput,19,isCorrect=>auxCorrect2);--T
comp4 : memCompare port map (bitInput,8,isCorrect=>auxCorrect3); --I
comp5 : memCompare port map (bitInput,19,isCorrect=>auxCorrect4);--T
comp6 : memCompare port map (bitInput,24,isCorrect=>auxCorrect5);--Y
comp7 : memCompare port map (bitInput,26, isCorrect=>auxCorrect6);--(BLANCO)
process (clk)
    begin
	if(reset='0' or interrupcion='1') then
		detectedBit <='0' ;
        	--state <= A;
	elsif(rising_edge(clk)) then
		case state is

			when E=>
                		detectedBit <='0' ;
                		if(auxCorrect0 = '1') then
                 		   state <=N;
				else
                    		   interrupcion<='1';
               			end if;
			when N=>
				if(auxCorrect1 = '1') then
                 		   state <=T;
				else
                    		    interrupcion<='1';
               			end if;
			when T=>
				if(auxCorrect2 = '1') then
                 		   state <=I;
				else
                    		   interrupcion<='1';
               			end if;
			when I=>
				if(auxCorrect3 = '1') then
                 		   state <=F;
				else
                    		   interrupcion<='1';
               			end if;
			when F=>
				if(auxCorrect4 = '1') then
                 		   state <=Y;
				else
                    		   interrupcion<='1';
               			end if;
			when Y=>
				if(auxCorrect5 = '1') then
                 		   state <= ESPACIO;
				else
                    		   interrupcion<='1';
               			end if;
			when ESPACIO=>
				if(auxCorrect6 = '1') then
                       		  detectedBit <= '1' ;
                       		  --state <=E;
                   		else
                      		  interrupcion<='1';
                    		end if;
			
			when others=>
				interrupcion<='1';
		end case;
	end if;
   end process;
end arquitectura;
