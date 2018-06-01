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

architecture arquitectura of InOutDetection is

	signal charI,charN:std_logic;
	signal interrupcion : std_logic :='0';

    type state_type is (I,N);

    signal state : state_type := I ;

    component memCompare
    port (
    charInput : in std_logic_vector(7 downto 0);
    address   : in integer range 0 to 30 ;
    isCorrect : out std_logic
  ) ;
    end component;
begin
    
comp1 : memCompare port map (bitInput,8,isCorrect=>charI); --I
comp2 : memCompare port map (bitInput,13,isCorrect=>charN);--N
    process( clk )
    begin
        if(reset='0' or interrupcion ='1') then
            detectedBit <='0' ;
            state <= I;
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
                    detectedBit<='1';
                else
                    interrupcion <= '1';
                end if;
                when others => null;
            end case;
        end if;
    end process ; -- identifier
end arquitectura;