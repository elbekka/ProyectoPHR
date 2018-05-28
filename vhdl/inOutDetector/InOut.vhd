library ieee;

use ieee.std_logic_1164.all;



entity InOutDetection is

  port (

    clk: in std_logic;

    reset : in std_logic;

    bitInput : in std_logic_vector(7 downto 0);

    detectedBit : out std_logic -- '1' si ha detectado la secuencia.

  ) ;

end entity;



architecture arquitectura of InOutDetection is

 

	signal auxCorrect0,auxCorrect1,auxCorrect2,auxCorrect3,auxCorrect4,auxCorrect5:std_logic;
	signal interrupcion : std_logic :='0';

    type state_type is (I,N,O,U,T,TRAMPA);

    signal state : state_type := I ;



    component memCompare

    port (

    charInput : in std_logic_vector(7 downto 0);

    address   : in integer range 0 to 30 ;

    isCorrect : out std_logic

  ) ;

    end component;



begin

--LLAMADAS A LAS ENTIDADES



comp1 : memCompare port map (bitInput,8,isCorrect=>auxCorrect0); --I

comp2 : memCompare port map (bitInput,13,isCorrect=>auxCorrect1);--N

comp3 : memCompare port map (bitInput,14,isCorrect=>auxCorrect2); --0

comp4 : memCompare port map (bitInput,20,isCorrect=>auxCorrect3); --U

comp5 : memCompare port map (bitInput,19,isCorrect=>auxCorrect4); --T




process (clk)

    begin

	if(reset='1' or interrupcion ='1') then

		detectedBit <='0' ;
        state <= I;
	elsif(rising_edge(clk)) then

		case state is
--I
			when I=>
                detectedBit <='0' ;
                if(auxCorrect0 = '1') then
                	state <=N;
				elsif (auxCorrect2 = '1') then 
							state <= U ;
				else
					interrupcion <= '1';
               			end if;
--N
			when N=>

				if(auxCorrect1 = '1') then
				  detectedBit <= '1' ;
				else
					interrupcion <= '1';
               			end if;
--O
			when O=>
				if(auxCorrect2 = '1') then
                 		   state <=U;
				else
				interrupcion <= '1';
               			end if;
--U
			when U=>
				if(auxCorrect3 = '1') then
                state <=T;
				else
				interrupcion <= '1';
				end if;
--T
			when T=>

				if(auxCorrect4 = '1') then
					detectedBit <= '1' ;
				else
					interrupcion <= '1';
               			end if;
			when others=>
			interrupcion <= '1';
		end case;
	end if;
   end process;
end arquitectura;
