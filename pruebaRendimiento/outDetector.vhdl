library ieee;
use ieee.std_logic_1164.all;

entity OutDetection is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end entity;

architecture arquitectura of OutDetection is

	signal charO,charU,charT,charSpace:std_logic;
	signal interrupcion : std_logic :='0';

    type state_type is (O,U,T,Space);

    signal state : state_type := O ;

    component memCompare
    port (
    charInput : in std_logic_vector(7 downto 0);
    address   : in integer range 0 to 30 ;
    isCorrect : out std_logic
  ) ;
    end component;
begin
    compO : memCompare port map (bitInput,14,isCorrect=>charO); --0
    compU : memCompare port map (bitInput,20,isCorrect=>charU); --U
    compT : memCompare port map (bitInput,19,isCorrect=>charT); --T
    compSpace : memCompare port map (bitInput,26,charSpace);    --Space
    process( clk )
    begin
        if(reset='1' or interrupcion ='1') then
            detectedBit <='0' ;
            interrupcion <= '0';
            state <= O;
        elsif(rising_edge(clk)) then
            detectedBit<='0';
            case state is
                when O =>
                if(charO = '1') then
                    state <=U;
                end if;
                when U =>
                if(charU = '1')then
                    state<=space;
                end if;
                when T =>
                if(charT = '1')then
                    state <= Space;
                end if;
                when Space =>
                if(charSpace = '1')then
                    detectedBit <='1';
                    state <=O;
                end if;
                when others => interrupcion <= '1';
            end case;
        end if;
    end process ; -- identifier
end arquitectura;