library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity portBlock_Detector is
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end portBlock_Detector;

architecture Behavioral of portBlock_Detector is
type state_type is (POTR, ABROPAR, PALABRA,DOSPUNTOS, INUT, ESPACIO, TIPO, CIERROPAR, PUNTOCOMA);
    signal state : state_type := POTR ;
    signal auxBit8, auxBit7, auxBit6, auxBit5,auxBit4,auxBit3,auxBit2,auxBit1,auxBit : std_logic;
    signal interruption: std_logic;
    
    component memCompare is
        port (
          charInput : in std_logic_vector(7 downto 0);
          address   : in integer range 0 to 30 ;
          isCorrect : out std_logic
        ) ;
    end component;
    
    component port_Detector
        port (
            clk: in std_logic;
            reset : in std_logic;
            bitInput : in std_logic_vector(7 downto 0);
            detectedBit : out std_logic 
        );
    end component;

    component bit_Detector
        port (
            clk: in std_logic;
            reset : in std_logic;
            bitInput : in std_logic_vector(7 downto 0);
            detectedBit : out std_logic 
        );
    end component;

    component end_Detector
        port (
            clk: in std_logic;
            reset : in std_logic;
            bitInput : in std_logic_vector(7 downto 0);
            detectedBit : out std_logic
        );
    end component;

    component InOutDetection
        port (
            clk: in std_logic;
            reset : in std_logic;
            bitInput : in std_logic_vector(7 downto 0);
            detectedBit : out std_logic
        );
    end component;

    component palabras_Detector is
  	port (
    	clk: in std_logic;
    	reset : in std_logic;
    	bitInput : in std_logic_vector(7 downto 0);
    	detectedBit : out std_logic 
  	) ;
end component;

begin
    portDetec: port_Detector port map(clk,reset,bitInput,detectedBit=>auxBit);
    abroParentesis: memCompare port map(bitInput,27,isCorrect=>auxBit1);
    palabraas: palabras_Detector port map(clk,reset,bitInput,detectedBit=>auxBit2);
    puntos: memCompare port map(bitInput,29,isCorrect=>auxBit3);
    inOutDetec: InOutDetection port map(clk,reset,bitInput,detectedBit=>auxBit4);
    espacio1: memCompare port map(bitInput,26,isCorrect=>auxBit5);
    bitDetect: bit_Detector port map(clk,reset,bitInput,detectedBit=>auxBit6);
    cierroParentesis: memCompare port map(bitInput,28,isCorrect=>auxBit7);
    puntoyComa: memCompare port map(bitInput,30,isCorrect=>auxBit8);
    

    process (clk)
    begin   
        if(reset = '1' or interruption = '1') then 
        detectedBit <='0' ;
        elsif(rising_edge(clk)) then
            case state is


                when POTR =>
                detectedBit <='0' ;
                if(auxBit = '1') then state <=ABROPAR;
                else interruption <= '1';
                end if;


                when ABROPAR =>
                if(auxBit1 = '1') then state <=PALABRA;
                else interruption <= '1';
                end if;


                when PALABRA =>
                if(auxBit2 = '1') then state <=DOSPUNTOS ;
                else interruption <= '1';
                end if;

                when DOSPUNTOS =>
                if(auxBit3 = '1') then  state <=INUT;
                else interruption <= '1';
                end if;
    

                when INUT =>
                if(auxBit4 = '1') then state <=ESPACIO ;
                else interruption <= '1';
                end if; 


                when ESPACIO =>
                if(auxBit5 = '1') then state <=TIPO;
                else interruption <= '1';
                end if;
        
        
                when TIPO =>
                if(auxBit6 = '1') then state <=CIERROPAR ;
                else interruption <= '1';
                end if;


                when CIERROPAR =>
                if(auxBit7 = '1') then state <=PUNTOCOMA ;
                else interruption <= '1';
                end if;


                when PUNTOCOMA =>
                if(auxBit8 = '1') then detectedBit <='1' ;
                else interruption <= '1';
                end if;

                when others => NULL;
            end case;
        end if;
     end process;
end Behavioral ; -- Behavioral
