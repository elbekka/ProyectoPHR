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
 
    signal auxCorrect0,auxCorrect1,auxCorrect2,auxCorrect3,auxCorrect4,auxCorrect5:std_logic;
    type state_type is (A,B,C,D,E,F,G,H);
    signal state : state_type := A ;

    component memCompare
    port (
    charInput : in std_logic_vector(7 downto 0);
    address   : in integer range 0 to 25 ;
    isCorrect : out std_logic
  ) ;
    end component;

begin
--LLAMADAS A LAS ENTIDADES

comp1 : memCompare port map (bitInput,4,isCorrect=>auxCorrect0);
comp2 : memCompare port map (bitInput,13,isCorrect=>auxCorrect1);
comp3 : memCompare port map (bitInput,19,isCorrect=>auxCorrect2);
comp4 : memCompare port map (bitInput,8,isCorrect=>auxCorrect3);
comp5 : memCompare port map (bitInput,19,isCorrect=>auxCorrect4);
comp6 : memCompare port map (bitInput,24,isCorrect=>auxCorrect5);

process (clk)
    begin
	if(reset='1') then
		detectedBit <='0' ;
        state <= A;
	elsif(rising_edge(clk)) then
		case state is
			when A=>
                		detectedBit <='0' ;
                		if(auxCorrect0 = '1') then
                 		   state <=B;
				else
                    		   state <=A;
               			end if;
			when B=>
				if(auxCorrect1 = '1') then
                 		   state <=C;
				else
                    		   state <=A;
               			end if;
			when C=>
				if(auxCorrect2 = '1') then
                 		   state <=D;
				else
                    		   state <=A;
               			end if;
			when D=>
				if(auxCorrect3 = '1') then
                 		   state <=E;
				else
                    		   state <=A;
               			end if;
			when E=>
				if(auxCorrect4 = '1') then
                 		   state <=F;
				else
                    		   state <=A;
               			end if;
			when F=>
				if(auxCorrect5 = '1') then
                       		  detectedBit <= '1' ;
                       		  state <=A;
                   		else
                      		  state <= A;
                    		end if;
			when others=>
				state<=H;
		end case;
	end if;
   end process;
end arquitectura;
