
library ieee;
use ieee.std_logic_1164.all;

entity portDetection is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end entity;

architecture arquitectura of portDetection is
 
    signal auxCorrect0,auxCorrect1,auxCorrect2,auxCorrect3,auxCorrect4:std_logic;
    signal interrupcion: std_logic;
    type state_type is (P,O,R,T,ESPACIO);
    signal state : state_type := P ;


    component memCompare
    port (
    charInput : in std_logic_vector(7 downto 0);
    address   : in integer range 0 to 30 ;
    isCorrect : out std_logic
  ) ;
    end component;

begin
--LLAMADAS A LAS ENTIDADES

comp1 : memCompare port map (bitInput,15,isCorrect=>auxCorrect0); --P
comp2 : memCompare port map (bitInput,14,isCorrect=>auxCorrect1);--O
comp3 : memCompare port map (bitInput,17,isCorrect=>auxCorrect2);--R
comp4 : memCompare port map (bitInput,19,isCorrect=>auxCorrect3); --T
comp5 : memCompare port map (bitInput,26, isCorrect=>auxCorrect4);--(BLANCO)
process (clk)
    begin
	if(reset='1' or interrupcion='1') then
		detectedBit <='0' ;
        	--state <= P;
	elsif(rising_edge(clk)) then
		case state is

			when P=>
                		detectedBit <='0' ;
                		if(auxCorrect0 = '1') then
                 		   state <=O;
				else
                    		   interrupcion<='1';
               			end if;
			when O=>
				if(auxCorrect1 = '1') then
                 		   state <=R;
				else
                    		    interrupcion<='1';
               			end if;
			when R=>
				if(auxCorrect2 = '1') then
                 		   state <=T;
				else
                    		   interrupcion<='1';
               			end if;
			when T=>
				if(auxCorrect3 = '1') then
                 		   state <=ESPACIO;
				else
                    		   interrupcion<='1';
               			end if;
			when ESPACIO=>
				if(auxCorrect4 = '1') then
                       		  detectedBit <= '1' ;
                       		  --state <=P;
                   		else
                      		  interrupcion<='1';
                    		end if;
			
			when others=>
				interrupcion<='1';
		end case;
	end if;
   end process;
end arquitectura;
