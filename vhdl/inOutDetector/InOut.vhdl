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

	signal charI,charN,charO,charU,charT,charSpace:std_logic;
	signal interrupcion : std_logic :='0';

    type state_type is (I,N,O,U,T,Space);

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

compI : memCompare port map (bitInput,8,isCorrect=>charI);  --I
compN : memCompare port map (bitInput,13,isCorrect=>charN); --N
compO : memCompare port map (bitInput,14,isCorrect=>charO); --0
compU : memCompare port map (bitInput,20,isCorrect=>charU); --U
compT : memCompare port map (bitInput,19,isCorrect=>charT); --T
compSpace : memCompare port map (bitInput,26,charSpace);    --Space

process (clk)
    begin
	if(reset='1' or interrupcion ='1') then
		detectedBit <='0' ;
        state <= I;
	elsif(rising_edge(clk)) then
		detectedBit <='0' ;
		case state is
--I
			when I=>
                if(charI = '1') then
                	state <=N;
				elsif (charO = '1') then 
							state <= U ;
				else
					interrupcion <= '1';
               			end if;
--N
			when N=>
				if(charN = '1') then
				  state <= Space ;
				else
					interrupcion <= '1';
               			end if;
--O
			when O=>
				if(charO = '1') then
                 	state <=U;
				else
					interrupcion <= '1';
               			end if;
--U
			when U=>
				if(charU= '1') then
                state <=T;
				else
				interrupcion <= '1';
				end if;
--T
			when T=>
				if(charT = '1') then
					state<=Space;
				else
					interrupcion <= '1';
				end if;
			when Space =>
			if(charSpace='1')then
				detectedBit<='1';
			end if;
			when others=>
			interrupcion <= '1';
		end case;
	end if;
   end process;
end arquitectura;
