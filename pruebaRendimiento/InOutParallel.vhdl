library ieee;
use ieee.std_logic_1164.all;

entity InOutParallel is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end entity;

architecture arquitectura of InOutParallel is

	signal stringIn,stringOut:std_logic;
	signal interrupcion : std_logic :='0';

    component InDetection is
        port (
         clk: in std_logic;
         reset : in std_logic;
         bitInput : in std_logic_vector(7 downto 0);
         detectedBit : out std_logic -- '1' si ha detectado la secuencia.
        ) ;
    end component;
    component OutDetection is
        port (
          clk: in std_logic;
          reset : in std_logic;
          bitInput : in std_logic_vector(7 downto 0);
          detectedBit : out std_logic -- '1' si ha detectado la secuencia.
        ) ;
      end component;
begin
    
compIn : InDetection port map (clk,reset,bitInput,stringIn); --In
compOut : OutDetection port map (clk,reset,bitInput,stringOut);--Out
    process( clk )
    begin
        if(reset='1' or interrupcion ='1') then
            detectedBit <='0' ;
            interrupcion <='0';
        elsif(rising_edge(clk)) then
            detectedBit<='0';
            if(stringIn='1' or stringOut='1') then 
                detectedBit <= stringIn or stringOut;
            else 
                interrupcion <= '1';
            end if;
        end if;
    end process ; -- identifier
end arquitectura;