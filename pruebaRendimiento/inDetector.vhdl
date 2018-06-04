library ieee;
use ieee.std_logic_1164.all;

entity InDetection is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end entity;

architecture arquitectura of InDetection is

	signal charI,charN,charSpace:std_logic;
	signal interrupcion : std_logic :='0';

    type state_type is (I,N,space);

    signal state : state_type := I ;

    component memCompare
    port (
    charInput : in std_logic_vector(7 downto 0);
    address   : in integer range 0 to 30 ;
    isCorrect : out std_logic
  ) ;
    end component;
begin
    
compI : memCompare port map (bitInput,8,isCorrect=>charI); --I
compN : memCompare port map (bitInput,13,isCorrect=>charN);--N
compSpace : memCompare port map (bitInput,26,charSpace);
    process( clk )
    begin
        if(reset='1' or interrupcion ='1') then
            detectedBit <='0' ;
            state <= I;
            interrupcion <='0';
        elsif(rising_edge(clk)) then
            detectedBit<='0';
            case state is
                when I =>
                if(charI = '1') then
                    state <=N;
                else
                    interrupcion <='1';
                end if;
                when N =>
                if(charN = '1')then
                    state <= space;
                else
                    interrupcion <= '1';
                end if;
                when space =>
                if(charSpace = '1')then
                    detectedBit <= '1';
                    state <= I;
                end if ;
                when others => null;
            end case;
        end if;
    end process ; -- identifier
end arquitectura;