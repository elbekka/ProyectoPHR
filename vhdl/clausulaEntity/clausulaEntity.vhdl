library ieee;
use ieee.std_logic_1164.all;

entity entityClaus is 
  port (
    clk: in std_logic;
    reset : in std_logic;
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic
  ) ;
end entity;

architecture behavioral of entityClaus is

  signal entDetected,finStr,isDetected,endDetected,charPuntoComa,charSpace,estadoAnt: std_logic := '0';
  signal estadoAc : integer := 0;
  type estado is (stringEntity1,stringChar,stringIs,stringEnd,stringEntity2,puntoComa);
  signal estado_ini,estado_sig: estado ;
  component entityDetection is
        port (
          clk: in std_logic;
          reset : in std_logic;
          bitInput : in std_logic_vector(7 downto 0);
          detectedBit : out std_logic
        ) ;
    end component;
  component CharDetector is
        port (
          clk: in std_logic;
          reset : in std_logic;
          bitInput : in std_logic_vector(7 downto 0);
          detectedBit : out std_logic -- '1' si ha detectado la secuencia.
        ) ;
    end component;
  component is_Detection is
        port (
          clk: in std_logic;
          reset : in std_logic;
          bitInput : in std_logic_vector(7 downto 0);
          detectedBit : out std_logic
        ) ;
    end component;
  component end_Detector is
    port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic
    ) ;
    end component;
  component memCompare is
    port (
      charInput : in std_logic_vector(7 downto 0);
      address   : in integer range 0 to 30 ;
      isCorrect : out std_logic
    ) ;
    end component;
begin
 entDetector : entityDetection port map (clk,reset,bitInput,entDetected);
 charDetect : CharDetector port map (clk,reset,bitInput,finStr);
 isDetector : is_Detection port map (clk,reset,bitInput,isDetected);
 endDetector : end_Detector port map(clk,reset,bitInput,endDetected);
 espacioCompare : memCompare port map(bitInput,26,charSpace);
 puntoCompare : memCompare port map (bitInput,30,charPuntoComa);
 process (clk , reset)
    begin   
     if(reset = '1') then 
     estado_ini <= stringEntity1;
     elsif(rising_edge(clk)) then
         estado_ini<=estado_sig;
     end if;
    end process;
 process (entDetected,endDetected,isDetected,charSpace,estado_ini,finStr,estadoAc)
     begin
      case estado_ini is
-------------------------------------------------------------------------------------------------
        when stringEntity1 =>
        estadoAc <= 1;
        detectedBit<='0';
        if(entDetected = '1' and finStr = '0') then
          estado_sig <=stringChar;
          elsif(estadoAnt = '1' and charPuntoComa ='1') then 
          detectedBit<= '1';
        elsif(finStr = '0' and entDetected = '0') then
              detectedBit<='0';
              estado_sig <=stringChar;
        else
            estado_sig <=stringEntity1;
            estadoAnt <='0';
        end if;
---------------------------------------------------------------------------------------------
        when stringChar =>
        estadoAc <= 2;    
        if(finStr = '0')then
          estado_sig<=stringIs ;
        else
          estado_sig <=stringChar;
        end if;
        -------------------------------------------------------------------------
        when stringIs =>
        estadoAc <= 3;
        if(isDetected = '1'and finStr= '0') then
            estado_sig <=stringEnd;
        elsif (finStr = '0' and isDetected = '0') then
                detectedBit<='0';
                estado_sig <=stringEnd;
        else
            estado_sig <=stringIs;
        end if;
----------------------------------------------------------------------------------------------
        when stringEnd=>
        estadoAc <= 4;
        if(endDetected = '1'and finStr = '0')then
            estado_sig<=stringEntity2;
              elsif (finStr = '0' and endDetected = '0') then
                detectedBit<='0';
                estado_sig <=stringEntity2;
        else
        estado_sig <=stringEnd;
        end if;
----------------------------------------------------------------------------------------------
        when stringEntity2 =>
        estadoAc <= 5;
        if(entDetected = '1'and finStr = '0')then
            estado_sig<= puntoComa;
        elsif (finStr = '0' and entDetected = '0') then
                detectedBit<='0';
                estado_sig <=puntoComa;
        else
        estado_sig <=stringEntity2;
        end if;
------------------------------------------------------------------------------------------------
        when puntoComa =>
        estadoAc<=6;
        if(charPuntoComa = '1')then
              detectedBit <= '1';
              estadoAnt <= '1';
        elsif (finStr='1') then
              estado_sig <= puntoComa;
        else
              estado_sig <= StringEntity1;
              
        end if;

    end case;
     end process;
end behavioral ; -- behavioral